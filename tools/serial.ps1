<#
  serial.ps1 - open the N32WB033 debug console (USART1 -> NS-Link VCP) in this terminal.

  Usage (from the project root, in any terminal):
    powershell -NoProfile -ExecutionPolicy Bypass -File tools\serial.ps1
    powershell -NoProfile -ExecutionPolicy Bypass -File tools\serial.ps1 -Port COM14 -Baud 115200
    powershell -NoProfile -ExecutionPolicy Bypass -File tools\serial.ps1 -Seconds 5   # capture only

  Interactive mode reads stdin from a background .NET thread, so it works even when
  PowerShell's Console.KeyAvailable is unavailable (VSCode/ConPTY, piped stdin).
  Ctrl+C quits. Auto-detects the NS-Link VCP (USB VID_19F5 PID_3106 MI_00)
  when -Port is omitted.
#>
param(
    [string]$Port = "",
    [int]$Baud = 115200,
    [int]$Seconds = 0
)

if (-not $Port) {
    # Registry is more reliable than WMI for this composite device.
    $base = 'HKLM:\SYSTEM\CurrentControlSet\Enum\USB\VID_19F5&PID_3106&MI_00'
    $children = Get-ChildItem $base -ErrorAction SilentlyContinue
    foreach ($c in $children) {
        if ($Port) { break }
        $pn = (Get-ItemProperty -Path (Join-Path $c.PSPath 'Device Parameters') -ErrorAction SilentlyContinue).PortName
        if ($pn) { $Port = $pn }
    }
}
if (-not $Port) {
    Write-Host "NS-Link virtual COM port not found. Pass -Port COMx." -ForegroundColor Red
    exit 1
}

[Console]::Error.WriteLine(("== {0} @ {1} 8N1, Ctrl+C to quit ==" -f $Port, $Baud))

if ($Seconds -gt 0) {
    # ---- read-only capture for a fixed time ----
    $sp = New-Object System.IO.Ports.SerialPort $Port, $Baud, `
        ([System.IO.Ports.Parity]::None), 8, ([System.IO.Ports.StopBits]::One)
    $sp.Handshake = [System.IO.Ports.Handshake]::None
    try {
        $sp.Open()
    } catch {
        Write-Host ("Cannot open {0}: {1}" -f $Port, $_.Exception.Message) -ForegroundColor Red
        Write-Host "Hint: check the NS-Link USB cable; 'NSpyocd list' should show a probe." -ForegroundColor DarkGray
        exit 1
    }

    $stdout = [Console]::OpenStandardOutput()
    $buf = New-Object byte[] 4096
    try {
        $deadline = (Get-Date).AddSeconds($Seconds)
        while ((Get-Date) -lt $deadline) {
            $n = $sp.BytesToRead
            while ($n -gt 0) {
                $take = [Math]::Min($n, $buf.Length)
                $r = $sp.Read($buf, 0, $take)
                $stdout.Write($buf, 0, $r)
                $stdout.Flush()
                $n = $sp.BytesToRead
            }
            Start-Sleep -Milliseconds 10
        }
    } finally {
        if ($sp.IsOpen) { $sp.Close() }
    }
    exit 0
}

# ---- interactive: stdin -> serial, serial -> stdout ----
# Console.KeyAvailable is unreliable under ConPTY/piped stdin, so a background
# .NET thread does a blocking stdin read and forwards bytes to the serial port.
Add-Type -TypeDefinition @'
using System;
using System.IO;
using System.IO.Ports;
using System.Runtime.InteropServices;
using System.Threading;

public static class SerialConsole
{
    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern IntPtr GetStdHandle(int nStdHandle);
    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool GetConsoleMode(IntPtr h, out uint mode);
    [DllImport("kernel32.dll", SetLastError = true)]
    private static extern bool SetConsoleMode(IntPtr h, uint mode);

    private const int STD_INPUT_HANDLE = -10;
    private const uint ENABLE_PROCESSED_INPUT = 0x0001;
    private const uint ENABLE_LINE_INPUT = 0x0002;
    private const uint ENABLE_ECHO_INPUT = 0x0004;

    public static int Run(string portName, int baud)
    {
        SerialPort sp = new SerialPort(portName, baud, Parity.None, 8, StopBits.One);
        sp.Handshake = Handshake.None;
        try { sp.Open(); }
        catch (Exception ex)
        {
            Console.Error.WriteLine("Cannot open " + portName + ": " + ex.Message);
            Console.Error.WriteLine("Hint: check the NS-Link USB cable; 'NSpyocd list' should show a probe.");
            return 1;
        }

        // If stdin is a real console, switch it to raw: no line buffering,
        // no local echo (the firmware echoes), but keep Ctrl+C working.
        // The console is shared with the parent shell, so restore the mode
        // on every exit path.
        IntPtr hIn = GetStdHandle(STD_INPUT_HANDLE);
        uint oldMode = 0;
        bool haveMode = GetConsoleMode(hIn, out oldMode);
        if (haveMode)
        {
            SetConsoleMode(hIn, (oldMode & ~(ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT)) | ENABLE_PROCESSED_INPUT);
            Console.CancelKeyPress += delegate(object s, ConsoleCancelEventArgs e)
            {
                e.Cancel = true;
                SetConsoleMode(hIn, oldMode);
                Environment.Exit(0);
            };
        }

        Stream stdin = Console.OpenStandardInput();
        Stream stdout = Console.OpenStandardOutput();

        Thread reader = new Thread(delegate()
        {
            byte[] buf = new byte[256];
            bool esc = false;
            while (true)
            {
                int n;
                try { n = stdin.Read(buf, 0, buf.Length); }
                catch { break; }
                if (n <= 0) break;

                for (int i = 0; i < n; i++)
                {
                    byte c = buf[i];
                    if (esc)
                    {
                        // swallow an ESC [ ... / ESC O ... sequence
                        if (c >= 0x40 && c <= 0x7E) esc = false;
                        continue;
                    }
                    if (c == 0x1B) { esc = true; continue; }
                    if (c == 0x03)                                   // Ctrl+C
                    {
                        if (haveMode) SetConsoleMode(hIn, oldMode);
                        Environment.Exit(0);
                        return;
                    }
                    if ((c >= 0x20 && c <= 0x7E) || c == 0x0D || c == 0x08 || c == 0x7F)
                    {
                        try { sp.Write(new byte[] { c }, 0, 1); }
                        catch { return; }
                    }
                }
            }
        });
        reader.IsBackground = true;
        reader.Start();

        byte[] rx = new byte[4096];
        try
        {
            while (true)
            {
                int n = sp.Read(rx, 0, rx.Length);
                stdout.Write(rx, 0, n);
                stdout.Flush();
            }
        }
        catch
        {
            // port closed or Ctrl+C
        }
        finally
        {
            if (haveMode) SetConsoleMode(hIn, oldMode);
            try { sp.Close(); } catch { }
        }
        return 0;
    }
}
'@

exit ([SerialConsole]::Run($Port, $Baud))

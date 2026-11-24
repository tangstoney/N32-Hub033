<#
  flash.ps1 - build (optional) and flash the N32WB033 over the NS-Link probe.

  Everything it needs is local: no network, no N32Studio, no cloud.

  Usage (from the project root):
    powershell -NoProfile -ExecutionPolicy Bypass -File tools\flash.ps1
    powershell -NoProfile -ExecutionPolicy Bypass -File tools\flash.ps1 -BuildFirst
    powershell -NoProfile -ExecutionPolicy Bypass -File tools\flash.ps1 -DryRun
    powershell -NoProfile -ExecutionPolicy Bypass -File tools\flash.ps1 -Hex path\to\other.hex

  Options:
    -BuildFirst   run `make -j8` before flashing
    -NoReset      do not reset the target after programming
    -DryRun       print the exact NSpyocd commands and exit
    -Sdk <dir>    override the SDK root (default below)
#>
param(
    [string]$Hex = "",
    [string]$Sdk = "D:\Tangshi\Project\N32Demo\_sdk\NSING.N32WB033_Library.1.0.1",
    [switch]$BuildFirst,
    [switch]$NoReset,
    [switch]$DryRun
)

$project = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
if (-not $Hex) { $Hex = Join-Path $project "build\rd91_hub033.hex" }

$dfu   = Join-Path $Sdk "utilities\dfu"
$pyocd = Join-Path $dfu "NSpyocd\NSpyocd.exe"
$cfg   = Join-Path $dfu "NSUtil\config.yaml"

if (-not (Test-Path $pyocd)) {
    Write-Host "NSpyocd not found: $pyocd" -ForegroundColor Red
    exit 1
}
if (-not (Test-Path $Hex)) {
    Write-Host "hex not found: $Hex  (run a build first)" -ForegroundColor Red
    exit 1
}

if ($BuildFirst) {
    Write-Host "== make -j8 =="
    Push-Location $project
    make -j8
    $rc = $LASTEXITCODE
    Pop-Location
    if ($rc -ne 0) {
        Write-Host "build failed (rc=$rc)" -ForegroundColor Red
        exit $rc
    }
}

$loadArgs = @("load", $Hex, "-t", "n32wb033", "-M", "pre-reset", "--config=$cfg")
$resetArgs = @("reset", "-t", "n32wb033", "--config=$cfg")

Write-Host "== probe =="
& $pyocd list

if ($DryRun) {
    Write-Host ("`"{0}`" {1}" -f $pyocd, ($loadArgs -join " "))
    if (-not $NoReset) { Write-Host ("`"{0}`" {1}" -f $pyocd, ($resetArgs -join " ")) }
    exit 0
}

Write-Host "== load $Hex =="
& $pyocd @loadArgs
if ($LASTEXITCODE -ne 0) {
    Write-Host "load failed (rc=$LASTEXITCODE)" -ForegroundColor Red
    exit $LASTEXITCODE
}

if (-not $NoReset) {
    Write-Host "== reset =="
    & $pyocd @resetArgs
}

Write-Host "done."

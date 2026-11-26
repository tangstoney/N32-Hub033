#!/usr/bin/env bash
# rd91_hub033 WSL/Linux build CI
#
# Usage:
#   bash ci/build.sh
#   SDK_ROOT=/path/to/NSING.N32WB033_Library.1.0.1 bash ci/build.sh
#
# Build-only: flashing/serial are Windows-only (tools/*.ps1 + NSpyocd).

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SDK_ROOT="${SDK_ROOT:-/mnt/d/Tangshi/Project/N32Demo/_sdk/NSING.N32WB033_Library.1.0.1}"
JOBS="${JOBS:-$(nproc)}"

if ! command -v arm-none-eabi-gcc >/dev/null 2>&1; then
    echo "ERROR: arm-none-eabi-gcc not found. Run: bash ci/bootstrap-wsl.sh" >&2
    exit 2
fi
if [ ! -d "$SDK_ROOT" ]; then
    echo "ERROR: SDK_ROOT not found: $SDK_ROOT" >&2
    echo "Set SDK_ROOT=/path/to/NSING.N32WB033_Library.1.0.1" >&2
    exit 2
fi

cd "$ROOT"

# IMPORTANT: remove build/ entirely, not just `make clean`.
# A build/ produced on Windows contains .d files with D:/ paths; GNU make on
# Linux treats the colon as "multiple target patterns" and stops.
rm -rf build

make -j"$JOBS" SDK_ROOT="$SDK_ROOT"

for f in build/rd91_hub033.elf build/rd91_hub033.hex build/rd91_hub033.bin build/rd91_hub033.map; do
    if [ ! -f "$f" ]; then
        echo "ERROR: missing $f" >&2
        exit 1
    fi
done

SIZE_LINE="$(arm-none-eabi-size build/rd91_hub033.elf | awk 'NR==2 {print $1, $2, $3}')"
read -r TEXT DATA BSS <<< "$SIZE_LINE"
FLASH=$((TEXT + DATA))
RAM=$((DATA + BSS))

echo "size: text=$TEXT data=$DATA bss=$BSS flash=$FLASH ram=$RAM"

# Budget: 512KB flash; 48KB app RAM (BLE stack owns the lower 16KB at 0x20000000).
if [ "$FLASH" -gt 524288 ]; then
    echo "ERROR: flash budget exceeded" >&2
    exit 1
fi
if [ "$RAM" -gt 49152 ]; then
    echo "ERROR: RAM budget exceeded" >&2
    exit 1
fi

echo "CI OK"

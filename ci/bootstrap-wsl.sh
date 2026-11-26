#!/usr/bin/env bash
# Install the WSL/Linux build toolchain for rd91_hub033.
# Tested on Ubuntu 22.04 (WSL2).
set -euo pipefail

sudo apt-get update
sudo apt-get install -y build-essential gcc-arm-none-eabi libnewlib-arm-none-eabi

echo "toolchain:"
arm-none-eabi-gcc --version | head -1
make --version | head -1
arm-none-eabi-gcc -print-file-name=nano.specs

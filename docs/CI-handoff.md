# rd91_hub033 WSL CI 交接说明

## 1. 目标与范围

在 **WSL2（Ubuntu 22.04）** 里用一条命令完成 N32WB033 固件构建，产出 `elf/hex/bin/map`，并检查 Flash/RAM 预算。

**只做构建。** 烧录和串口是 Windows 专用工具（`tools/flash.ps1`、`tools/serial.ps1`、NSpyocd），CI 不执行、也不依赖它们。

- 仓库：<https://github.com/tangstoney/N32-Hub033>
- 固件目录：仓库根目录（`rd91_hub033`）
- 芯片：N32WB033（Cortex-M0+）
- BLE：SDK 16-bit RDTSS 改为 `0xFFE0/FFE1/FFE2`

## 2. 已验证环境与结果

- WSL2 Ubuntu 22.04
- `arm-none-eabi-gcc 10.3.1`（Ubuntu 包 `gcc-arm-none-eabi`）
- `make 4.3`
- `nano.specs` 来自 `libnewlib-arm-none-eabi`
- 构建命令：`bash ci/build.sh`
- 当前结果：

```text
size: text=43216 data=120 bss=4524 flash=43336 ram=4644
CI OK
```

说明：Windows 侧 N32Studio 工具链构建约 `text=39136`，差 ~4KB 来自 newlib/libc 版本差异，属正常；CI 只做预算检查，不要求和 Windows 构建逐字节一致。

## 3. 依赖与路径

| 项 | 说明 |
|---|---|
| SDK | `NSING.N32WB033_Library.1.0.1`，**不在仓库里**，必须另外提供 |
| 本机 SDK 路径 | `/mnt/d/Tangshi/Project/N32Demo/_sdk/NSING.N32WB033_Library.1.0.1` |
| SDK 覆盖 | CI 用环境变量 `SDK_ROOT`；Makefile 默认是 Windows 路径 `D:/...`，Linux 下必须覆盖 |
| 工具链安装 | `bash ci/bootstrap-wsl.sh` |
| 仓库内自带 | `src/ble/rom_symbols.s`、`src/ble/app_user_config.h`、`src/ble/rwapp_config.h`、`n32wb033_flash.ld`、`Makefile` |
| 不提交 | `build/`（`.gitignore` 已忽略） |

## 4. 一键跑通

```bash
# 1) 安装工具链（只需一次）
cd /mnt/d/Tangshi/Programs/Hqvt/rd91/firmware/rd91_hub033
bash ci/bootstrap-wsl.sh

# 2) 构建
bash ci/build.sh

# 或指定 SDK：
SDK_ROOT=/path/to/NSING.N32WB033_Library.1.0.1 bash ci/build.sh
```

期望：

- 退出码 `0`
- `build/rd91_hub033.elf/.hex/.bin/.map` 都存在
- 打印 `size: ...` 和 `CI OK`

## 5. 必须保留的几个坑

1. **构建前必须 `rm -rf build`，不能只 `make clean`。**
   Windows 上生成的 `build/*.d` 含 `D:/...` 路径，GNU make 在 Linux 下会报
   `multiple target patterns. Stop.`。`ci/build.sh` 已经显式删除 `build/`。
2. **`SDK_ROOT` 必须是 Linux 路径**（`/mnt/d/...`），不能是 `D:/...`。
3. **只装 `gcc-arm-none-eabi` 不够**：`nano.specs` 在 `libnewlib-arm-none-eabi` 里。
4. **不要复用 Windows 的 build 目录**；CI 从干净目录开始。
5. **SDK 头文件的 `multi-line comment` 警告可忽略**，不是 error。
6. 如果在 `root` 或其他用户下跑过，`build/` 可能属主不同；普通用户遇到 `rm -rf build` 权限问题时，先 `sudo rm -rf build` 一次。
7. `Flash ≤ 512KB`、应用 `RAM ≤ 48KB`；BLE 栈固定占 `0x20000000–0x20003FFF` 的 16KB，不在应用链接区。

## 6. 验收标准

- 干净 clone + SDK + 工具链，`bash ci/build.sh` 一次通过；
- 无 `error:`；SDK 的注释警告不算失败；
- 四个产物存在；
- `size` 输出且 Flash/RAM 在预算内；
- 不修改业务代码和 SDK；不提交 `build/`；不执行 Windows 的 `tools/*.ps1`。

## 7. 交给 AI 的任务描述（可直接复制）

```text
你是嵌入式 GCC 项目的 CI 工程师。仓库：https://github.com/tangstoney/N32-Hub033

目标：在 WSL2 Ubuntu 22.04 里，用 ci/bootstrap-wsl.sh + ci/build.sh 一键构建
N32WB033 固件，产出 elf/hex/bin/map，并做 Flash/RAM 预算检查。
只做构建，不烧录、不跑串口。

约束：
- SDK 不在仓库里：NSING.N32WB033_Library.1.0.1，用环境变量 SDK_ROOT 指定；
  Makefile 默认是 Windows 路径 D:/...，Linux 下必须覆盖。
- 构建前必须 rm -rf build（Windows 生成的 .d 含 D:/ 路径，会让 Linux make
  报 multiple target patterns）。
- 工具链：Ubuntu 22.04 的 gcc-arm-none-eabi 10.3.1 + libnewlib-arm-none-eabi；
  nano.specs 必须存在。
- 不要修改业务代码或 SDK；不要提交 build/；不要执行 tools/*.ps1。

请：
1) 检查/补齐 ci/build.sh、ci/bootstrap-wsl.sh；
2) 在干净环境跑通，贴出 arm-none-eabi-size 输出和 CI OK；
3) 如遇环境问题，给最小修改和原因。

验收：bash ci/build.sh 退出 0，四个产物存在，Flash ≤512KB，RAM ≤48KB。
```

## 8. 文件清单

- `ci/bootstrap-wsl.sh`：安装 WSL 构建工具链
- `ci/build.sh`：干净构建 + 产物检查 + 大小预算
- `docs/CI-handoff.md`：本文
- `Makefile`、`n32wb033_flash.ld`、`src/`：固件源码
- `SDK_ROOT`：外部 SDK，不在仓库

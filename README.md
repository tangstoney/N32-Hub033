# rd91_hub033 — N32WB033 单片 bring-up 固件

> 目标板：`N32WB033CEQ7_STB V1.0` 的 **U1（N32WB033CEQ7）**，U2 是 NS-LINK，不动。
> 阶段：**单片 bring-up**，G452 到货前先把 033 上的外设和链路跑通。
> 编译：**GCC（N32Studio 自带 arm-none-eabi-gcc）**，不需要 Keil。
> 引脚分配依据：`docs/033-单片bring-up-引脚与任务.md`。

---

## 1. 这一版覆盖了什么

| 编号 | 任务 | 本版状态 | 验证命令 |
|---|---|---|---|
| B01 | 编译 + 烧写 + 点灯 | ✅ 已实现 | 上电 LED1 闪 3 次后常亮 |
| B02 | UART printf | ✅ 已实现 | 串口 115200 有 banner 和 `> ` |
| B04 | 按键 | ✅ 已实现（轮询） | `key` |
| B06 | 雷达 MS24 OUT | ✅ 已实现（双边沿 EXTI） | `radar` / `radar watch` |
| B07 | 语音 HM01 | ✅ 已实现（UART + 帧解析） | `voice play 8` / `voice idx` |
| B08 | 段码屏 3×TM1621B | ✅ 已实现（移植已验证驱动） | `lcd test` / `lcd all` |
| B05 | IMU QMI8A01z | ⏳ **模块未到货** | `imu` 返回 not found |
| B09 | 报警业务 | ✅ 已实现 | 雷达有人 → `voice loop 8`，无人 → `voice stop` |
| B10 | 充电 SGM41512 | ✅ I2C 驱动 + 状态/故障 | `chg` / `chg reg 0x0B` |
| B03 | BLE 广播/连接 | ✅ M1：`N32-Hub` + `0xFFE0/E1/E2` | nRF Connect 写 FFE2 → FFE1 回显 |

---

## 1.1 目录结构

```text
src/
  main.c          入口、主循环调度（console/voice/radar/alarm）
  app/            业务层：alarm.c（雷达/烟感/PANIC → 循环语音）
  drivers/        设备驱动：board / radar / voice / seg_lcd / imu
  services/       控制台、1ms tick、printf 重定向
  ble/            BLE 配置（app_user_config.h / rwapp_config.h / rom_symbols.s）
```

依赖方向：`app → services/drivers → SDK`。驱动只上报事件和提供 API，
不反向调用业务；ISR 只做计数/入队，主循环 `*_poll()` 合并。

---

## 2. 编译

```bash
cd D:/Tangshi/Programs/Hqvt/rd91/firmware/rd91_hub033
make -j8                # 调试版 -O1
make release=y -j8      # 体积版 -Os
make clean
```

工具链来自 `C:\Users\tangshi\.n32studio\Toolchain`，已在 PATH 里；否则先设
`SDK_ROOT` 和 `PATH`（见 Makefile 顶部）。

产物：

```
build/rd91_hub033.elf / .hex / .bin / .map
```

当前占用（`make -j8`）：

| text | data | bss | Flash 合计 | RAM 合计 |
|---|---|---|---|---|
| 39,136 | 120 | 4,524 | ~39.3 KB / 512 KB (7.7%) | ~4.6 KB / 48 KB (9.7%) |

> 已链接 BLE ROM 协议栈（`USE_BLE_ROM_API` + `src/ble/rom_symbols.s`）。
> BLE 栈固定占用 `0x20000000–0x20003FFF` 的 16KB，应用 RAM 从 `0x20004000`
> 起 48KB。协议栈初始化和 `0xFFE0` 服务接入后，Flash/RAM 会再增长。
> 链接用 newlib-nano；`printf` 不支持 `%f`。
> WSL CI 用 Ubuntu 的 `gcc-arm-none-eabi 10.3.1` 构建，`text≈43.2KB`（newlib 差异），
> 预算仍远低于 512KB；见 `docs/CI-handoff.md`。

---

## 3. 烧写

```bat
cd /d D:\Tangshi\Project\N32Demo\_sdk\NSING.N32WB033_Library.1.0.1\utilities\dfu

:: 确认探针
NSpyocd\NSpyocd.exe list

:: 烧写（-M pre-reset：复位前连接）
NSpyocd\NSpyocd.exe load ^
  D:\Tangshi\Programs\Hqvt\rd91\firmware\rd91_hub033\build\rd91_hub033.hex ^
  -t n32wb033 -M pre-reset

:: 复位
NSpyocd\NSpyocd.exe reset -t n32wb033
```

硬件前提：
- **J10 两个跳线短接**（否则 U1/U2 没电）
- **J3 的 SWDIO/SWCLK 两对短接**（U2 通过 SWD 烧 U1）
- **J3 的 UART 两对也短接**（否则串口看不到输出）

> ⚠️ 本镜像链在 `0x01000000`，是**台架直跑镜像，会覆盖 MasterBoot**。
> 要做 OTA 必须把链接基址改成 `0x01002000`、长度 ≤ `0x3B000`，见 `docs/033-OTA-操作手册.md`。

---

## 4. 串口控制台

USART1（PB6/PB7）→ 板上 U2 的 USB 虚拟串口，**115200 8N1**。

> 控制台运行时的输出统一用英文/ASCII：串口 log 会在 VSCode、PuTTY、日志文件
> 之间流转，避免中文在 GBK/UTF-8 终端里乱码。代码注释和本文档仍用中文。

```
========== rd91_hub033 bring-up ==========
 help              - this list
 ver               - version / tick
 led <1|2> <on|off|toggle>
 leds              - LED state
 key               - read key levels
 radar             - radar state + edge count
 radar watch       - watch for 10s
 voice play <idx>  - play track
 voice stop        - stop
 voice loop <idx|off> - loop track / loop off
 voice vol <0-31>  - volume
 voice idx         - query current track
 voice stat        - frame / error counters
 voice count       - query flash audio count
 lcd fill <0-F>    - fill all segments
 lcd all           - all on
 lcd clear         - clear
 lcd num <chip> <digit>
 lcd test          - segment self-test
 blk <on|off>      - backlight
 imu               - probe IMU (not found if absent)
 alarm             - show alarm state
 alarm on|off      - arm / disarm
 alarm smoke on|off - simulate smoke input
 alarm panic on|off - simulate remote panic
 chg               - charger status + key regs
 chg init          - re-init/config SGM41512
 chg reg <hex>     - read one register
 chg set <hex> <hex> - write one register
 chg scan          - scan I2C1 bus
 chg cur <mA>      - set charge current (nearest code)
 chg in <mA>       - set input current limit
 log <on|off>      - async sensor/voice logs
=========================================
```

> `voice play/stop/loop/vol` 的 `sent` 只表示帧已发到 USART2；HM01 随后会回一帧，
> 控制台打印成 `[voice] ack A0 -> 0 (OK)` / `-> 2 (no such file)` 这样的行。
> `play` / `loop` 的 idx 是模块内的 **16 位编号（2 字节大端），不是文件名**；
> 超出模块内的音频条数时会回 `2`，当前曲目不会改变。
> `voice count` 查询模块里实际有多少条音频；`voice idx` 的 `current index` 是模块自己的当前曲目。

---

## 4.1 BLE（M1：N32-Hub + FFE0/E1/E2）

| 项 | 值 |
|---|---|
| 广播名 | `N32-Hub` |
| 服务 | `0xFFE0` |
| Notify（设备→手机） | `0xFFE1` |
| Write（手机→设备） | `0xFFE2`（Write / Write Without Response） |

手机 nRF Connect：

1. 扫描并连接 `N32-Hub`
2. 展开服务 `FFE0`
3. 打开 `FFE1` 的 notify（点三个下箭头）
4. 往 `FFE2` 写几个字节
5. 板子原样回显到 `FFE1`，串口同时打印 `[ble] rx N: ..`

启动时串口应出现：

```text
[ble] init: name=N32-Hub, service=FFE0
[ble] stack ready
```

M1 只做透传回显；A5/A6 协议和 HELLO/STATUS 在 M2。

---

## 4.2 充电管理 SGM41512（I2C1）

| 项 | 值 |
|---|---|
| I2C | I2C1，**PA1=SCL / PA0=SDA**，AF4，400kHz |
| 地址 | 7-bit `0x1A`（8-bit 写 0x34 / 读 0x35） |
| 上拉 | SDA/SCL 4.7k 到 3.3V（模块自带就不用外加） |
| 共地 | 必须 |

默认配置：输入限流 2A、充电 1.5A、4.208V、看门狗关闭、OVP 14V。

```text
chg                  # 状态 + 故障 + 关键寄存器
chg init             # 重新初始化/写默认配置
chg reg 0x0B         # 读器件信息（SGM41512S PN=1111 -> 0x78 左右）
chg set 0x02 0xB4    # 写充电电流（例：0xB4 = 1980mA）
chg scan             # 扫 I2C1（EVKIT 应看到 0x1A）
chg cur 1500         # 充电电流，选最近档并回报实际值（64 档，非线性）
chg in 2000          # 输入限流，100mA 一档（线性）
log off / log on     # 关/开雷达/语音/报警/充电异步日志
```

状态：`no-input / charging / done / disabled / fault`；故障位 `wd / boost / chrg / bat / ntc`。
`charger_poll()` 每 500ms 读一次，状态变化打印 `[chg] ...`；业务侧可直接用
`charger_is_charging()` / `charger_is_fault()`。

> 充电与 IMU 共用 I2C1 总线：充电 0x1A，IMU 0x6A/0x6B，地址不冲突。

> **2026-11-25 当前状态**：`N32-Hub` 广播/连接、FFE0/FFE1/FFE2 已通；
> FFE2 写入 → FFE1 notify 回显已在手机验证（`[ble] write h=2` / `[ble] rx` / `[ble] notify`）。
> 下一步：M2 私有协议（A5/A6 + HELLO/STATUS/EVENT）。
> 充电 SGM41512 已读通（part=0x79）；EVKIT 的 I2C 上拉前提是 **JP7 拔掉、TP15 接 3.3V**。

---

## 5. 接线（本版实际用到的）

| 模块 | 033 引脚 | 说明 |
|---|---|---|
| 调试串口 | PB6(TX)/PB7(RX) | 板上已接 U2，115200 |
| LED1 / LED2 | PB0 / PA6 | 板载，免接线 |
| KEY1 / KEY2 / K4 | PB1 / PB2 / PB3 | 板载，10k 上拉 |
| **雷达 OUT** | **PA2** | 浮空输入 + 双边沿 EXTI；VCC 5V（板载 USB 5V），共地 |
| **语音 HM01** | **PB4(TX)→模块RX，PB5(RX)←模块TX** | USART2，AF3，115200；无 BUSY |
| **段码屏** | **PC0=DATA, PC1=WR, PC2/3/4=CS1/2/3, PC5=BLK** | VDD **3.3V**，不要 5V |
| **充电 SGM41512** | **PA1=SCL / PA0=SDA** | I2C1，AF4，400kHz，地址 0x1A；共地，4.7k 上拉 |
| IMU（未到） | PA0/PA1 + PC6 | I2C1 AF4，0x6A/0x6B |

---

## 6. 实现要点（改之前先看）

1. **SysTick 自己管**：`src/tick.c` 起 1ms 中断提供 `tick_ms()` / `delay_us()`。
   SDK 的 `bsp/src/delay.c` 是把 SysTick 当一次性延时用的（还会关 TICKINT），
   两者冲突，所以 **Makefile 里没有编译 delay.c**。要加回延时请用 `tick_delay_ms()`。
2. **段码屏时序**：TM1621B 在 3V 下时钟上限 300kHz，驱动用半周期 2us（250kHz）。
   `delay_us()` 借 SysTick 递减计数器实现，不需要额外定时器。
3. **雷达不重复上报**：ISR 只累加边沿计数，主循环 `radar_poll()` 读电平后合并成
   进入/清除事件；持续有人（电平不变）不会重复产生事件。上电时已有人会记为"已占用"，
   等回低后才准备下一次进入。
4. **语音节流 250ms**：HM01 帧间至少 200~300ms，`voice_send()` 内部做节流，
   太密的调用返回 `VOICE_ERR_BUSY`。
5. **RAM 48KB**：BLE 栈固定占用 `0x20000000–0x20003FFF`（16KB），应用从
   `0x20004000` 起 48KB；链接脚本已改，不要改回 64KB。
6. **IMU 只有探测桩**：`imu_read()` 恒返回 false。到货后按 `src/imu.c` 顶部注释
   的 7 步配置序列补全（寄存器定义和老驱动一致）。

---

## 7. 下一步

- **B03/B13 BLE（M1 已完成）**：`N32-Hub` 广播、16-bit `0xFFE0/FFE1(notify)/FFE2(write)`、
  写→notify 回显。M2：A5/A6 分片 + CRC8 + HELLO/STATUS；M3：Hub central（Fob/Smoke）。
- **B05 IMU**：模块到货后补 `imu.c` 的配置与采样。
- **B10 充电**：SGM41512 I2C 驱动、状态/故障已实现；业务侧先用
  `charger_is_charging()` / `charger_is_fault()`，BLE/UI 通知待接。
- **B09 报警业务**：已实现雷达条件 → `voice loop 8`、条件解除 → `voice stop`；
  `alarm on/off` 布防/撤防，`alarm smoke/panic on|off` 可模拟输入。
  注意：布防状态下报警业务占用语音口，手工测语音先 `alarm off`。

---

## 8. CI（WSL/Linux）

只做构建，不烧录。已验证 WSL2 Ubuntu 22.04 + `arm-none-eabi-gcc 10.3.1`：

```bash
bash ci/bootstrap-wsl.sh
bash ci/build.sh
```

SDK 不在仓库里，用 `SDK_ROOT` 指向 `NSING.N32WB033_Library.1.0.1`。
构建前必须 `rm -rf build`（Windows 生成的 `.d` 含 `D:/` 路径，Linux make 会报
`multiple target patterns`）。详见 [docs/CI-handoff.md](docs/CI-handoff.md)。

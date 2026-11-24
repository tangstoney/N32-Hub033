/**
 * @file    main.c
 * @brief   rd91_hub033 单片 bring-up 主循环
 *
 * 阶段目标（对应 docs/033-单片bring-up-引脚与任务.md）：
 *   B01 编译+烧写+点灯   -> 上电 LED1 快闪 3 次后常亮
 *   B02 UART printf      -> 串口 115200 有 banner 和 "> " 提示符
 *   B04 按键             -> help 里的 key 命令
 *   B06 雷达             -> radar / radar watch
 *   B07 语音             -> voice play/stop/loop/idx
 *   B08 段码屏           -> lcd test / lcd all
 *   B05 IMU              -> 未到货，imu 命令返回 not found
 *
 * 本轮不含 BLE：B03 用 master_slave_relay 的 GCC 工程单独验证。
 */
#include <stdio.h>
#include <stdbool.h>

#include "board.h"
#include "console.h"
#include "radar.h"
#include "voice.h"
#include "seg_lcd.h"
#include "imu.h"
#include "tick.h"
#include "retarget.h"
#include "alarm.h"
#include "ble_app.h"
#include "rwip.h"

#include "log.h"
#include "n32wb033.h"
#include "n32wb033_gpio.h"

int main(void)
{
    uint32_t i;

    /* 1) 节拍最早起，后面所有延时/超时都依赖它 */
    tick_init();

    /* 2) 调试串口 USART1(PB6/PB7)，接 STB 上 U2 的虚拟串口 */
    log_init();
    retarget_init();   /* GCC/newlib: printf -> _write -> fputc -> USART1 */
    tick_delay_ms(100U);

    printf("\r\n\r\n=== rd91_hub033 bring-up (%s %s) ===\r\n", __DATE__, __TIME__);

    /* 3) 板级：LED / 按键 / 背光 */
    board_init();

    /* B01：LED1 闪 3 次，作为"固件跑起来了"的可视证据 */
    for (i = 0U; i < 6U; i++) {
        board_led_toggle();
        tick_delay_ms(120U);
    }
    board_led1(true);

    /* 4) 各模块初始化 */
    radar_init();
    voice_init();
    seg_lcd_init();
    alarm_init();     /* 业务层：雷达条件成立时循环报警 */
    ble_app_init();   /* BLE：N32-Hub + 0xFFE0/FFE1/FFE2 */

    printf("radar: PA2 EXTI(both edges), initial state %s\r\n",
           radar_is_present() ? "present" : "absent");
    printf("voice: USART2 PB4(TX)/PB5(RX) 115200\r\n");
    printf("lcd  : 3xTM1621B PC0..PC5\r\n");

    /* 段码屏上电自检：全显 300ms 再清屏，确认三颗芯片都在 */
    seg_lcd_fill(0x0F);
    tick_delay_ms(300U);
    seg_lcd_fill(0x00);
    board_lcd_backlight(true);

    /* IMU 探测：未到货会打印 not found，不阻塞启动 */
    {
        uint8_t addr = 0U;
        if (imu_probe(&addr)) {
            printf("imu  : found @0x%02X\r\n", addr);
        } else {
            printf("imu  : not found (module not connected)\r\n");
        }
    }

    printf("\r\n");
    console_init();
    console_help();
    printf("> ");

    /* 5) 主循环：只做轮询，不阻塞 */
    for (;;) {
        radar_evt_t evt;

        console_poll();
        voice_poll();
        rwip_schedule();   /* 处理 BLE 协议栈消息 */

        evt = radar_poll();
        alarm_on_radar_event(evt);
        alarm_poll();

        if (evt == RADAR_EVT_PRESENT) {
            printf("\r\n[radar] present\r\n> ");
        } else if (evt == RADAR_EVT_ABSENT) {
            printf("\r\n[radar] absent\r\n> ");
        }
    }
}

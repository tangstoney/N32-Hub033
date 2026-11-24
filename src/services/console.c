/**
 * @file    console.c
 * @brief   串口命令行实现
 *
 * 轮询 USART1（非中断）读字符：bring-up 阶段数据量极小，
 * 轮询不会影响 BLE 时序，也避免与语音的 USART2 中断混在一起。
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "console.h"
#include "board.h"
#include "radar.h"
#include "voice.h"
#include "seg_lcd.h"
#include "imu.h"
#include "tick.h"
#include "alarm.h"
#include "n32wb033.h"
#include "n32wb033_usart.h"

#define CONSOLE_USART   USART1
#define LINE_MAX        64U

static char s_line[LINE_MAX];
static uint8_t s_len;

void console_init(void)
{
    s_len = 0U;
    s_line[0] = '\0';
}

void console_help(void)
{
    printf("\r\n========== rd91_hub033 bring-up ==========\r\n");
    printf(" help              - this list\r\n");
    printf(" ver               - version / tick\r\n");
    printf(" led <1|2> <on|off|toggle>\r\n");
    printf(" leds              - LED state\r\n");
    printf(" key               - read key levels\r\n");
    printf(" radar             - radar state + edge count\r\n");
    printf(" radar watch       - watch for 10s\r\n");
    printf(" voice play <idx>  - play track\r\n");
    printf(" voice stop        - stop\r\n");
    printf(" voice loop <idx|off> - loop track / loop off\r\n");
    printf(" voice vol <0-31>  - volume\r\n");
    printf(" voice idx         - query current track\r\n");
    printf(" voice stat        - frame / error counters\r\n");
    printf(" voice count       - query flash audio count\r\n");
    printf(" lcd fill <0-F>    - fill all segments\r\n");
    printf(" lcd all           - all on\r\n");
    printf(" lcd clear         - clear\r\n");
    printf(" lcd num <chip> <digit>\r\n");
    printf(" lcd test          - segment self-test\r\n");
    printf(" blk <on|off>      - backlight\r\n");
    printf(" imu               - probe IMU (not found if absent)\r\n");
    printf(" alarm             - show alarm state\r\n");
    printf(" alarm on|off      - arm / disarm\r\n");
    printf(" alarm smoke on|off - simulate smoke input\r\n");
    printf(" alarm panic on|off - simulate remote panic\r\n");
    printf("=========================================\r\n");
}

static int arg_int(const char *s, int def)
{
    if (s == NULL || *s == '\0') {
        return def;
    }
    return atoi(s);
}

static void cmd_led(char *a1, char *a2)
{
    int idx = arg_int(a1, 1);

    if (idx == 1) {
        if (a2 == NULL || strcmp(a2, "toggle") == 0) {
            board_led_toggle();
        } else if (strcmp(a2, "on") == 0) {
            board_led1(true);
        } else {
            board_led1(false);
        }
    } else {
        if (a2 == NULL || strcmp(a2, "toggle") == 0) {
            static bool st;
            st = !st;
            board_led2(st);
        } else if (strcmp(a2, "on") == 0) {
            board_led2(true);
        } else {
            board_led2(false);
        }
    }
}

static void cmd_lcd(char *a1, char *a2, char *a3)
{
    if (a1 == NULL) {
        printf("lcd: need an argument, see help\r\n");
        return;
    }

    if (strcmp(a1, "fill") == 0) {
        int v = (int)strtol(a2 ? a2 : "0", NULL, 16);
        seg_lcd_fill((uint8_t)(v & 0x0F));
        printf("lcd: fill 0x%X\r\n", v & 0x0F);
    } else if (strcmp(a1, "all") == 0) {
        seg_lcd_fill(0x0F);
        printf("lcd: all on\r\n");
    } else if (strcmp(a1, "clear") == 0) {
        seg_lcd_fill(0x00);
        printf("lcd: clear\r\n");
    } else if (strcmp(a1, "flush") == 0) {
        seg_lcd_flush();
        printf("lcd: flush\r\n");
    } else if (strcmp(a1, "num") == 0) {
        int chip = arg_int(a2, 0);
        int digit = arg_int(a3, 0);
        seg_lcd_put_digit(chip, 0, digit);
        seg_lcd_flush();
        printf("lcd: chip%d digit1 = %d\r\n", chip, digit);
    } else if (strcmp(a1, "test") == 0) {
        int chip;
        printf("lcd: per-chip self-test (all on -> clear)\r\n");
        for (chip = 0; chip < SEG_LCD_CHIP_CNT; chip++) {
            printf("  chip%d ...\r\n", chip);
            seg_lcd_fill(0x00);
            seg_lcd_fill_chip(chip, 0x0F);
            seg_lcd_flush();
            tick_delay_ms(800);
        }
        seg_lcd_fill(0x00);
        printf("lcd: self-test done\r\n");
    } else {
        printf("lcd: unknown subcommand %s\r\n", a1);
    }
}

static const char *voice_ret_str(voice_ret_t ret)
{
    switch (ret) {
    case VOICE_OK:          return "sent";
    case VOICE_ERR_ARG:     return "ERR_ARG";
    case VOICE_ERR_BUSY:    return "ERR_BUSY(250ms)";
    case VOICE_ERR_TIMEOUT: return "ERR_TIMEOUT";
    default:                return "ERR_UNKNOWN";
    }
}

static void cmd_voice(char *a1, char *a2)
{
    voice_ret_t ret;

    if (a1 == NULL) {
        printf("voice: need a subcommand, see help\r\n");
        return;
    }

    if (strcmp(a1, "play") == 0) {
        int idx = arg_int(a2, 8);
        ret = voice_play((uint16_t)idx);
        printf("voice: play %d -> %s\r\n", idx, voice_ret_str(ret));
    } else if (strcmp(a1, "stop") == 0) {
        ret = voice_stop();
        printf("voice: stop -> %s\r\n", voice_ret_str(ret));
    } else if (strcmp(a1, "loop") == 0) {
        if (a2 != NULL && strcmp(a2, "off") == 0) {
            ret = voice_loop_off();
            printf("voice: loop off -> %s\r\n", voice_ret_str(ret));
        } else {
            int idx = arg_int(a2, 8);
            ret = voice_loop((uint16_t)idx);
            printf("voice: loop %d -> %s\r\n", idx, voice_ret_str(ret));
        }
    } else if (strcmp(a1, "vol") == 0) {
        int vol = arg_int(a2, 20);
        ret = voice_set_volume((uint8_t)vol);
        printf("voice: vol %d -> %s\r\n", vol, voice_ret_str(ret));
    } else if (strcmp(a1, "idx") == 0) {
        uint16_t idx = 0U;
        ret = voice_query_index(&idx, 500U);
        if (ret == VOICE_OK) {
            printf("voice: current index = %u\r\n", idx);
        } else {
            printf("voice: query failed (%s)\r\n", voice_ret_str(ret));
        }
    } else if (strcmp(a1, "count") == 0) {
        uint16_t cnt = 0U;
        ret = voice_query_count(&cnt, 500U);
        if (ret == VOICE_OK) {
            printf("voice: audio count = %u\r\n", cnt);
        } else {
            printf("voice: count query failed (%s)\r\n", voice_ret_str(ret));
        }
    } else if (strcmp(a1, "stat") == 0) {
        printf("voice: good frames %lu, bad frames %lu\r\n",
               (unsigned long)voice_frame_count(),
               (unsigned long)voice_error_count());
    } else {
        printf("voice: unknown subcommand %s\r\n", a1);
    }
}

static void cmd_radar(char *a1)
{
    if (a1 != NULL && strcmp(a1, "watch") == 0) {
        uint32_t start = tick_ms();
        bool last = radar_is_present();

        printf("radar: watching 10s (wait for END)\r\n");
        while (!tick_elapsed(start, 10000U)) {
            radar_evt_t e = radar_poll();
            if (e == RADAR_EVT_PRESENT) {
                printf("  [%lu ms] present\r\n", (unsigned long)tick_ms());
            } else if (e == RADAR_EVT_ABSENT) {
                printf("  [%lu ms] absent\r\n", (unsigned long)tick_ms());
            }
            tick_delay_ms(10U);
        }
        printf("radar: END, last state %s\r\n", last ? "present" : "absent");
        return;
    }

    (void)radar_poll();   /* 先把挂起的边沿消费掉 */
    printf("radar: now %s, edge count %lu\r\n",
           radar_is_present() ? "present" : "absent",
           (unsigned long)radar_edge_count());
}

static void cmd_alarm(char *a1, char *a2)
{
    if (a1 == NULL) {
        printf("alarm: armed=%d radar=%s alarming=%d\r\n",
               alarm_is_armed() ? 1 : 0,
               radar_is_present() ? "present" : "absent",
               alarm_is_alarming() ? 1 : 0);
        return;
    }

    if (strcmp(a1, "on") == 0) {
        alarm_set_armed(true);
    } else if (strcmp(a1, "off") == 0) {
        alarm_set_armed(false);
    } else if (strcmp(a1, "smoke") == 0) {
        alarm_set_smoke(a2 != NULL && strcmp(a2, "on") == 0);
    } else if (strcmp(a1, "panic") == 0) {
        alarm_set_panic(a2 != NULL && strcmp(a2, "on") == 0);
    } else {
        printf("alarm: unknown subcommand %s\r\n", a1);
    }
}

void console_poll(void)
{
    /* 轮询取字节（USART1 由 log_init 配好，这里不重复初始化） */
    while (USART_GetFlagStatus(CONSOLE_USART, USART_FLAG_RXDNE) != RESET) {
        char c = (char)USART_ReceiveData(CONSOLE_USART);

        if (c == '\r' || c == '\n') {
            char *argv[4] = {0};
            int argc = 0;
            char *p = s_line;

            s_line[s_len] = '\0';
            printf("\r\n");

            /* 按空格切分，最多 4 段 */
            while (*p != '\0' && argc < 4) {
                while (*p == ' ') {
                    p++;
                }
                if (*p == '\0') {
                    break;
                }
                argv[argc++] = p;
                while (*p != '\0' && *p != ' ') {
                    p++;
                }
                if (*p != '\0') {
                    *p++ = '\0';
                }
            }

            if (argc > 0) {
                const char *cmd = argv[0];

                if (strcmp(cmd, "help") == 0) {
                    console_help();
                } else if (strcmp(cmd, "ver") == 0) {
                    printf("rd91_hub033 v0.1 (%s %s), tick=%lu ms\r\n",
                           __DATE__, __TIME__, (unsigned long)tick_ms());
                } else if (strcmp(cmd, "led") == 0) {
                    cmd_led(argv[1], argv[2]);
                } else if (strcmp(cmd, "leds") == 0) {
                    printf("led1=%d led2=%d\r\n",
                           board_led1_state() ? 1 : 0,
                           board_led2_state() ? 1 : 0);
                } else if (strcmp(cmd, "key") == 0) {
                    printf("KEY1(PB1)=%d KEY2(PB2)=%d KEY4(PB3)=%d (0=pressed)\r\n",
                           GPIO_ReadInputDataBit(BOARD_KEY1_PORT, BOARD_KEY1_PIN) ? 1 : 0,
                           GPIO_ReadInputDataBit(BOARD_KEY2_PORT, BOARD_KEY2_PIN) ? 1 : 0,
                           GPIO_ReadInputDataBit(BOARD_WAKE_PORT, BOARD_WAKE_PIN) ? 1 : 0);
                } else if (strcmp(cmd, "radar") == 0) {
                    cmd_radar(argv[1]);
                } else if (strcmp(cmd, "voice") == 0) {
                    cmd_voice(argv[1], argv[2]);
                } else if (strcmp(cmd, "lcd") == 0) {
                    cmd_lcd(argv[1], argv[2], argv[3]);
                } else if (strcmp(cmd, "blk") == 0) {
                    board_lcd_backlight(strcmp(argv[1] ? argv[1] : "on", "on") == 0);
                    printf("blk: %s\r\n", argv[1] ? argv[1] : "on");
                } else if (strcmp(cmd, "imu") == 0) {
                    uint8_t addr = 0U;
                    if (imu_probe(&addr)) {
                        printf("imu: found at 0x%02X, WHO_AM_I=0x05\r\n", addr);
                    } else {
                        printf("imu: not found (module absent or PA0/PA1 not wired)\r\n");
                    }
                } else if (strcmp(cmd, "alarm") == 0) {
                    cmd_alarm(argv[1], argv[2]);
                } else {
                    printf("unknown command: %s (type help)\r\n", cmd);
                }
            }

            s_len = 0U;
            s_line[0] = '\0';
            printf("> ");

        } else if (c == 0x08 || c == 0x7F) {   /* 退格 */
            if (s_len > 0U) {
                s_len--;
                printf("\b \b");
            }
        } else if (s_len < (LINE_MAX - 1U)) {
            s_line[s_len++] = c;
            putchar(c);
        }
    }
}

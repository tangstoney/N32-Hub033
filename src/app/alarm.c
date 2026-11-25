/**
 * @file    alarm.c
 * @brief   报警业务状态机（移植自 ESP32 已验证的 alarm.c）
 *
 * 策略：
 *   条件 = 布防 && (雷达有人 || 烟感 || 遥控 PANIC)
 *   条件成立且未在循环 -> 先发 0xAF 01 开单曲循环，再发 0xA0 + 2 字节索引
 *   条件解除且正在循环 -> 发 0xAB 停止
 *
 * 注意：voice_loop() 内部会等 300ms 再发播放命令，所以这里会阻塞主循环
 * 约 300ms；和 ESP32 版本的 vTaskDelay 行为一致，属于预期。
 */
#include <stdio.h>
#include "alarm.h"
#include "radar.h"
#include "voice.h"
#include "tick.h"
#include "logctl.h"

#define ALARM_TRACK        VOICE_IDX_ALARM   /* 8 */
#define ALARM_POLL_MS      20U

static bool s_armed = true;
static bool s_present;
static bool s_smoke;
static bool s_panic;
static bool s_looping;
static uint32_t s_last_poll;

static bool alarm_condition(void)
{
    return s_present || s_smoke || s_panic;
}

void alarm_init(void)
{
    s_armed    = true;
    s_present  = radar_is_present();
    s_smoke    = false;
    s_panic    = false;
    s_looping  = false;
    s_last_poll = tick_ms();

    printf("[alarm] armed, radar=%s, loop track %u\r\n",
           s_present ? "present" : "absent", (unsigned)ALARM_TRACK);
}

void alarm_on_radar_event(radar_evt_t evt)
{
    if (evt == RADAR_EVT_PRESENT) {
        s_present = true;
    } else if (evt == RADAR_EVT_ABSENT) {
        s_present = false;
    }
}

void alarm_poll(void)
{
    uint32_t now = tick_ms();
    bool want;

    if ((uint32_t)(now - s_last_poll) < ALARM_POLL_MS) {
        return;
    }
    s_last_poll = now;

    want = s_armed && alarm_condition();

    if (want && !s_looping) {
        voice_ret_t ret = voice_loop((uint16_t)ALARM_TRACK);
        if (ret == VOICE_OK) {
            s_looping = true;
            if (logctl_enabled()) {
                printf("[alarm] condition -> loop %u\r\n", (unsigned)ALARM_TRACK);
            }
        }
        /* ERR_BUSY: 下一轮再试，不在这里忙等 */
        return;
    }

    if (!want && s_looping) {
        voice_ret_t ret = voice_stop();
        if (ret == VOICE_OK) {
            s_looping = false;
            if (logctl_enabled()) {
                printf("[alarm] clear -> stop\r\n");
            }
        }
    }
}

void alarm_set_armed(bool on)
{
    if (s_armed == on) {
        return;
    }
    s_armed = on;
    if (logctl_enabled()) {
        printf("[alarm] %s\r\n", on ? "armed" : "disarmed");
    }
}

bool alarm_is_armed(void)
{
    return s_armed;
}

void alarm_set_smoke(bool on)
{
    if (s_smoke != on) {
        s_smoke = on;
        if (logctl_enabled()) {
            printf("[alarm] smoke %s\r\n", on ? "on" : "off");
        }
    }
}

void alarm_set_panic(bool on)
{
    if (s_panic != on) {
        s_panic = on;
        if (logctl_enabled()) {
            printf("[alarm] panic %s\r\n", on ? "on" : "off");
        }
    }
}

bool alarm_is_alarming(void)
{
    return s_looping;
}

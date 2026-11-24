/**
 * @file    alarm.h
 * @brief   报警业务：雷达/烟感/遥控 PANIC -> 单曲循环语音
 *
 * 这一层只做业务决策，不碰寄存器：
 *   - 条件成立（布防 && 有人/烟感/PANIC） -> voice_loop(VOICE_IDX_ALARM)
 *   - 条件解除 -> voice_stop()
 *
 * 驱动层只负责上报事件；业务层通过 alarm_on_radar_event() 接收。
 */
#ifndef __ALARM_H__
#define __ALARM_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include "radar.h"

/* 初始化（在 radar_init/voice_init 之后调用），默认布防 */
void alarm_init(void);

/* 主循环把 radar_poll() 的事件交给业务 */
void alarm_on_radar_event(radar_evt_t evt);

/* 主循环调用：根据当前条件启停报警 */
void alarm_poll(void);

/* 布防/撤防 */
void alarm_set_armed(bool on);
bool alarm_is_armed(void);

/* 烟感 / 遥控 PANIC（当前硬件未接，预留；控制台可手动置位测试） */
void alarm_set_smoke(bool on);
void alarm_set_panic(bool on);

/* true = 当前正在循环播放报警音 */
bool alarm_is_alarming(void);

#ifdef __cplusplus
}
#endif
#endif /* __ALARM_H__ */

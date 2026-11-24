/**
 * @file    radar.h
 * @brief   雷达 MS24 OUT 驱动（只用 OUT，无 UART）
 *
 * 模块行为（实测前按规格书假设）：
 *   - OUT 默认高 = 有人，低 = 无人
 *   - 持续有人时保持高电平，不会重复产生"进入"事件
 *   - 没有 UART，改不了 AT+OUT_MODE，极性与保持时间必须实测确认
 *
 * 驱动原则：ISR 只做边沿计数，主循环把边沿合并成"占用/空闲"状态，
 * 持续高电平不会重复上报。
 */
#ifndef __RADAR_H__
#define __RADAR_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

typedef enum
{
    RADAR_EVT_NONE = 0,
    RADAR_EVT_PRESENT,   /* 无人 -> 有人 */
    RADAR_EVT_ABSENT,    /* 有人 -> 无人 */
} radar_evt_t;

/* 初始化 PA2 为浮空输入 + 双边沿 EXTI */
void radar_init(void);

/* 主循环调用：合并边沿，返回状态变化事件（无变化返回 RADAR_EVT_NONE） */
radar_evt_t radar_poll(void);

/* 当前电平语义：true = 有人 */
bool radar_is_present(void);

/* 调试用：自启动以来的边沿总数 */
uint32_t radar_edge_count(void);

#ifdef __cplusplus
}
#endif
#endif /* __RADAR_H__ */

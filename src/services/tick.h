/**
 * @file    tick.h
 * @brief   1ms 系统节拍（SysTick 中断方式，供软件定时/节流使用）
 *
 * 注意：SDK 的 bsp/delay.c 是把 SysTick 当一次性延时用的（关中断），
 * 与本模块冲突。本工程不编译 delay.c，统一用 tick_delay_ms()。
 */
#ifndef __TICK_H__
#define __TICK_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/* 启动 1ms SysTick 中断（上电最早调用） */
void tick_init(void);

/* 自启动以来的毫秒数，32 位溢出可按无符号差值比较 */
uint32_t tick_ms(void);

/* 忙等延时（基于 tick_ms，不占用 SysTick 重配置） */
void tick_delay_ms(uint32_t ms);

/* 微秒级忙等（借用 SysTick 计数器，精度约 1/64us）。
 * 用于 TM1621B 这类需要 2~10us 级时序的位操作接口。 */
void delay_us(uint32_t us);

/* 判断距 start 是否已过 ms 毫秒（处理 32 位回绕） */
bool tick_elapsed(uint32_t start, uint32_t ms);

#ifdef __cplusplus
}
#endif
#endif /* __TICK_H__ */

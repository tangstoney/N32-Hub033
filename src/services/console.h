/**
 * @file    console.h
 * @brief   串口命令行（USART1，接 STB 板上 U2 的虚拟串口，115200 8N1）
 *
 * 目的：bring-up 阶段每个模块都能单独验证，不用改固件重烧。
 * 命令在主循环里解析，不放进中断，避免和 BLE/语音抢时序。
 */
#ifndef __CONSOLE_H__
#define __CONSOLE_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

/* 初始化行缓冲（USART1 本身由 bsp/log.c 的 log_init 负责） */
void console_init(void);

/* 主循环调用：取字符、组行、执行命令 */
void console_poll(void);

/* 打印命令表 */
void console_help(void);

#ifdef __cplusplus
}
#endif
#endif /* __CONSOLE_H__ */

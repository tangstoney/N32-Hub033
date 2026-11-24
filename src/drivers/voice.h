/**
 * @file    voice.h
 * @brief   HM01 语音模块驱动（UART，115200 8N1，无 BUSY）
 *
 * 协议（已在 ESP32 上验证）：
 *   帧：7E | LEN | CMD | PARAM[n] | SUM | EF
 *   其中 LEN  = 3 + n      （含 CMD/PARAM/SUM，不含 7E/EF）
 *        SUM  = (LEN + CMD + PARAM[0..n-1]) 的低 8 位
 *
 * 关键约束：
 *   - 模块没有 BUSY 脚，播放结果只能靠命令应答 + 0xC9 查询 + 超时判断
 *   - 帧间至少 200~300ms，驱动内部做了 250ms 节流
 */
#ifndef __VOICE_H__
#define __VOICE_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/* 命令码（与 ESP32 已验证实现一致） */
#define VOICE_CMD_PLAY      0xA0U   /* 播放 Flash 指定索引（2 字节大端） */
#define VOICE_CMD_PLAY_USB  0xA6U   /* 播放 USB 指定索引（2 字节大端） */
#define VOICE_CMD_STOP      0xABU
#define VOICE_CMD_LOOP      0xAFU   /* 单曲循环开关：1 开 / 0 关（1 字节） */
#define VOICE_CMD_NEXT      0xACU
#define VOICE_CMD_SET_VOL   0xAEU   /* 设置音量 0~31（1 字节） */
#define VOICE_CMD_QUERY_VOL 0xC1U   /* 查询音量，回 1 字节 */
#define VOICE_CMD_QUERY_IDX 0xC9U   /* 查询当前曲目索引，回 2 字节 */
#define VOICE_CMD_QUERY_CNT 0xC3U   /* 查询 Flash 音频总数，回 2 字节 */
#define VOICE_CMD_STATUS    0xC2U   /* 状态：1 播放 / 2 停止 / 3 暂停 */

#define VOICE_LOOP_ON       0x01U
#define VOICE_LOOP_OFF      0x00U

/* 报警语音索引（按 ESP32 已验证配置；换音频只改这里） */
#define VOICE_IDX_ALARM     8U

/* 返回值 */
typedef enum
{
    VOICE_OK = 0,
    VOICE_ERR_ARG,      /* 参数非法 */
    VOICE_ERR_BUSY,     /* 距上一帧不足 250ms */
    VOICE_ERR_TIMEOUT,  /* 等待应答超时 */
} voice_ret_t;

/* 初始化 USART2(PB4/PB5, AF3, 115200) 并使能接收中断 */
void voice_init(void);

/* 发送一条命令（带校验和、250ms 节流）。params 可为 NULL。 */
voice_ret_t voice_send(uint8_t cmd, const uint8_t *params, uint8_t count);

/* 播放 Flash 指定索引（0~65535，2 字节大端） */
voice_ret_t voice_play(uint16_t index);

/* 停止 */
voice_ret_t voice_stop(void);

/* 单曲循环指定索引：先发 0xAF 01，再发 0xA0 + 2 字节索引 */
voice_ret_t voice_loop(uint16_t index);

/* 关闭单曲循环（0xAF 00） */
voice_ret_t voice_loop_off(void);

/* 设置音量 0~31 */
voice_ret_t voice_set_volume(uint8_t vol);

/* 查询当前曲目索引；成功返回 VOICE_OK 并写入 *index */
voice_ret_t voice_query_index(uint16_t *index, uint32_t timeout_ms);

/* 查询 Flash 音频总数；成功返回 VOICE_OK 并写入 *count */
voice_ret_t voice_query_count(uint16_t *count, uint32_t timeout_ms);

/* 主循环调用：解析收到的字节流，处理完整帧 */
void voice_poll(void);

/* 自启动以来收到的完整合法帧数 / 校验错误帧数（调试用） */
uint32_t voice_frame_count(void);
uint32_t voice_error_count(void);

#ifdef __cplusplus
}
#endif
#endif /* __VOICE_H__ */

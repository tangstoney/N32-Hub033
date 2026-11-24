/**
 * @file    voice.c
 * @brief   HM01 语音模块（USART2 + 中断接收 + 环形缓冲 + 帧解析）
 */
#include <string.h>
#include <stdio.h>
#include "voice.h"
#include "board.h"
#include "tick.h"
#include "n32wb033.h"
#include "n32wb033_gpio.h"
#include "n32wb033_rcc.h"
#include "n32wb033_usart.h"
#include "misc.h"

/* 接收环形缓冲：模块回帧最长 LEN<=255 -> 257 字节，留 512 足够 */
#define VOICE_RX_BUF_SIZE   512U
#define VOICE_RX_BUF_MASK   (VOICE_RX_BUF_SIZE - 1U)

/* 帧间最小间隔（Hx V2.03 手册 200~300ms，取 250ms） */
#define VOICE_FRAME_GAP_MS  250U

/* 解析缓存：一条完整帧最大 LEN(255) + 头(7E) + 尾(EF) */
#define VOICE_FRAME_MAX     257U

/* 最新一次查询得到的值（由帧解析填充） */
static volatile bool     s_idx_valid;
static volatile uint16_t s_idx_value;
static volatile bool     s_cnt_valid;
static volatile uint16_t s_cnt_value;

static volatile uint32_t s_frame_cnt;
static volatile uint32_t s_err_cnt;

/* 环形缓冲 */
static volatile uint8_t  s_rx_buf[VOICE_RX_BUF_SIZE];
static volatile uint16_t s_rx_head;   /* 写入位置（ISR） */
static volatile uint16_t s_rx_tail;   /* 读取位置（主循环） */

/* 解析状态机 */
static uint8_t  s_frame[VOICE_FRAME_MAX];
static uint16_t s_frame_len;

static uint32_t s_last_tx_tick;
static bool     s_tx_started;

void voice_init(void)
{
    GPIO_InitType  gpio;
    USART_InitType usart;
    NVIC_InitType  nvic;

    RCC_EnableAPB1PeriphClk(BOARD_VOICE_CLK, ENABLE);
    RCC_EnableAPB2PeriphClk(BOARD_VOICE_GPIO_CLK, ENABLE);

    GPIO_InitStruct(&gpio);
    gpio.GPIO_Mode      = GPIO_MODE_AF_PP;
    gpio.GPIO_Pull      = GPIO_PULL_UP;
    gpio.GPIO_Alternate = BOARD_VOICE_AF;
    gpio.GPIO_Current   = GPIO_DS_2MA;

    gpio.Pin = BOARD_VOICE_TX_PIN;
    GPIO_InitPeripheral(BOARD_VOICE_PORT, &gpio);

    gpio.Pin = BOARD_VOICE_RX_PIN;
    GPIO_InitPeripheral(BOARD_VOICE_PORT, &gpio);

    USART_StructInit(&usart);
    usart.BaudRate     = 115200;
    usart.WordLength   = USART_WL_8B;
    usart.StopBits     = USART_STPB_1;
    usart.Parity       = USART_PE_NO;
    usart.Mode         = USART_MODE_RX | USART_MODE_TX;
    usart.OverSampling = USART_16OVER;
    USART_Init(BOARD_VOICE_USART, &usart);

    /* 接收非空中断 */
    USART_ConfigInt(BOARD_VOICE_USART, USART_INT_RXDNE, ENABLE);

    nvic.NVIC_IRQChannel         = USART2_IRQn;
    nvic.NVIC_IRQChannelPriority = NVIC_PRIORITY_2;
    nvic.NVIC_IRQChannelCmd      = ENABLE;
    NVIC_Init(&nvic);

    USART_Enable(BOARD_VOICE_USART, ENABLE);

    s_rx_head = 0U;
    s_rx_tail = 0U;
    s_frame_len = 0U;
    s_frame_cnt = 0U;
    s_err_cnt = 0U;
    s_idx_valid = false;
    s_cnt_valid = false;
    s_tx_started = false;
    s_last_tx_tick = 0U;
}

/* ---------------- 发送 ---------------- */

static void uart_putc(uint8_t c)
{
    while (USART_GetFlagStatus(BOARD_VOICE_USART, USART_FLAG_TXDE) == RESET) {
    }
    USART_SendData(BOARD_VOICE_USART, c);
}

voice_ret_t voice_send(uint8_t cmd, const uint8_t *params, uint8_t count)
{
    uint8_t frame[8];
    uint8_t sum;
    uint8_t i;

    if (count > 2U || (count != 0U && params == NULL)) {
        return VOICE_ERR_ARG;
    }

    /* 250ms 节流：模块处理不过来会丢帧 */
    if (s_tx_started) {
        uint32_t now = tick_ms();
        if ((uint32_t)(now - s_last_tx_tick) < VOICE_FRAME_GAP_MS) {
            return VOICE_ERR_BUSY;
        }
    }

    frame[0] = 0x7EU;
    frame[1] = (uint8_t)(count + 3U);
    frame[2] = cmd;
    sum = (uint8_t)(frame[1] + cmd);
    for (i = 0U; i < count; i++) {
        frame[3U + i] = params[i];
        sum = (uint8_t)(sum + params[i]);
    }
    frame[3U + count] = sum;
    frame[4U + count] = 0xEFU;

    for (i = 0U; i < (uint8_t)(count + 5U); i++) {
        uart_putc(frame[i]);
    }

    s_last_tx_tick = tick_ms();
    s_tx_started = true;
    return VOICE_OK;
}

voice_ret_t voice_play(uint16_t index)
{
    uint8_t params[2];

    /* HM01 的播放索引是 16 位大端，不是 1 字节 */
    params[0] = (uint8_t)(index >> 8);
    params[1] = (uint8_t)(index & 0xFFU);
    return voice_send(VOICE_CMD_PLAY, params, 2U);
}

voice_ret_t voice_stop(void)
{
    return voice_send(VOICE_CMD_STOP, NULL, 0U);
}

voice_ret_t voice_loop(uint16_t index)
{
    uint8_t on = VOICE_LOOP_ON;
    voice_ret_t ret = voice_send(VOICE_CMD_LOOP, &on, 1U);

    if (ret != VOICE_OK) {
        return ret;
    }
    /* 模块要求帧间 200~300ms，给足后再发播放 */
    tick_delay_ms(300U);
    return voice_play(index);
}

voice_ret_t voice_loop_off(void)
{
    uint8_t off = VOICE_LOOP_OFF;

    return voice_send(VOICE_CMD_LOOP, &off, 1U);
}

voice_ret_t voice_set_volume(uint8_t vol)
{
    if (vol > 31U) {
        return VOICE_ERR_ARG;
    }
    return voice_send(VOICE_CMD_SET_VOL, &vol, 1U);
}

/* ---------------- 接收/解析 ---------------- */

void USART2_IRQHandler(void)
{
    if (USART_GetIntStatus(BOARD_VOICE_USART, USART_INT_RXDNE) != RESET) {
        uint8_t c = (uint8_t)USART_ReceiveData(BOARD_VOICE_USART);
        uint16_t next = (uint16_t)((s_rx_head + 1U) & VOICE_RX_BUF_MASK);

        if (next != s_rx_tail) {          /* 满了就丢，不覆盖未处理数据 */
            s_rx_buf[s_rx_head] = c;
            s_rx_head = next;
        }
        USART_ClrFlag(BOARD_VOICE_USART, USART_FLAG_RXDNE);
    }
}

static const char *voice_ack_str(uint8_t r)
{
    switch (r) {
    case 0U: return "OK";
    case 1U: return "command error";
    case 2U: return "no such file";
    case 5U: return "device offline";
    default: return "unknown";
    }
}

static void frame_dispatch(const uint8_t *f)
{
    uint8_t cmd   = f[2];
    uint8_t len   = f[1];
    uint8_t count = (uint8_t)(len - 3U);
    const uint8_t *p = &f[3];

    s_frame_cnt++;

    if ((cmd == VOICE_CMD_PLAY || cmd == VOICE_CMD_PLAY_USB ||
         cmd == VOICE_CMD_SET_VOL || cmd == VOICE_CMD_STOP) && count == 1U) {
        /* 写命令应答：0 成功 / 1 命令错 / 2 无此文件 / 5 设备不在线 */
        printf("[voice] ack %02X -> %u (%s)\r\n", cmd, p[0], voice_ack_str(p[0]));
    } else if (cmd == VOICE_CMD_QUERY_IDX && count == 2U) {
        s_idx_value = (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
        s_idx_valid = true;
        printf("[voice] index = %u\r\n", s_idx_value);
    } else if (cmd == VOICE_CMD_QUERY_CNT && count == 2U) {
        s_cnt_value = (uint16_t)(((uint16_t)p[0] << 8) | p[1]);
        s_cnt_valid = true;
        printf("[voice] audio count = %u\r\n", s_cnt_value);
    } else if (cmd == 0xC1U && count == 1U) {
        printf("[voice] volume = %u\r\n", p[0]);
    } else if (cmd == 0xC2U && count == 1U) {
        printf("[voice] status = %u (1 play / 2 stop / 3 pause)\r\n", p[0]);
    } else {
        printf("[voice] frame cmd=%02X len=%u\r\n", cmd, count);
    }
}

static void frame_scan(void)
{
    for (;;) {
        uint8_t len;
        uint16_t total;
        uint8_t sum = 0U;
        uint16_t i;

        /* 找帧头 */
        while (s_frame_len > 0U && s_frame[0] != 0x7EU) {
            memmove(s_frame, s_frame + 1, (size_t)(s_frame_len - 1U));
            s_frame_len--;
        }
        if (s_frame_len < 2U) {
            return;
        }

        len = s_frame[1];
        if (len < 3U) {                     /* 非法长度：滑 1 字节重同步 */
            s_err_cnt++;
            memmove(s_frame, s_frame + 1, (size_t)(s_frame_len - 1U));
            s_frame_len--;
            continue;
        }

        total = (uint16_t)(len + 2U);
        if (s_frame_len < total) {
            return;                         /* 还没收齐 */
        }

        for (i = 1U; i < (uint16_t)(total - 2U); i++) {
            sum = (uint8_t)(sum + s_frame[i]);
        }

        if (s_frame[total - 1U] != 0xEFU || sum != s_frame[total - 2U]) {
            s_err_cnt++;
            memmove(s_frame, s_frame + 1, (size_t)(s_frame_len - 1U));
            s_frame_len--;
            continue;
        }

        frame_dispatch(s_frame);
        memmove(s_frame, s_frame + total, (size_t)(s_frame_len - total));
        s_frame_len = (uint16_t)(s_frame_len - total);
    }
}

void voice_poll(void)
{
    while (s_rx_tail != s_rx_head) {
        uint8_t c = s_rx_buf[s_rx_tail];
        s_rx_tail = (uint16_t)((s_rx_tail + 1U) & VOICE_RX_BUF_MASK);

        if (s_frame_len >= VOICE_FRAME_MAX) {   /* 溢出保护 */
            s_frame_len = 0U;
            s_err_cnt++;
        }
        s_frame[s_frame_len++] = c;
        frame_scan();
    }
}

voice_ret_t voice_query_index(uint16_t *index, uint32_t timeout_ms)
{
    voice_ret_t ret;
    uint32_t start;

    if (index == NULL) {
        return VOICE_ERR_ARG;
    }

    s_idx_valid = false;
    ret = voice_send(VOICE_CMD_QUERY_IDX, NULL, 0U);
    if (ret != VOICE_OK) {
        return ret;
    }

    start = tick_ms();
    while ((uint32_t)(tick_ms() - start) < timeout_ms) {
        voice_poll();
        if (s_idx_valid) {
            *index = s_idx_value;
            return VOICE_OK;
        }
    }
    return VOICE_ERR_TIMEOUT;
}

voice_ret_t voice_query_count(uint16_t *count, uint32_t timeout_ms)
{
    voice_ret_t ret;
    uint32_t start;

    if (count == NULL) {
        return VOICE_ERR_ARG;
    }

    s_cnt_valid = false;
    ret = voice_send(VOICE_CMD_QUERY_CNT, NULL, 0U);
    if (ret != VOICE_OK) {
        return ret;
    }

    start = tick_ms();
    while ((uint32_t)(tick_ms() - start) < timeout_ms) {
        voice_poll();
        if (s_cnt_valid) {
            *count = s_cnt_value;
            return VOICE_OK;
        }
    }
    return VOICE_ERR_TIMEOUT;
}

uint32_t voice_frame_count(void)
{
    return s_frame_cnt;
}

uint32_t voice_error_count(void)
{
    return s_err_cnt;
}

/**
 * @file    radar.c
 * @brief   雷达 MS24 OUT：PA2 双边沿 EXTI + 主循环状态合并
 */
#include "radar.h"
#include "board.h"
#include "n32wb033.h"
#include "n32wb033_gpio.h"
#include "n32wb033_rcc.h"
#include "n32wb033_exti.h"
#include "misc.h"

/* ISR -> 主循环的边沿计数，volatile 因为跨中断上下文 */
static volatile uint32_t s_edge_cnt;
static bool s_present;      /* 合并后的状态 */
static bool s_inited;

static bool pin_level(void)
{
    return GPIO_ReadInputDataBit(BOARD_RADAR_PORT, BOARD_RADAR_PIN) != 0U;
}

void radar_init(void)
{
    GPIO_InitType gpio;
    EXTI_InitType exti;
    NVIC_InitType nvic;

    RCC_EnableAPB2PeriphClk(BOARD_RADAR_CLK, ENABLE);
    /* 模块推挽输出，MCU 侧浮空输入（不要上拉/下拉） */
    GPIO_InitStruct(&gpio);
    gpio.Pin       = BOARD_RADAR_PIN;
    gpio.GPIO_Mode = GPIO_MODE_INPUT;
    gpio.GPIO_Pull = GPIO_NO_PULL;
    GPIO_InitPeripheral(BOARD_RADAR_PORT, &gpio);

    /* PA2 -> EXTI_LINE2，双边沿 */
    GPIO_ConfigEXTILine(BOARD_RADAR_PORTSRC, BOARD_RADAR_PINSRC);

    EXTI_InitStruct(&exti);
    exti.EXTI_Line    = BOARD_RADAR_EXTI;
    exti.EXTI_Mode    = EXTI_Mode_Interrupt;
    exti.EXTI_Trigger = EXTI_Trigger_Rising_Falling;
    exti.EXTI_LineCmd = ENABLE;
    EXTI_InitPeripheral(&exti);

    nvic.NVIC_IRQChannel         = BOARD_RADAR_IRQn;
    nvic.NVIC_IRQChannelPriority = NVIC_PRIORITY_1;
    nvic.NVIC_IRQChannelCmd      = ENABLE;
    NVIC_Init(&nvic);

    /* 上电基线：如果已经有人，记为已占用，等回低后再准备下一次进入事件 */
    s_present = pin_level();
    s_edge_cnt = 0U;
    s_inited = true;
}

radar_evt_t radar_poll(void)
{
    uint32_t edges;
    radar_evt_t evt = RADAR_EVT_NONE;

    if (!s_inited) {
        return RADAR_EVT_NONE;
    }

    /* 原子取走计数：关中断时间极短 */
    __disable_irq();
    edges = s_edge_cnt;
    s_edge_cnt = 0U;
    __enable_irq();

    if (edges != 0U) {
        bool now = pin_level();
        if (now != s_present) {
            s_present = now;
            evt = now ? RADAR_EVT_PRESENT : RADAR_EVT_ABSENT;
        }
        /* 边沿抖动（电平没变）不产生事件，避免重复上报 */
    }

    return evt;
}

bool radar_is_present(void)
{
    return s_present;
}

uint32_t radar_edge_count(void)
{
    return s_edge_cnt;
}

/* PA2 与 PB2 共用 EXTI2_3，这里只处理 LINE2；PB2 是按键 K2（轮询，不用 EXTI） */
void EXTI2_3_IRQHandler(void)
{
    if (EXTI_GetStatusFlag(BOARD_RADAR_EXTI) != RESET) {
        s_edge_cnt++;
        EXTI_ClrITPendBit(BOARD_RADAR_EXTI);
    }
}

/**
 * @file    tick.c
 * @brief   1ms SysTick 节拍实现
 */
#include "tick.h"
#include "n32wb033.h"
#include "n32wb033_rcc.h"

static volatile uint32_t s_ms;
static uint32_t s_period;       /* SysTick 重装周期（= SysclkFreq/1000） */
static uint32_t s_ticks_per_us;

void tick_init(void)
{
    RCC_ClocksType clocks;

    RCC_GetClocksFreqValue(&clocks);

    s_ms = 0U;
    s_period = clocks.SysclkFreq / 1000U;
    s_ticks_per_us = s_period / 1000U;

    /* core_cm0plus 的 SysTick_Config：设置重装值、优先级并打开 TICKINT */
    (void)SysTick_Config(s_period);
}

uint32_t tick_ms(void)
{
    return s_ms;
}

bool tick_elapsed(uint32_t start, uint32_t ms)
{
    return (uint32_t)(s_ms - start) >= ms;
}

void tick_delay_ms(uint32_t ms)
{
    uint32_t start = s_ms;

    while ((uint32_t)(s_ms - start) < ms) {
        __WFI();
    }
}

/* 借 SysTick 递减计数器做微秒延时：SysTick 每个 s_period 回绕一次，
 * 把跨越回绕的差值累加起来，不依赖任何外部定时器。 */
void delay_us(uint32_t us)
{
    uint32_t need;
    uint32_t acc = 0U;
    uint32_t last;

    if (s_ticks_per_us == 0U || us == 0U) {
        return;
    }

    need = us * s_ticks_per_us;
    last = SysTick->VAL;

    while (acc < need) {
        uint32_t now = SysTick->VAL;

        if (now <= last) {
            acc += last - now;
        } else {
            /* 计数器回绕：last -> 0 -> s_period-1 -> now */
            acc += last + (s_period - now);
        }
        last = now;
    }
}

/* 覆盖启动文件里的 weak 定义 */
void SysTick_Handler(void)
{
    s_ms++;
}

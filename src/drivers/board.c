/**
 * @file    board.c
 * @brief   LED / 按键 / 背光的板级初始化与操作
 */
#include "board.h"
#include "n32wb033.h"
#include "n32wb033_gpio.h"
#include "n32wb033_rcc.h"

static void gpio_out_init(GPIO_Module *port, uint16_t pin)
{
    GPIO_InitType init;

    GPIO_InitStruct(&init);
    init.Pin       = pin;
    init.GPIO_Mode = GPIO_MODE_OUTPUT_PP;
    init.GPIO_Pull = GPIO_NO_PULL;
    init.GPIO_Current = GPIO_DS_2MA;
    GPIO_InitPeripheral(port, &init);
}

static void gpio_in_pullup_init(GPIO_Module *port, uint16_t pin)
{
    GPIO_InitType init;

    GPIO_InitStruct(&init);
    init.Pin       = pin;
    init.GPIO_Mode = GPIO_MODE_INPUT;
    init.GPIO_Pull = GPIO_PULL_UP;
    GPIO_InitPeripheral(port, &init);
}

void board_init(void)
{
    RCC_EnableAPB2PeriphClk(BOARD_LED1_CLK | BOARD_LED2_CLK | BOARD_KEY_CLK, ENABLE);

    /* LED 默认灭（高电平亮） */
    gpio_out_init(BOARD_LED1_PORT, BOARD_LED1_PIN);
    gpio_out_init(BOARD_LED2_PORT, BOARD_LED2_PIN);
    GPIO_ResetBits(BOARD_LED1_PORT, BOARD_LED1_PIN);
    GPIO_ResetBits(BOARD_LED2_PORT, BOARD_LED2_PIN);

    /* 按键：10k 上拉，按下接地 */
    gpio_in_pullup_init(BOARD_KEY1_PORT, BOARD_KEY1_PIN);
    gpio_in_pullup_init(BOARD_KEY2_PORT, BOARD_KEY2_PIN);

    /* 背光默认熄灭，等 seg_lcd_init 再按需点亮 */
    RCC_EnableAPB2PeriphClk(BOARD_LCD_CLK, ENABLE);
    gpio_out_init(BOARD_LCD_BLK_PORT, BOARD_LCD_BLK_PIN);
    GPIO_ResetBits(BOARD_LCD_BLK_PORT, BOARD_LCD_BLK_PIN);
}

static bool s_led1_on;
static bool s_led2_on;

void board_led1(bool on)
{
    s_led1_on = on;
    if (on) {
        GPIO_SetBits(BOARD_LED1_PORT, BOARD_LED1_PIN);
    } else {
        GPIO_ResetBits(BOARD_LED1_PORT, BOARD_LED1_PIN);
    }
}

void board_led2(bool on)
{
    s_led2_on = on;
    if (on) {
        GPIO_SetBits(BOARD_LED2_PORT, BOARD_LED2_PIN);
    } else {
        GPIO_ResetBits(BOARD_LED2_PORT, BOARD_LED2_PIN);
    }
}

void board_led_toggle(void)
{
    board_led1(!s_led1_on);
}

bool board_led1_state(void)
{
    return s_led1_on;
}

bool board_led2_state(void)
{
    return s_led2_on;
}

void board_lcd_backlight(bool on)
{
    if (on) {
        GPIO_SetBits(BOARD_LCD_BLK_PORT, BOARD_LCD_BLK_PIN);
    } else {
        GPIO_ResetBits(BOARD_LCD_BLK_PORT, BOARD_LCD_BLK_PIN);
    }
}

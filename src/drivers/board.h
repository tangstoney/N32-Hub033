/**
 * @file    board.h
 * @brief   rd91_hub033 板级定义（N32WB033CEQ7_STB V1.0 / U1）
 *
 * 引脚来源：docs/033-单片bring-up-引脚与任务.md 第 2 节 + STB 网表。
 * 全部为 STB 板载器件或已接好的外设，不占用 SWD(PA4/PA5) 与调试串口(PB6/PB7)。
 */
#ifndef __BOARD_H__
#define __BOARD_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#include "n32wb033.h"
#include "n32wb033_gpio.h"
#include "n32wb033_rcc.h"
#include "n32wb033_exti.h"

/* ---------------- 调试串口 USART1：接 U2 虚拟串口，115200 ----------------
 * 该组引脚由 SDK 的 bsp/log.c 固定为 PB6(TX)/PB7(RX)，此处仅作说明。 */

/* ---------------- 板载 LED（低电平灭，高电平亮：LEDx_ON_STATE=Bit_SET） */
#define BOARD_LED1_PORT     GPIOB
#define BOARD_LED1_PIN      GPIO_PIN_0
#define BOARD_LED1_CLK      RCC_APB2_PERIPH_GPIOB

#define BOARD_LED2_PORT     GPIOA
#define BOARD_LED2_PIN      GPIO_PIN_6
#define BOARD_LED2_CLK      RCC_APB2_PERIPH_GPIOA

/* ---------------- 板载按键（10k 上拉，按下接地） ---------------------- */
#define BOARD_KEY1_PORT     GPIOB
#define BOARD_KEY1_PIN      GPIO_PIN_1
#define BOARD_KEY2_PORT     GPIOB
#define BOARD_KEY2_PIN      GPIO_PIN_2
#define BOARD_KEY_CLK       RCC_APB2_PERIPH_GPIOB
/* 唤醒键 K4，低电平唤醒 */
#define BOARD_WAKE_PORT     GPIOB
#define BOARD_WAKE_PIN      GPIO_PIN_3

/* ---------------- 雷达 MS24：只用 OUT，默认高=有人 --------------------- */
#define BOARD_RADAR_PORT    GPIOA
#define BOARD_RADAR_PIN     GPIO_PIN_2
#define BOARD_RADAR_CLK     RCC_APB2_PERIPH_GPIOA
#define BOARD_RADAR_EXTI    EXTI_LINE2
#define BOARD_RADAR_PORTSRC GPIOA_PORT_SOURCE
#define BOARD_RADAR_PINSRC  GPIO_PIN_SOURCE2
#define BOARD_RADAR_IRQn    EXTI2_3_IRQn
/* 模块推挽输出，MCU 侧浮空输入，不要开上拉/下拉，避免干扰模块电平 */

/* ---------------- 语音 HM01：USART2 TX=PB4 / RX=PB5，AF3，115200 ----- */
#define BOARD_VOICE_USART   USART2
#define BOARD_VOICE_CLK     RCC_APB1_PERIPH_USART2
#define BOARD_VOICE_PORT    GPIOB
#define BOARD_VOICE_GPIO_CLK RCC_APB2_PERIPH_GPIOB
#define BOARD_VOICE_TX_PIN  GPIO_PIN_4
#define BOARD_VOICE_RX_PIN  GPIO_PIN_5
#define BOARD_VOICE_AF      GPIO_AF3
/* 注意：PB4/PB5 是 033 的 TX/RX，接线要与模块交叉：
 *   033 PB4(TX) -> HM01 RX
 *   033 PB5(RX) <- HM01 TX */

/* ---------------- 段码屏 3×TM1621B（闹钟摆件屏） ---------------------
 * 单向 3 线：DATA / WR / CS1..CS3，另有背光 BLK。
 * VDD 必须接 3.3V（接 5V 时 VIH=4.0V，033 的 3.3V IO 驱不动）。 */
#define BOARD_LCD_DATA_PORT GPIOC
#define BOARD_LCD_DATA_PIN  GPIO_PIN_0
#define BOARD_LCD_WR_PORT   GPIOC
#define BOARD_LCD_WR_PIN    GPIO_PIN_1
#define BOARD_LCD_CS1_PORT  GPIOC
#define BOARD_LCD_CS1_PIN   GPIO_PIN_2
#define BOARD_LCD_CS2_PORT  GPIOC
#define BOARD_LCD_CS2_PIN   GPIO_PIN_3
#define BOARD_LCD_CS3_PORT  GPIOC
#define BOARD_LCD_CS3_PIN   GPIO_PIN_4
#define BOARD_LCD_BLK_PORT  GPIOC
#define BOARD_LCD_BLK_PIN   GPIO_PIN_5
#define BOARD_LCD_CLK       RCC_APB2_PERIPH_GPIOC

/* ---------------- IMU QMI8A01z（未到货，预留） -----------------------
 * I2C1 SCL=PA1 / SDA=PA0（AF4，400kHz），INT1=PC6（EXTI）
 * 地址 0x6A(SA0 高/悬空) 或 0x6B(SA0 低)，WHO_AM_I(0x00)=0x05 */
#define BOARD_IMU_SCL_PORT  GPIOA
#define BOARD_IMU_SCL_PIN   GPIO_PIN_1
#define BOARD_IMU_SDA_PORT  GPIOA
#define BOARD_IMU_SDA_PIN   GPIO_PIN_0
#define BOARD_IMU_AF        GPIO_AF4
#define BOARD_IMU_INT_PORT  GPIOC
#define BOARD_IMU_INT_PIN   GPIO_PIN_6

/* ---------------- 初始化与开关 ---------------------------------------- */
void board_init(void);

void board_led1(bool on);
void board_led2(bool on);
void board_led_toggle(void);

/* 当前 LED 期望状态（驱动内部记录，供 console 打印） */
bool board_led1_state(void);
bool board_led2_state(void);

void board_lcd_backlight(bool on);

#ifdef __cplusplus
}
#endif
#endif /* __BOARD_H__ */

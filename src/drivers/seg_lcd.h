/**
 * @file    seg_lcd.h
 * @brief   JDL0483A00 段码屏驱动（3×TM1621B，纯单向 3 线）
 *
 * 移植自 ESP32 已点亮验证的 esp32/components/seg_lcd。
 * 时序、命令字、字模全部沿用，只把 GPIO 换成 033 的 GPIOC。
 *
 * 接线（VDD 必须 3.3V，接 5V 时 VIH=4.0V 驱不动）：
 *   DATA -> PC0, WR -> PC1, CS1 -> PC2, CS2 -> PC3, CS3 -> PC4, BLK -> PC5
 */
#ifndef __SEG_LCD_H__
#define __SEG_LCD_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#define SEG_LCD_CHIP_CNT 3
#define SEG_LCD_ADDR_CNT 32

/* 初始化 GPIO 并下发 TM1621B 上电命令序列（SYS EN -> RC256K -> 1/3 bias 4COM -> LCD ON） */
void seg_lcd_init(void);

/* 整屏填充 4bit 值：0x0 清屏，0xF 全显 */
void seg_lcd_fill(uint8_t nibble);

/* 单颗芯片填充 */
void seg_lcd_fill_chip(int chip, uint8_t nibble);

/* 只改影子 RAM，不上屏 */
void seg_lcd_set_nibble(int chip, uint8_t addr, uint8_t nibble);

/* 把影子 RAM 整帧下发 */
void seg_lcd_flush(void);

/* 数字字模占用的段以外的位是否保持点亮（默认 true，汉字不会跟着数字灭） */
void seg_lcd_set_keep_non_digit(bool keep);

/* 某颗芯片可显示的数字位数 */
int seg_lcd_digit_count(int chip);

/* 写数字 0~9 到影子 RAM（需再 seg_lcd_flush 才上屏） */
void seg_lcd_put_digit(int chip, int idx, int digit);

#ifdef __cplusplus
}
#endif
#endif /* __SEG_LCD_H__ */

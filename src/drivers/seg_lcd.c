/**
 * @file    seg_lcd.c
 * @brief   JDL0483A00 段码屏（3×TM1621B）驱动 —— 移植自 ESP32 已验证实现
 *
 * 时序说明（TM1621B datasheet）：
 *   - 串行时钟上限：3V 时 300kHz，5V 时 500kHz -> 半周期 2us(250kHz) 两边都满足
 *   - /CS 低电平脉宽 >= 4us -> 取 10us
 *   - 3bit 模式码：100=命令，101=写数据
 *   - 命令字是 9bit（接在 3bit 模式码之后）
 *   - 写数据：3bit 模式码 101 + 6bit 起始地址 + N×4bit 数据（地址自增）
 */
#include "seg_lcd.h"
#include "board.h"
#include "tick.h"
#include "n32wb033.h"
#include "n32wb033_gpio.h"
#include "n32wb033_rcc.h"

#define HALF_US      2U     /* 半周期 2us -> 250kHz */
#define CS_PULSE_US  10U    /* /CS 脉宽 */
#define CS_SETUP_US  4U     /* /CS 拉低到第一个时钟沿 */

#define ID_CMD 0x4U         /* 100：命令模式 */
#define ID_WR  0x5U         /* 101：写数据模式 */

#define CMD_SYS_DIS       0x000U
#define CMD_SYS_EN        0x002U
#define CMD_LCD_OFF       0x004U
#define CMD_LCD_ON        0x006U
#define CMD_RC_256K       0x030U
#define CMD_BIAS_1_3_4COM 0x052U

/* 厂家字模，[chip][0..9]；IC3 玻璃走线镜像，段顺序不同，别套用 IC1 */
static const uint8_t s_font[SEG_LCD_CHIP_CNT][10] = {
    {0xfa, 0x0a, 0xd6, 0x9e, 0x2e, 0xbc, 0xfc, 0x1a, 0xfe, 0xbe}, /* IC1 */
    {0xfa, 0x0a, 0xd6, 0x9e, 0x2e, 0xbc, 0xfc, 0x1a, 0xfe, 0xbe}, /* IC2 */
    {0xfa, 0x0a, 0xbc, 0x9e, 0x4e, 0xd6, 0xf6, 0x8a, 0xfe, 0xde}, /* IC3 */
};

/* 每颗芯片实际用到的地址数（= 位数 x 2） */
static const uint8_t s_addr_used[SEG_LCD_CHIP_CNT] = {24, 32, 22};

/* 数字字模只占这些位：高半字节 4 位 + 低半字节 bit3..1 */
#define DIGIT_MASK_HI 0x0FU
#define DIGIT_MASK_LO 0x0EU

static uint8_t s_ram[SEG_LCD_CHIP_CNT][SEG_LCD_ADDR_CNT];
static bool    s_keep_non_digit = true;

/* ---------------- 位操作 ---------------- */

static void cs_select(uint8_t mask)
{
    GPIO_WriteBit(BOARD_LCD_CS1_PORT, BOARD_LCD_CS1_PIN,
                  (mask & 0x01U) ? Bit_RESET : Bit_SET);
    GPIO_WriteBit(BOARD_LCD_CS2_PORT, BOARD_LCD_CS2_PIN,
                  (mask & 0x02U) ? Bit_RESET : Bit_SET);
    GPIO_WriteBit(BOARD_LCD_CS3_PORT, BOARD_LCD_CS3_PIN,
                  (mask & 0x04U) ? Bit_RESET : Bit_SET);
}

static void cs_release(void)
{
    cs_select(0U);
}

/* 高位先发；/WR 上升沿把 DATA 写进芯片 */
static void send_bits(uint32_t val, uint8_t nbits)
{
    int8_t i;

    for (i = (int8_t)(nbits - 1U); i >= 0; i--) {
        GPIO_WriteBit(BOARD_LCD_DATA_PORT, BOARD_LCD_DATA_PIN,
                      ((val >> (uint8_t)i) & 0x01U) ? Bit_SET : Bit_RESET);
        GPIO_WriteBit(BOARD_LCD_WR_PORT, BOARD_LCD_WR_PIN, Bit_RESET);
        delay_us(HALF_US);
        GPIO_WriteBit(BOARD_LCD_WR_PORT, BOARD_LCD_WR_PIN, Bit_SET);
        delay_us(HALF_US);
    }
}

/* mask 里置位的芯片同时接收（广播） */
static void write_cmd(uint8_t mask, uint16_t cmd9)
{
    cs_select(mask);
    delay_us(CS_SETUP_US);
    send_bits(ID_CMD, 3U);
    send_bits(cmd9, 9U);
    cs_release();
    delay_us(CS_PULSE_US);
}

static void write_ram(uint8_t mask, uint8_t addr, const uint8_t *nib, uint8_t cnt)
{
    uint8_t i;

    cs_select(mask);
    delay_us(CS_SETUP_US);
    send_bits(ID_WR, 3U);
    send_bits(addr, 6U);
    for (i = 0U; i < cnt; i++) {
        send_bits((uint32_t)(nib[i] & 0x0FU), 4U);
    }
    cs_release();
    delay_us(CS_PULSE_US);
}

/* ---------------- 对外接口 ---------------- */

void seg_lcd_init(void)
{
    GPIO_InitType gpio;

    RCC_EnableAPB2PeriphClk(BOARD_LCD_CLK, ENABLE);

    GPIO_InitStruct(&gpio);
    gpio.GPIO_Mode    = GPIO_MODE_OUTPUT_PP;
    gpio.GPIO_Pull    = GPIO_NO_PULL;
    gpio.GPIO_Current = GPIO_DS_8MA;   /* 驱动多颗并联的时钟线 */

    gpio.Pin = BOARD_LCD_DATA_PIN;
    GPIO_InitPeripheral(BOARD_LCD_DATA_PORT, &gpio);
    gpio.Pin = BOARD_LCD_WR_PIN;
    GPIO_InitPeripheral(BOARD_LCD_WR_PORT, &gpio);
    gpio.Pin = BOARD_LCD_CS1_PIN;
    GPIO_InitPeripheral(BOARD_LCD_CS1_PORT, &gpio);
    gpio.Pin = BOARD_LCD_CS2_PIN;
    GPIO_InitPeripheral(BOARD_LCD_CS2_PORT, &gpio);
    gpio.Pin = BOARD_LCD_CS3_PIN;
    GPIO_InitPeripheral(BOARD_LCD_CS3_PORT, &gpio);

    /* 空闲态：数据低、WR 高、CS 全释放 */
    GPIO_ResetBits(BOARD_LCD_DATA_PORT, BOARD_LCD_DATA_PIN);
    GPIO_SetBits(BOARD_LCD_WR_PORT, BOARD_LCD_WR_PIN);
    cs_release();

    /* 上电后 TM1621B 处于 SYS DIS（LCD 全灭），必须按厂家顺序初始化 */
    delay_us(CS_PULSE_US);
    write_cmd(0x07U, CMD_SYS_EN);
    write_cmd(0x07U, CMD_RC_256K);
    write_cmd(0x07U, CMD_BIAS_1_3_4COM);
    write_cmd(0x07U, CMD_LCD_ON);

    seg_lcd_fill(0x00U);
}

void seg_lcd_fill_chip(int chip, uint8_t nibble)
{
    uint8_t i;

    if (chip < 0 || chip >= SEG_LCD_CHIP_CNT) {
        return;
    }
    for (i = 0U; i < SEG_LCD_ADDR_CNT; i++) {
        s_ram[chip][i] = nibble & 0x0FU;
    }
}

void seg_lcd_fill(uint8_t nibble)
{
    uint8_t buf[SEG_LCD_ADDR_CNT];
    uint8_t chip, i;

    for (i = 0U; i < SEG_LCD_ADDR_CNT; i++) {
        buf[i] = nibble & 0x0FU;
    }
    for (chip = 0U; chip < SEG_LCD_CHIP_CNT; chip++) {
        for (i = 0U; i < SEG_LCD_ADDR_CNT; i++) {
            s_ram[chip][i] = nibble & 0x0FU;
        }
    }
    /* 三颗芯片同地址同值，一次广播写完 */
    write_ram(0x07U, 0U, buf, SEG_LCD_ADDR_CNT);
}

void seg_lcd_set_nibble(int chip, uint8_t addr, uint8_t nibble)
{
    if (chip < 0 || chip >= SEG_LCD_CHIP_CNT || addr >= SEG_LCD_ADDR_CNT) {
        return;
    }
    s_ram[chip][addr] = nibble & 0x0FU;
}

void seg_lcd_flush(void)
{
    uint8_t chip;

    for (chip = 0U; chip < SEG_LCD_CHIP_CNT; chip++) {
        write_ram((uint8_t)(1U << chip), 0U, s_ram[chip], SEG_LCD_ADDR_CNT);
    }
}

void seg_lcd_set_keep_non_digit(bool keep)
{
    s_keep_non_digit = keep;
}

int seg_lcd_digit_count(int chip)
{
    if (chip < 0 || chip >= SEG_LCD_CHIP_CNT) {
        return 0;
    }
    return (int)(s_addr_used[chip] / 2U);
}

static uint8_t merge_nibble(uint8_t value, uint8_t digit_mask)
{
    if (s_keep_non_digit) {
        return (uint8_t)((value & digit_mask) | (0x0FU & (uint8_t)~digit_mask));
    }
    return (uint8_t)(value & digit_mask);
}

void seg_lcd_put_digit(int chip, int idx, int digit)
{
    uint8_t addr_hi;
    uint8_t addr_lo;
    uint8_t pattern;

    if (chip < 0 || chip >= SEG_LCD_CHIP_CNT) {
        return;
    }
    if (idx < 0 || idx >= (int)(s_addr_used[chip] / 2U)) {
        return;
    }
    if (digit < 0 || digit > 9) {
        return;
    }

    addr_hi = (uint8_t)(idx * 2);
    addr_lo = (uint8_t)(addr_hi + 1U);
    pattern = s_font[chip][digit];

    s_ram[chip][addr_hi] = merge_nibble((uint8_t)((pattern >> 4) & 0x0FU), DIGIT_MASK_HI);
    s_ram[chip][addr_lo] = merge_nibble((uint8_t)(pattern & 0x0FU), DIGIT_MASK_LO);
}

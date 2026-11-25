/**
 * @file    charger.c
 * @brief   SGM41512 I2C 充电管理驱动
 *
 * 寄存器（7-bit 地址 0x1A，8-bit 写 0x34 / 读 0x35）：
 *   0x00 输入限流 + EN_HIZ
 *   0x01 CHG_CONFIG / OTG / SYS_MIN
 *   0x02 ICHG / BOOST_LIM
 *   0x03 预充/终止电流
 *   0x04 VREG / TOPOFF / VRECHG
 *   0x05 终止、看门狗、安全定时器
 *   0x06 OVP / BOOSTV / VINDPM
 *   0x07  BATFET / JEITA / VINDPM 跟踪
 *   0x08 状态 1：VBUS_STAT / CHRG_STAT / PG / THERM / VSYS
 *   0x09 故障：WATCHDOG / BOOST / CHRG_FAULT / BAT / NTC
 *   0x0A 状态 2：VBUS_GD / VINDPM / IINDPM / TOPOFF / ACOV
 *   0x0B 器件信息
 */
#include <stdio.h>
#include <string.h>

#include "charger.h"
#include "logctl.h"
#include "board.h"
#include "tick.h"
#include "n32wb033.h"
#include "n32wb033_gpio.h"
#include "n32wb033_rcc.h"
#include "n32wb033_i2c.h"

#define CHG_I2C          BOARD_CHG_I2C
#define CHG_ADDR8        0x34U      /* 7-bit 0x1A << 1 */
#define CHG_TIMEOUT      0x8000U

#define CHG_REG_INPUT    0x00U
#define CHG_REG_CTRL1    0x01U
#define CHG_REG_ICHG     0x02U
#define CHG_REG_PRECHG   0x03U
#define CHG_REG_VREG     0x04U
#define CHG_REG_CTRL2    0x05U
#define CHG_REG_CTRL3    0x06U
#define CHG_REG_CTRL4    0x07U
#define CHG_REG_STATUS1  0x08U
#define CHG_REG_FAULT    0x09U
#define CHG_REG_STATUS2  0x0AU
#define CHG_REG_PART     0x0BU

/* 默认配置：2A 输入 / 1.5A 充电 / 4.208V / 看门狗关闭 / OVP 14V */
#define CHG_CFG_INPUT    0x13U      /* 2000mA, HIZ off */
#define CHG_CFG_ICHG     0xB0U      /* BOOST_LIM=1, ICHG=0x30 (1500mA) */
#define CHG_CFG_VREG     0x58U      /* VREG=4.208V, TOPOFF off */
#define CHG_CFG_CTRL2    0x8FU      /* WATCHDOG=00, EN_TERM=1, EN_TIMER=1 */
#define CHG_CFG_CTRL1    0x1AU      /* CHG_CONFIG=1, SYS_MIN=3.5V */
#define CHG_CFG_CTRL3    0xE6U      /* OVP=14V, BOOSTV=5.15V, VINDPM=4.5V */

static bool              s_present;
static charger_state_t   s_state = CHARGER_STATE_UNKNOWN;
static charger_status_t  s_status;
static uint32_t          s_last_poll;
static uint8_t           s_last_s1 = 0xFFU;
static uint8_t           s_last_s2 = 0xFFU;

/* ---------------- I2C ---------------- */

/* 总线恢复：SDA/SCL 被从机拉死时，手打 9 个 SCL + STOP */
static void chg_bus_recover(void)
{
    GPIO_InitType gpio;
    uint8_t i;

    RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOA, ENABLE);

    GPIO_InitStruct(&gpio);
    gpio.GPIO_Mode    = GPIO_MODE_OUTPUT_OD;
    gpio.GPIO_Pull    = GPIO_PULL_UP;
    gpio.GPIO_Current = GPIO_DS_2MA;

    gpio.Pin = BOARD_CHG_SCL_PIN;
    GPIO_InitPeripheral(BOARD_CHG_SCL_PORT, &gpio);
    gpio.Pin = BOARD_CHG_SDA_PIN;
    GPIO_InitPeripheral(BOARD_CHG_SDA_PORT, &gpio);

    GPIO_SetBits(BOARD_CHG_SCL_PORT, BOARD_CHG_SCL_PIN);
    GPIO_SetBits(BOARD_CHG_SDA_PORT, BOARD_CHG_SDA_PIN);
    tick_delay_ms(1U);

    for (i = 0U; i < 9U; i++) {
        GPIO_ResetBits(BOARD_CHG_SCL_PORT, BOARD_CHG_SCL_PIN);
        delay_us(5U);
        GPIO_SetBits(BOARD_CHG_SCL_PORT, BOARD_CHG_SCL_PIN);
        delay_us(5U);
    }

    /* STOP: SDA 在 SCL 高时由低变高 */
    GPIO_ResetBits(BOARD_CHG_SDA_PORT, BOARD_CHG_SDA_PIN);
    delay_us(5U);
    GPIO_SetBits(BOARD_CHG_SCL_PORT, BOARD_CHG_SCL_PIN);
    delay_us(5U);
    GPIO_SetBits(BOARD_CHG_SDA_PORT, BOARD_CHG_SDA_PIN);
    delay_us(5U);
}

static void chg_i2c_init(void)
{
    GPIO_InitType gpio;
    I2C_InitType  i2c;

    RCC_EnableAPB1PeriphClk(BOARD_CHG_CLK, ENABLE);
    RCC_EnableAPB2PeriphClk(RCC_APB2_PERIPH_GPIOA, ENABLE);

    GPIO_InitStruct(&gpio);
    gpio.GPIO_Mode      = GPIO_MODE_AF_OD;
    gpio.GPIO_Pull      = GPIO_PULL_UP;
    gpio.GPIO_Alternate = BOARD_CHG_AF;
    gpio.GPIO_Current   = GPIO_DS_2MA;

    gpio.Pin = BOARD_CHG_SCL_PIN;
    GPIO_InitPeripheral(BOARD_CHG_SCL_PORT, &gpio);

    gpio.Pin = BOARD_CHG_SDA_PIN;
    GPIO_InitPeripheral(BOARD_CHG_SDA_PORT, &gpio);

    I2C_DeInit(CHG_I2C);
    I2C_InitStruct(&i2c);
    i2c.BusMode     = I2C_BUSMODE_I2C;
    i2c.FmDutyCycle = I2C_FMDUTYCYCLE_2;
    i2c.OwnAddr1    = 0x30U;
    i2c.AckEnable   = I2C_ACKEN;
    i2c.AddrMode    = I2C_ADDR_MODE_7BIT;
    i2c.ClkSpeed    = 400000U;   /* SGM41512 / IMU / CW2217 都支持 400k */
    I2C_Init(CHG_I2C, &i2c);
    I2C_Enable(CHG_I2C, ENABLE);
}

bool charger_read_reg(uint8_t reg, uint8_t *val)
{
    uint32_t t;

    t = CHG_TIMEOUT;
    while (I2C_GetFlag(CHG_I2C, I2C_FLAG_BUSY)) {
        if (--t == 0U) {
            return false;
        }
    }

    I2C_GenerateStart(CHG_I2C, ENABLE);
    t = CHG_TIMEOUT;
    while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_MODE_FLAG)) {
        if (--t == 0U) {
            goto fail;
        }
    }

    I2C_SendAddr7bit(CHG_I2C, CHG_ADDR8, I2C_DIRECTION_SEND);
    t = CHG_TIMEOUT;
    while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_TXMODE_FLAG)) {
        if (--t == 0U) {
            goto fail;
        }
    }

    I2C_SendData(CHG_I2C, reg);
    t = CHG_TIMEOUT;
    while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_DATA_SENDED)) {
        if (--t == 0U) {
            goto fail;
        }
    }

    I2C_ConfigAck(CHG_I2C, DISABLE);
    I2C_GenerateStart(CHG_I2C, ENABLE);       /* repeated START */
    t = CHG_TIMEOUT;
    while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_MODE_FLAG)) {
        if (--t == 0U) {
            goto fail;
        }
    }

    I2C_SendAddr7bit(CHG_I2C, CHG_ADDR8, I2C_DIRECTION_RECV);
    t = CHG_TIMEOUT;
    while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_RXMODE_FLAG)) {
        if (--t == 0U) {
            goto fail;
        }
    }

    (void)CHG_I2C->STS1;    /* 清 ADDR */
    (void)CHG_I2C->STS2;

    I2C_GenerateStop(CHG_I2C, ENABLE);
    t = CHG_TIMEOUT;
    while (!I2C_GetFlag(CHG_I2C, I2C_FLAG_RXDATNE)) {
        if (--t == 0U) {
            goto fail;
        }
    }

    *val = (uint8_t)I2C_RecvData(CHG_I2C);
    I2C_ConfigAck(CHG_I2C, ENABLE);
    return true;

fail:
    I2C_GenerateStop(CHG_I2C, ENABLE);
    I2C_ConfigAck(CHG_I2C, ENABLE);
    return false;
}

bool charger_write_reg(uint8_t reg, uint8_t val)
{
    uint32_t t;

    t = CHG_TIMEOUT;
    while (I2C_GetFlag(CHG_I2C, I2C_FLAG_BUSY)) {
        if (--t == 0U) {
            return false;
        }
    }

    I2C_GenerateStart(CHG_I2C, ENABLE);
    t = CHG_TIMEOUT;
    while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_MODE_FLAG)) {
        if (--t == 0U) {
            goto fail;
        }
    }

    I2C_SendAddr7bit(CHG_I2C, CHG_ADDR8, I2C_DIRECTION_SEND);
    t = CHG_TIMEOUT;
    while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_TXMODE_FLAG)) {
        if (--t == 0U) {
            goto fail;
        }
    }

    I2C_SendData(CHG_I2C, reg);
    t = CHG_TIMEOUT;
    while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_DATA_SENDED)) {
        if (--t == 0U) {
            goto fail;
        }
    }

    I2C_SendData(CHG_I2C, val);
    t = CHG_TIMEOUT;
    while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_DATA_SENDED)) {
        if (--t == 0U) {
            goto fail;
        }
    }

    I2C_GenerateStop(CHG_I2C, ENABLE);
    tick_delay_ms(2U);
    return true;

fail:
    I2C_GenerateStop(CHG_I2C, ENABLE);
    return false;
}

/* ICHG[5:0] 全表（手册 Table 7），单位 mA；高段步进 120mA，不是线性 */
static const uint16_t k_ichg_ma[64] = {
    0U, 5U, 10U, 15U, 20U, 25U, 30U, 35U,
    40U, 50U, 60U, 70U, 80U, 90U, 100U, 110U,
    130U, 150U, 170U, 190U, 210U, 230U, 250U, 270U,
    300U, 330U, 360U, 390U, 420U, 450U, 480U, 510U,
    540U, 600U, 660U, 720U, 780U, 840U, 900U, 960U,
    1020U, 1080U, 1140U, 1200U, 1260U, 1320U, 1380U, 1440U,
    1500U, 1620U, 1740U, 1860U, 1980U, 2100U, 2220U, 2340U,
    2460U, 2580U, 2700U, 2820U, 2940U, 3000U, 3000U, 3000U
};

bool charger_set_charge_current_ma(uint16_t ma, uint16_t *actual)
{
    uint8_t old = 0U;
    uint8_t best_i = 0U;
    uint16_t best = 0xFFFFU;
    uint8_t i;

    if (ma > 3000U) {
        ma = 3000U;
    }

    for (i = 0U; i < 64U; i++) {
        uint16_t diff = (k_ichg_ma[i] > ma) ? (uint16_t)(k_ichg_ma[i] - ma)
                                            : (uint16_t)(ma - k_ichg_ma[i]);
        if (diff < best) {
            best = diff;
            best_i = i;
        }
    }

    if (!charger_read_reg(CHG_REG_ICHG, &old)) {
        return false;
    }
    /* 保留 BOOST_LIM 和保留位，只改 ICHG[5:0] */
    if (!charger_write_reg(CHG_REG_ICHG, (uint8_t)((old & 0xC0U) | best_i))) {
        return false;
    }
    if (actual != NULL) {
        *actual = k_ichg_ma[best_i];
    }
    return true;
}

uint16_t charger_get_charge_current_ma(void)
{
    uint8_t v = 0U;

    if (!charger_read_reg(CHG_REG_ICHG, &v)) {
        return 0U;
    }
    return k_ichg_ma[v & 0x3FU];
}

bool charger_set_input_current_ma(uint16_t ma, uint16_t *actual)
{
    uint8_t old = 0U;
    uint8_t code;

    if (ma < 100U) {
        ma = 100U;
    }
    if (ma > 3200U) {
        ma = 3200U;
    }
    code = (uint8_t)((ma - 100U) / 100U);

    if (!charger_read_reg(CHG_REG_INPUT, &old)) {
        return false;
    }
    /* 清 EN_HIZ 和 IINDPM，保留 EN_ICHG_MON[1:0] */
    if (!charger_write_reg(CHG_REG_INPUT, (uint8_t)((old & 0x60U) | code))) {
        return false;
    }
    if (actual != NULL) {
        *actual = (uint16_t)(100U + 100U * code);
    }
    return true;
}

uint16_t charger_get_input_current_ma(void)
{
    uint8_t v = 0U;

    if (!charger_read_reg(CHG_REG_INPUT, &v)) {
        return 0U;
    }
    return (uint16_t)(100U + 100U * (v & 0x1FU));
}

/* ---------------- 状态解码 ---------------- */

const char *charger_state_str(charger_state_t st)
{
    switch (st) {
    case CHARGER_STATE_NO_INPUT:  return "no-input";
    case CHARGER_STATE_CHARGING:  return "charging";
    case CHARGER_STATE_DONE:      return "done";
    case CHARGER_STATE_DISABLED:  return "disabled";
    case CHARGER_STATE_FAULT:     return "fault";
    default:                      return "unknown";
    }
}

static const char *vbus_str(uint8_t v)
{
    switch (v) {
    case 0U: return "none";
    case 1U: return "SDP";
    case 2U: return "CDP";
    case 3U: return "DCP";
    case 5U: return "unknown-adapter";
    case 6U: return "nonstd-adapter";
    case 7U: return "OTG";
    default: return "reserved";
    }
}

static const char *chrg_str(uint8_t c)
{
    switch (c) {
    case 0U: return "off";
    case 1U: return "pre-charge";
    case 2U: return "fast-charge";
    case 3U: return "terminated";
    default: return "?";
    }
}

static charger_state_t decode_state(uint8_t s1, uint8_t s2)
{
    uint8_t vbus = (uint8_t)((s1 >> 5) & 0x07U);
    uint8_t chrg = (uint8_t)((s1 >> 3) & 0x03U);
    uint8_t pg   = (uint8_t)((s1 >> 2) & 0x01U);

    if (pg == 0U || vbus == 0U) {
        return CHARGER_STATE_NO_INPUT;
    }
    if (s2 != 0U) {
        return CHARGER_STATE_FAULT;
    }
    switch (chrg) {
    case 0U: return CHARGER_STATE_DISABLED;
    case 1U:
    case 2U: return CHARGER_STATE_CHARGING;
    case 3U: return CHARGER_STATE_DONE;
    default: return CHARGER_STATE_UNKNOWN;
    }
}

static void print_status(const charger_status_t *st, bool force)
{
    uint8_t s1   = st->status1;
    uint8_t s2   = st->fault;
    uint8_t vbus = (uint8_t)((s1 >> 5) & 0x07U);
    uint8_t chrg = (uint8_t)((s1 >> 3) & 0x03U);

    if (!force && !logctl_enabled()) {
        return;
    }

    printf("[chg] %s vbus=%s chrg=%s pg=%u therm=%u vsys=%u fault=%02X "
           "(wd=%u boost=%u chrg=%u bat=%u ntc=%u)\r\n",
           charger_state_str(decode_state(s1, s2)),
           vbus_str(vbus), chrg_str(chrg),
           (unsigned)((s1 >> 2) & 1U), (unsigned)((s1 >> 1) & 1U), (unsigned)(s1 & 1U),
           (unsigned)s2,
           (unsigned)((s2 >> 7) & 1U), (unsigned)((s2 >> 6) & 1U),
           (unsigned)((s2 >> 4) & 3U), (unsigned)((s2 >> 3) & 1U),
           (unsigned)(s2 & 7U));
}

static bool read_status(charger_status_t *st)
{
    if (!charger_read_reg(CHG_REG_STATUS1, &st->status1) ||
        !charger_read_reg(CHG_REG_FAULT,   &st->fault)   ||
        !charger_read_reg(CHG_REG_STATUS2, &st->status2)) {
        return false;
    }
    st->present = s_present;
    st->part    = s_status.part;
    return true;
}

/* ---------------- 配置 ---------------- */

static void apply_defaults(void)
{
    struct { uint8_t reg; uint8_t val; const char *name; } cfg[] = {
        { CHG_REG_CTRL2, CHG_CFG_CTRL2, "CTRL2(wdt off)" },
        { CHG_REG_INPUT, CHG_CFG_INPUT, "INPUT(2A)" },
        { CHG_REG_ICHG,  CHG_CFG_ICHG,  "ICHG(1.5A)" },
        { CHG_REG_VREG,  CHG_CFG_VREG,  "VREG(4.208V)" },
        { CHG_REG_CTRL3, CHG_CFG_CTRL3, "CTRL3(OVP14V)" },
        { CHG_REG_CTRL1, CHG_CFG_CTRL1, "CTRL1(chg on)" },
    };
    uint8_t i;

    for (i = 0U; i < (uint8_t)(sizeof(cfg) / sizeof(cfg[0])); i++) {
        if (!charger_write_reg(cfg[i].reg, cfg[i].val)) {
            printf("[chg] cfg %s (0x%02X=0x%02X) failed\r\n",
                   cfg[i].name, cfg[i].reg, cfg[i].val);
        }
    }
}

bool charger_init(void)
{
    uint8_t part = 0U;
    charger_status_t st;

    s_present = false;
    chg_bus_recover();
    chg_i2c_init();

    if (!charger_read_reg(CHG_REG_PART, &part)) {
        printf("[chg] no ACK at 0x1A (SCL=PA1 SDA=PA0 GND, 4.7k pull-up?)\r\n");
        return false;
    }

    s_present = true;
    s_status.part = part;
    printf("[chg] SGM41512 part=0x%02X (PN=%u)\r\n",
           part, (unsigned)((part >> 3) & 0x0FU));

    apply_defaults();

    if (read_status(&st)) {
        s_status = st;
        s_status.part = part;
        s_last_s1 = st.status1;
        s_last_s2 = st.fault;
        s_state = decode_state(st.status1, st.fault);
        print_status(&st, false);
    }

    s_last_poll = tick_ms();
    return true;
}

void charger_scan(void)
{
    uint8_t addr7;
    uint8_t found = 0U;

    chg_bus_recover();
    chg_i2c_init();
    printf("[chg] scan I2C1 (PA1=SCL PA0=SDA, 400kHz)...\r\n");

    for (addr7 = 0x08U; addr7 <= 0x77U; addr7++) {
        uint32_t t;
        uint8_t addr8 = (uint8_t)(addr7 << 1);
        bool ack = false;

        t = 2000U;
        while (I2C_GetFlag(CHG_I2C, I2C_FLAG_BUSY)) {
            if (--t == 0U) {
                break;
            }
        }

        I2C_GenerateStart(CHG_I2C, ENABLE);
        t = 2000U;
        while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_MODE_FLAG)) {
            if (--t == 0U) {
                break;
            }
        }

        if (t != 0U) {
            I2C_SendAddr7bit(CHG_I2C, addr8, I2C_DIRECTION_SEND);
            t = 2000U;
            while (!I2C_CheckEvent(CHG_I2C, I2C_EVT_MASTER_TXMODE_FLAG)) {
                if (--t == 0U) {
                    break;
                }
            }
            ack = (t != 0U);
        }

        I2C_GenerateStop(CHG_I2C, ENABLE);
        I2C_ConfigAck(CHG_I2C, ENABLE);
        (void)CHG_I2C->STS1;
        (void)CHG_I2C->STS2;

        if (ack) {
            printf("[chg] found 0x%02X\r\n", (unsigned)addr7);
            found++;
        }
    }

    if (found == 0U) {
        printf("[chg] no device; check SDA/SCL, GND, 4.7k pull-up, module power\r\n");
    } else {
        printf("[chg] %u device(s)\r\n", (unsigned)found);
    }
}

void charger_poll(void)
{
    uint32_t now;
    charger_status_t st;
    charger_state_t state;

    if (!s_present) {
        return;
    }

    now = tick_ms();
    if ((uint32_t)(now - s_last_poll) < 500U) {
        return;
    }
    s_last_poll = now;

    if (!read_status(&st)) {
        return;
    }

    state = decode_state(st.status1, st.fault);
    if (st.status1 != s_last_s1 || st.fault != s_last_s2 || state != s_state) {
        s_last_s1 = st.status1;
        s_last_s2 = st.fault;
        s_state   = state;
        s_status  = st;
        print_status(&st, false);
    }
}

charger_state_t charger_state(void)
{
    return s_state;
}

bool charger_is_charging(void)
{
    return s_state == CHARGER_STATE_CHARGING;
}

bool charger_is_fault(void)
{
    return s_state == CHARGER_STATE_FAULT;
}

bool charger_is_present(void)
{
    return s_present;
}

void charger_get_status(charger_status_t *st)
{
    if (st != NULL) {
        *st = s_status;
    }
}

void charger_dump(void)
{
    charger_status_t st;
    uint8_t regs[8];
    uint8_t i;

    if (!s_present) {
        printf("[chg] not present (I2C 0x1A; SCL=PA1 SDA=PA0 GND)\r\n");
        return;
    }

    if (!read_status(&st)) {
        printf("[chg] status read failed\r\n");
        return;
    }
    s_status = st;
    printf("[chg] part=0x%02X\r\n", (unsigned)s_status.part);
    print_status(&st, true);
    printf("[chg] status2=%02X vbus_gd=%u vindpm=%u iindpm=%u topoff=%u acov=%u\r\n",
           (unsigned)st.status2,
           (unsigned)((st.status2 >> 7) & 1U), (unsigned)((st.status2 >> 6) & 1U),
           (unsigned)((st.status2 >> 5) & 1U), (unsigned)((st.status2 >> 3) & 1U),
           (unsigned)((st.status2 >> 2) & 1U));

    for (i = 0U; i < 8U; i++) {
        regs[i] = 0xFFU;
        (void)charger_read_reg(i, &regs[i]);
    }
    printf("[chg] regs: 00=%02X 01=%02X 02=%02X 03=%02X 04=%02X 05=%02X 06=%02X 07=%02X\r\n",
           (unsigned)regs[0], (unsigned)regs[1], (unsigned)regs[2], (unsigned)regs[3],
           (unsigned)regs[4], (unsigned)regs[5], (unsigned)regs[6], (unsigned)regs[7]);
}

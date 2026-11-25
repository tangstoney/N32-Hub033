/**
 * @file    charger.h
 * @brief   SGM41512 I2C 充电管理（1S Li-ion，NVDC）
 *
 * 接线：I2C1，PA1=SCL / PA0=SDA，AF4，400kHz；7-bit 地址 0x1A（写 0x34 / 读 0x35），
 *       必须共地；SDA/SCL 需要 4.7k 上拉到 3.3V（模块自带就用模块的）。
 *
 * 与 IMU 共用 I2C1 总线：充电 0x1A，IMU 0x6A/0x6B，不冲突。
 */
#ifndef __CHARGER_H__
#define __CHARGER_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

typedef enum
{
    CHARGER_STATE_UNKNOWN = 0,
    CHARGER_STATE_NO_INPUT,     /* 没有有效输入 */
    CHARGER_STATE_CHARGING,     /* 预充或快充 */
    CHARGER_STATE_DONE,         /* 充电终止 */
    CHARGER_STATE_DISABLED,     /* 有输入但充电关闭 */
    CHARGER_STATE_FAULT,        /* 任一 fault 位 */
} charger_state_t;

typedef struct
{
    bool     present;
    uint8_t  part;      /* REG0x0B */
    uint8_t  status1;   /* REG0x08 */
    uint8_t  fault;     /* REG0x09 */
    uint8_t  status2;   /* REG0x0A */
} charger_status_t;

/* 初始化 I2C + 写默认配置；返回 false 表示 I2C 无应答 */
bool charger_init(void);

/* 主循环调用：每 500ms 读一次状态，状态变化时打印 */
void charger_poll(void);

/* 当前解码状态 */
charger_state_t charger_state(void);
bool charger_is_charging(void);
bool charger_is_fault(void);
bool charger_is_present(void);

/* 最近一次状态快照 */
void charger_get_status(charger_status_t *st);

/* 直接读写寄存器（0x00~0x10） */
bool charger_read_reg(uint8_t reg, uint8_t *val);
bool charger_write_reg(uint8_t reg, uint8_t val);

/* 充电电流：按手册 Table 7 选最近档（64 档，非线性） */
bool charger_set_charge_current_ma(uint16_t ma, uint16_t *actual);
uint16_t charger_get_charge_current_ma(void);

/* 输入限流：100mA 一档，100~3200mA（线性） */
bool charger_set_input_current_ma(uint16_t ma, uint16_t *actual);
uint16_t charger_get_input_current_ma(void);

/* 控制台：打印解码状态 + 关键寄存器 */
void charger_dump(void);

/* 扫描 I2C1 总线，打印有应答的 7-bit 地址 */
void charger_scan(void);

/* 状态/故障字符串 */
const char *charger_state_str(charger_state_t st);

#ifdef __cplusplus
}
#endif
#endif /* __CHARGER_H__ */

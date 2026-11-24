/**
 * @file    imu.h
 * @brief   QMI8A01z 六轴 IMU（I2C1）—— 模块未到货，本阶段只有探测桩
 *
 * 接线（到货后按此接）：
 *   SCL -> PA1, SDA -> PA0 (I2C1, AF4, 400kHz)
 *   INT1 -> PC6 (EXTI)
 *   地址 0x6A(SA0 高/悬空) 或 0x6B(SA0 低)；WHO_AM_I(0x00) = 0x05
 *
 * 老驱动（可直接移植寄存器配置逻辑）：
 *   Anti-Theft Fogging System/rd91-controller-fw/drivers/imu_qmi8a01z.c
 */
#ifndef __IMU_H__
#define __IMU_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#define IMU_I2C_ADDR_SA0_HIGH   0x6AU
#define IMU_I2C_ADDR_SA0_LOW    0x6BU
#define IMU_REG_WHO_AM_I        0x00U
#define IMU_WHO_AM_I_VALUE      0x05U

typedef struct
{
    int16_t ax, ay, az;   /* 加速度原始值 */
    int16_t gx, gy, gz;   /* 角速度原始值 */
} imu_sample_t;

/* 初始化 I2C1 并探测器件；成功返回 true，并把实际地址写入 *addr */
bool imu_probe(uint8_t *addr);

/* 读一次六轴原始值；未初始化/未到货返回 false */
bool imu_read(imu_sample_t *sample);

/* 是否已探测到器件 */
bool imu_present(void);

#ifdef __cplusplus
}
#endif
#endif /* __IMU_H__ */

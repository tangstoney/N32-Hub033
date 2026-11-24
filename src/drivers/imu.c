/**
 * @file    imu.c
 * @brief   QMI8A01z 探测桩（模块未到货）
 *
 * 现在只做一件事：把 I2C1(PA1/PA0) 初始化好，读一次 WHO_AM_I，
 * 把结果打印出来，方便到货后立即确认是地址不对、还是没接上。
 *
 * 到货后要做的事（对照老驱动 imu_qmi8a01z.c）：
 *   1. CTRL7=0 关闭传感器
 *   2. CTRL8=0x80 选 CTRL9 握手走 STATUSINT
 *   3. CTRL1=0x40 小端 + 地址自增
 *   4. CTRL2 量程(FS=2)+ODR(3)
 *   5. CTRL9 下发 Any-Motion 参数（0x0E，两批 CAL4_H=0x10/0x20）
 *   6. CTRL7=0x01 打开加速度计
 *   7. CTRL8=0x80|0x40|0x02 运动事件走 INT1
 */
#include <stddef.h>
#include "imu.h"
#include "board.h"
#include "n32wb033.h"
#include "n32wb033_gpio.h"
#include "n32wb033_rcc.h"
#include "n32wb033_i2c.h"

#define IMU_I2C          I2C1
#define IMU_I2C_CLK      RCC_APB1_PERIPH_I2C1
#define IMU_GPIO_CLK     RCC_APB2_PERIPH_GPIOA
#define IMU_I2C_SPEED    400000U
#define IMU_TIMEOUT      0x8000U

static bool    s_present;
static uint8_t s_addr;

static void imu_i2c_init(void)
{
    GPIO_InitType gpio;
    I2C_InitType  i2c;

    RCC_EnableAPB1PeriphClk(IMU_I2C_CLK, ENABLE);
    RCC_EnableAPB2PeriphClk(IMU_GPIO_CLK, ENABLE);

    /* 开漏 + 上拉（模块侧可能已有 4.7k，这里只保留弱的内部上拉） */
    GPIO_InitStruct(&gpio);
    gpio.GPIO_Mode      = GPIO_MODE_AF_OD;
    gpio.GPIO_Pull      = GPIO_PULL_UP;
    gpio.GPIO_Alternate = BOARD_IMU_AF;
    gpio.GPIO_Current   = GPIO_DS_2MA;

    gpio.Pin = BOARD_IMU_SCL_PIN;
    GPIO_InitPeripheral(BOARD_IMU_SCL_PORT, &gpio);

    gpio.Pin = BOARD_IMU_SDA_PIN;
    GPIO_InitPeripheral(BOARD_IMU_SDA_PORT, &gpio);

    I2C_DeInit(IMU_I2C);
    I2C_InitStruct(&i2c);
    i2c.BusMode     = I2C_BUSMODE_I2C;
    i2c.FmDutyCycle = I2C_FMDUTYCYCLE_2;
    i2c.OwnAddr1    = 0x30U;
    i2c.AckEnable   = I2C_ACKEN;
    i2c.AddrMode    = I2C_ADDR_MODE_7BIT;
    i2c.ClkSpeed    = IMU_I2C_SPEED;
    I2C_Init(IMU_I2C, &i2c);
    I2C_Enable(IMU_I2C, ENABLE);
}

/* 单字节寄存器读：START -> 地址W -> 寄存器 -> 重启 -> 地址R -> 收 1 字节 NACK -> STOP */
static bool imu_read_reg(uint8_t addr7, uint8_t reg, uint8_t *val)
{
    uint32_t timeout;

    timeout = IMU_TIMEOUT;
    while (I2C_GetFlag(IMU_I2C, I2C_FLAG_BUSY)) {
        if (--timeout == 0U) {
            return false;
        }
    }

    I2C_GenerateStart(IMU_I2C, ENABLE);
    timeout = IMU_TIMEOUT;
    while (!I2C_CheckEvent(IMU_I2C, I2C_EVT_MASTER_MODE_FLAG)) {
        if (--timeout == 0U) {
            return false;
        }
    }

    I2C_SendAddr7bit(IMU_I2C, addr7, I2C_DIRECTION_SEND);
    timeout = IMU_TIMEOUT;
    while (!I2C_CheckEvent(IMU_I2C, I2C_EVT_MASTER_TXMODE_FLAG)) {
        if (--timeout == 0U) {
            return false;
        }
    }

    I2C_SendData(IMU_I2C, reg);
    timeout = IMU_TIMEOUT;
    while (!I2C_CheckEvent(IMU_I2C, I2C_EVT_MASTER_DATA_SENDED)) {
        if (--timeout == 0U) {
            return false;
        }
    }

    I2C_ConfigAck(IMU_I2C, DISABLE);
    I2C_GenerateStart(IMU_I2C, ENABLE);   /* repeated START */
    timeout = IMU_TIMEOUT;
    while (!I2C_CheckEvent(IMU_I2C, I2C_EVT_MASTER_MODE_FLAG)) {
        if (--timeout == 0U) {
            return false;
        }
    }

    I2C_SendAddr7bit(IMU_I2C, addr7, I2C_DIRECTION_RECV);
    timeout = IMU_TIMEOUT;
    while (!I2C_CheckEvent(IMU_I2C, I2C_EVT_MASTER_RXMODE_FLAG)) {
        if (--timeout == 0U) {
            return false;
        }
    }

    (void)IMU_I2C->STS1;   /* 清 ADDR */
    (void)IMU_I2C->STS2;

    I2C_GenerateStop(IMU_I2C, ENABLE);
    timeout = IMU_TIMEOUT;
    while (!I2C_GetFlag(IMU_I2C, I2C_FLAG_RXDATNE)) {
        if (--timeout == 0U) {
            return false;
        }
    }

    *val = (uint8_t)I2C_RecvData(IMU_I2C);
    I2C_ConfigAck(IMU_I2C, ENABLE);
    return true;
}

bool imu_probe(uint8_t *addr)
{
    uint8_t id = 0U;
    static const uint8_t addrs[2] = { IMU_I2C_ADDR_SA0_HIGH, IMU_I2C_ADDR_SA0_LOW };
    uint8_t i;

    s_present = false;
    imu_i2c_init();

    for (i = 0U; i < 2U; i++) {
        if (imu_read_reg(addrs[i], IMU_REG_WHO_AM_I, &id) && id == IMU_WHO_AM_I_VALUE) {
            s_present = true;
            s_addr = addrs[i];
            if (addr != NULL) {
                *addr = s_addr;
            }
            return true;
        }
    }

    return false;
}

bool imu_read(imu_sample_t *sample)
{
    (void)sample;
    /* 未到货：CTRL7/CTRL2 还没配，直接返回 false，由上层打印"未就绪" */
    return false;
}

bool imu_present(void)
{
    return s_present;
}

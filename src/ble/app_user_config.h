/**
 * @file    app_user_config.h
 * @brief   BLE 应用配置（从 master_slave_relay 裁剪）
 *
 * M1 目标：手机侧 peripheral，广播 N32-Hub，服务 0xFFE0/FFE1/FFE2。
 * 原型不做配对/加密；栈内日志全部关闭，控制台继续用 USART1。
 */
#ifndef __APP_USER_CONFIG_H__
#define __APP_USER_CONFIG_H__

#ifdef __cplusplus
extern "C" {
#endif

#include "ns_adv_data_def.h"

/* Device name */
#define CUSTOM_DEVICE_NAME                  "N32-Hub"

/* adv config */
#define CUSTOM_ADV_FAST_INTERVAL            160
#define CUSTOM_ADV_SLOW_INTERVAL            3200
#define CUSTOM_ADV_FAST_DURATION            30
#define CUSTOM_ADV_SLOW_DURATION            0

/* adv data: service UUID 0xFFE0 + complete name（flags 由 ns_adv 自己加） */
#define CUSTOM_USER_ADVERTISE_DATA \
            "\x03\x03\xE0\xFF" \
            "\x08\x09N32-Hub"
#define CUSTOM_USER_ADVERTISE_DATA_LEN      (sizeof(CUSTOM_USER_ADVERTISE_DATA)-1)

/* scan response: manufacturer data（0x0A + type 0xFF + company 0xFFFF + "Nations"） */
#define CUSTOM_USER_ADV_SCNRSP_DATA         "\x0a\xff\xff\xffNations"
#define CUSTOM_USER_ADV_SCNRSP_DATA_LEN     (sizeof(CUSTOM_USER_ADV_SCNRSP_DATA)-1)

/* connection config */
#define MIN_CONN_INTERVAL                   10
#define MAX_CONN_INTERVAL                   60
#define SLAVE_LATENCY                       0
#define CONN_SUP_TIMEOUT                    5000
#define FIRST_CONN_PARAMS_UPDATE_DELAY      2000

/* 原型不配对、不加密（私有协议 v0.1） */
/* #define CFG_APP_SEC */

/* profiles: SDK 16-bit raw-data server, UUID 在 hub_app.c 里改成 0xFFE0/E1/E2 */
#define CFG_PRF_RDTSS_16BIT                 1
#define CFG_PRF_RDTSC_16BIT                 0
#define CFG_PRF_RDTSC                       0
#define CFG_PRF_RDTSS                       0

/* 1 条手机 slave + 2 条 Fob/Smoke master */
#define BLE_MASTER_CONN                     2
#define BLE_SLAVE_CONN                      1
#if (BLE_MASTER_CONN + BLE_SLAVE_CONN > 6)
#error BLE_MASTER_CONN + BLE_SLAVE_CONN exceed APP_CON_IDX_MAX
#endif

/* scan config（M3 连 Fob/Smoke 时用） */
#define SCAN_PARAM_TYPE                     GAPM_SCAN_TYPE_OBSERVER
#define SCAN_PARAM_PROP_ACTIVE              1
#define SCAN_PARAM_DUP_FILT_POL             GAPM_DUP_FILT_DIS
#define SCAN_PARAM_INTV                     160
#define SCAN_PARAM_WD                       150
#define SCAN_PARAM_DURATION                 0
#define SCAN_PARAM_CONNECT_EN               true

/* 栈内日志全部关闭，避免与 USART1 控制台争用 */
#define NS_LOG_ERROR_ENABLE                 0
#define NS_LOG_WARNING_ENABLE               0
#define NS_LOG_INFO_ENABLE                  0
#define NS_LOG_DEBUG_ENABLE                 0
#define NS_LOG_LPUART_ENABLE                0
#define NS_TIMER_ENABLE                     1

#define FIRMWARE_VERSION                    "0.1.0"
#define HARDWARE_VERSION                    "1.0.0"

#ifdef __cplusplus
}
#endif
#endif /* __APP_USER_CONFIG_H__ */

/**
 * @file    ble_app.c
 * @brief   BLE 初始化：N32-Hub 广播 + 0xFFE0 服务
 */
#include <string.h>
#include <stdio.h>

#include "n32wb033.h"
#include "gapm_task.h"
#include "ns_ble.h"
#include "app_user_config.h"
#include "hub_app.h"
#include "ble_app.h"

static void app_user_msg_handler(ke_msg_id_t const msgid, void const *p_param)
{
    (void)msgid;
    (void)p_param;
}

static void app_ble_adv_msg_handler(enum app_adv_mode adv_mode)
{
    printf("[ble] adv mode %d\r\n", (int)adv_mode);

    if (adv_mode == APP_ADV_MODE_STOP) {
        if (ns_ble_slave_connection_num() < BLE_SLAVE_CONN) {
            ns_ble_adv_start();
        }
    }
}

static void app_ble_msg_handler(struct ble_msg_t const *p_ble_msg)
{
    switch (p_ble_msg->msg_id) {
    case APP_BLE_OS_READY:
        printf("[ble] stack ready, start adv\r\n");
        ns_ble_adv_start();
        break;

    case APP_BLE_GAP_CONNECTED:
        printf("[ble] connected (slave=%u master=%u)\r\n",
               (unsigned)ns_ble_slave_connection_num(),
               (unsigned)ns_ble_master_connection_num());
        break;

    case APP_BLE_GAP_DISCONNECTED:
        printf("[ble] disconnected\r\n");
        break;

    default:
        break;
    }
}

static void app_ble_gap_params_init(void)
{
    struct ns_gap_params_t dev_info = {0};
    uint8_t *p_mac = SystemGetMacAddr();

    if (p_mac != NULL) {
        memcpy(dev_info.mac_addr.addr, p_mac, BD_ADDR_LEN);
    } else {
        memcpy(dev_info.mac_addr.addr, "\x01\x02\x03\x0C\x0D\x06", BD_ADDR_LEN);
    }
    dev_info.mac_addr.addr[5] |= 0xC0;
    dev_info.mac_addr_type = GAPM_STATIC_ADDR;
    dev_info.appearance    = 0;
    dev_info.dev_role      = GAP_ROLE_ALL;

    printf("[ble] mac %02X:%02X:%02X:%02X:%02X:%02X (%s)\r\n",
           dev_info.mac_addr.addr[5], dev_info.mac_addr.addr[4],
           dev_info.mac_addr.addr[3], dev_info.mac_addr.addr[2],
           dev_info.mac_addr.addr[1], dev_info.mac_addr.addr[0],
           (p_mac != NULL) ? "OTP" : "fallback");

    dev_info.dev_name_len = sizeof(CUSTOM_DEVICE_NAME) - 1;
    memcpy(dev_info.dev_name, CUSTOM_DEVICE_NAME, dev_info.dev_name_len);

    dev_info.dev_conn_param.intv_min = MSECS_TO_UNIT(MIN_CONN_INTERVAL, MSECS_UNIT_1_25_MS);
    dev_info.dev_conn_param.intv_max = MSECS_TO_UNIT(MAX_CONN_INTERVAL, MSECS_UNIT_1_25_MS);
    dev_info.dev_conn_param.latency  = SLAVE_LATENCY;
    dev_info.dev_conn_param.time_out = MSECS_TO_UNIT(CONN_SUP_TIMEOUT, MSECS_UNIT_10_MS);
    dev_info.conn_param_update_delay = FIRST_CONN_PARAMS_UPDATE_DELAY;

    ns_ble_gap_init(&dev_info);
}

static void app_ble_adv_init(void)
{
    struct ns_adv_params_t user_adv = {0};

    user_adv.adv_data_len = CUSTOM_USER_ADVERTISE_DATA_LEN;
    memcpy(user_adv.adv_data, CUSTOM_USER_ADVERTISE_DATA, CUSTOM_USER_ADVERTISE_DATA_LEN);

    user_adv.scan_rsp_data_len = CUSTOM_USER_ADV_SCNRSP_DATA_LEN;
    if (user_adv.scan_rsp_data_len != 0U) {
        memcpy(user_adv.scan_rsp_data, CUSTOM_USER_ADV_SCNRSP_DATA, user_adv.scan_rsp_data_len);
    }

    user_adv.attach_appearance = false;
    user_adv.attach_name       = false;   /* 名字已写进 adv data */
    user_adv.ex_adv_enable     = false;
    user_adv.adv_phy           = PHY_1MBPS_VALUE;

    user_adv.directed_adv.enable = false;

    user_adv.fast_adv.enable   = true;
    user_adv.fast_adv.duration = CUSTOM_ADV_FAST_DURATION;
    user_adv.fast_adv.adv_intv = CUSTOM_ADV_FAST_INTERVAL;

    user_adv.slow_adv.enable   = true;
    user_adv.slow_adv.duration = CUSTOM_ADV_SLOW_DURATION;
    user_adv.slow_adv.adv_intv = CUSTOM_ADV_SLOW_INTERVAL;

    user_adv.ble_adv_msg_handler = app_ble_adv_msg_handler;

    ns_ble_adv_init(&user_adv);
}

void ble_app_init(void)
{
    struct ns_stack_cfg_t app_handler = {0};

    app_handler.ble_msg_handler  = app_ble_msg_handler;
    app_handler.user_msg_handler = app_user_msg_handler;

    ns_ble_stack_init(&app_handler);
    app_ble_gap_params_init();
    app_ble_adv_init();

    ns_ble_add_prf_func_register(hub_app_add);

    /* 广播在 APP_BLE_OS_READY 里启动：初始化阶段协议栈还没就绪，
     * 这里调用会被拒绝（GAPM status 66/64）。 */
    printf("[ble] init: name=%s, service=FFE0, adv_len=%u\r\n",
           CUSTOM_DEVICE_NAME, (unsigned)CUSTOM_USER_ADVERTISE_DATA_LEN);
}

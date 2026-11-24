/**
 * @file    hub_app.h
 * @brief   N32-Hub 私有 GATT 服务：0xFFE0 / FFE1(notify) / FFE2(write)
 *
 * 底层复用 SDK 的 16-bit RDTSS（raw data transfer server），
 * 这里只负责：
 *   - 把服务/特征 UUID 改成私有值
 *   - 收到 FFE2 写入 -> hub_app_notify() 回显（M1）
 *   - 把 notify 使能状态记下来
 */
#ifndef __HUB_APP_H__
#define __HUB_APP_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#define HUB_SVC_UUID          0xFFE0U
#define HUB_CHAR_NOTIFY_UUID  0xFFE1U
#define HUB_CHAR_WRITE_UUID   0xFFE2U

enum
{
    HUB_IDX_SVC,
    HUB_IDX_WRITE_CHAR,
    HUB_IDX_WRITE_VAL,
    HUB_IDX_NTF_CHAR,
    HUB_IDX_NTF_VAL,
    HUB_IDX_NTF_CFG,
    HUB_IDX_NB,
};

/* 由 ns_ble_add_prf_func_register() 在协议栈就绪后调用 */
void hub_app_add(void);

/* 注册 profile task 和 itf（hub_app_add 内部调用） */
void hub_app_init(void);

/* 向手机发 FFE1 notify；未连接/未使能时直接丢弃 */
void hub_app_notify(const uint8_t *data, uint16_t length);

bool hub_app_notify_enabled(void);

#ifdef __cplusplus
}
#endif
#endif /* __HUB_APP_H__ */

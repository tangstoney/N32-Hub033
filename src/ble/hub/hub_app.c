/**
 * @file    hub_app.c
 * @brief   N32-Hub 0xFFE0 服务（复用 SDK 16-bit RDTSS）
 */
#include <string.h>
#include <stdio.h>

#include "rwip_config.h"

#if (BLE_RDTSS_16BIT_SERVER)

#include "attm.h"
#include "co_utils.h"
#include "gapm_task.h"
#include "ke_msg.h"
#include "ns_ble.h"
#include "prf.h"
#include "rdts_common.h"
#include "rdtss_16bit.h"
#include "rdtss_16bit_task.h"

#include "hub_app.h"

static const uint16_t hub_svc_uuid = HUB_SVC_UUID;

static const struct attm_desc hub_att_db[HUB_IDX_NB] =
{
    [HUB_IDX_SVC]        = {ATT_DECL_PRIMARY_SERVICE, PERM(RD, ENABLE), 0, 0},

    [HUB_IDX_WRITE_CHAR] = {ATT_DECL_CHARACTERISTIC,
                            PERM(RD, ENABLE) | PERM(WRITE_REQ, ENABLE), 0, 0},
    [HUB_IDX_WRITE_VAL]  = {HUB_CHAR_WRITE_UUID,
                            PERM(WRITE_COMMAND, ENABLE) | PERM(WRITE_REQ, ENABLE), 0, 0x200},

    [HUB_IDX_NTF_CHAR]   = {ATT_DECL_CHARACTERISTIC,
                            PERM(RD, ENABLE) | PERM(WRITE_REQ, ENABLE), 0, 0},
    [HUB_IDX_NTF_VAL]    = {HUB_CHAR_NOTIFY_UUID, PERM(NTF, ENABLE), 0, 0x200},
    [HUB_IDX_NTF_CFG]    = {ATT_DESC_CLIENT_CHAR_CFG,
                            PERM(RD, ENABLE) | PERM(WRITE_REQ, ENABLE), 0, 0},
};

static bool s_ntf_enabled;

static void hub_on_write(const uint8_t *data, uint16_t length)
{
    uint16_t i;

    if (length == 0U) {
        return;
    }

    printf("[ble] rx %u:", (unsigned)length);
    for (i = 0U; i < length && i < 16U; i++) {
        printf(" %02X", data[i]);
    }
    printf("\r\n");

    /* M1：原样回显到 FFE1 */
    hub_app_notify(data, length);
}

static int hub_write_ind_handler(ke_msg_id_t const msgid,
                                 struct rdtss_16bit_val_write_ind const *ind,
                                 ke_task_id_t const dest_id,
                                 ke_task_id_t const src_id)
{
    (void)msgid;
    (void)dest_id;
    (void)src_id;

    printf("[ble] write h=%u len=%u\r\n",
           (unsigned)ind->handle, (unsigned)ind->length);

    switch (ind->handle) {
    case HUB_IDX_WRITE_VAL:
        hub_on_write(ind->value, ind->length);
        break;

    case HUB_IDX_NTF_CFG:
        if (ind->length >= 2U) {
            uint16_t cfg = (uint16_t)(ind->value[0] | ((uint16_t)ind->value[1] << 8));
            s_ntf_enabled = (cfg & PRF_CLI_START_NTF) != 0U;
            printf("[ble] notify %s\r\n", s_ntf_enabled ? "on" : "off");
        }
        break;

    default:
        break;
    }

    return KE_MSG_CONSUMED;
}

static int hub_ntf_cfm_handler(ke_msg_id_t const msgid,
                               struct rdtss_16bit_val_ntf_cfm const *cfm,
                               ke_task_id_t const dest_id,
                               ke_task_id_t const src_id)
{
    (void)msgid;
    (void)cfm;
    (void)dest_id;
    (void)src_id;
    return KE_MSG_CONSUMED;
}

static const struct ke_msg_handler hub_app_msg_handler_list[] =
{
    {RDTSS_16BIT_VAL_WRITE_IND, (ke_msg_func_t)hub_write_ind_handler},
    {RDTSS_16BIT_VAL_NTF_CFM,   (ke_msg_func_t)hub_ntf_cfm_handler},
};

static const struct app_subtask_handlers hub_app_handlers = APP_HANDLERS(hub_app);

void hub_app_init(void)
{
    struct prf_task_t prf;
    struct prf_get_func_t get_func;

    prf.prf_task_id      = TASK_ID_RDTSS_16BIT;
    prf.prf_task_handler = &hub_app_handlers;
    ns_ble_prf_task_register(&prf);

    get_func.task_id          = TASK_ID_RDTSS_16BIT;
    get_func.prf_itf_get_func = rdtss_16bit_prf_itf_get;
    prf_get_itf_func_register(&get_func);
}

void hub_app_add(void)
{
    struct rdtss_16bit_db_cfg *db_cfg;
    struct gapm_profile_task_add_cmd *req = KE_MSG_ALLOC_DYN(GAPM_PROFILE_TASK_ADD_CMD,
                                                             TASK_GAPM,
                                                             TASK_APP,
                                                             gapm_profile_task_add_cmd,
                                                             sizeof(struct rdtss_16bit_db_cfg));

    printf("[ble] hub svc add\r\n");

    req->operation   = GAPM_PROFILE_TASK_ADD;
    req->sec_lvl     = PERM(SVC_AUTH, NO_AUTH);
    req->prf_task_id = TASK_ID_RDTSS_16BIT;
    req->app_task    = TASK_APP;
    req->start_hdl   = 0;

    db_cfg = (struct rdtss_16bit_db_cfg *)req->param;
    db_cfg->att_tbl    = hub_att_db;
    db_cfg->svc_uuid   = &hub_svc_uuid;
    db_cfg->max_nb_att = HUB_IDX_NB;

    ke_msg_send(req);

    hub_app_init();
}

void hub_app_notify(const uint8_t *data, uint16_t length)
{
    uint8_t conidx;
    struct rdtss_16bit_val_ntf_ind_req *req;

    if (length == 0U) {
        return;
    }

    conidx = ns_ble_get_conidx_by_role(ROLE_SLAVE);
    if (conidx == GAP_INVALID_CONIDX) {
        conidx = app_env.conidx;
    }
    if (conidx == GAP_INVALID_CONIDX) {
        printf("[ble] notify: no conn\r\n");
        return;
    }

    printf("[ble] notify %u -> conidx %u\r\n",
           (unsigned)length, (unsigned)conidx);

    req = KE_MSG_ALLOC_DYN(RDTSS_16BIT_VAL_NTF_REQ,
                           prf_get_task_from_id(TASK_ID_RDTSS_16BIT),
                           TASK_APP,
                           rdtss_16bit_val_ntf_ind_req,
                           length);

    req->conidx       = conidx;
    req->notification = true;
    req->handle       = HUB_IDX_NTF_VAL;
    req->length       = length;
    memcpy(&req->value[0], data, length);

    ke_msg_send(req);
}

bool hub_app_notify_enabled(void)
{
    return s_ntf_enabled;
}

#endif /* BLE_RDTSS_16BIT_SERVER */

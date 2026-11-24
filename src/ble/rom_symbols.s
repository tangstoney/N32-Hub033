/* 由 symbol_wb033.obj (Keil SYMDEFS) 自动生成，勿手改 */
/* T 符号为 Thumb 函数（保留 bit0=1）：地址在 0x0000_xxxx，离 Flash 约 16.8MB，*/
/* 超出 BL 的 ±16MB 范围，ld 会自动生成 push{r0}/bx ip 的长跳转 veneer——这是正常的，不是 ARM 互跳 */
	.syntax unified
	.thumb
	.text
	.global __asm___11_rom_delay_c_98fa6311____REV16
	.type __asm___11_rom_delay_c_98fa6311____REV16, %function
	.set __asm___11_rom_delay_c_98fa6311____REV16, 0x000000f9
	.global __asm___11_rom_delay_c_98fa6311____REVSH
	.type __asm___11_rom_delay_c_98fa6311____REVSH, %function
	.set __asm___11_rom_delay_c_98fa6311____REVSH, 0x000000fd
	.global rom_delay_cycles
	.type rom_delay_cycles, %function
	.set rom_delay_cycles, 0x00000101
	.global ATOMIC_BE
	.type ATOMIC_BE, %function
	.set ATOMIC_BE, 0x00000641
	.global ATOMIC_CE
	.type ATOMIC_CE, %function
	.set ATOMIC_CE, 0x00000675
	.global ATOMIC_CMD_RUID
	.type ATOMIC_CMD_RUID, %function
	.set ATOMIC_CMD_RUID, 0x000006a5
	.global ATOMIC_OTP_ERASE
	.type ATOMIC_OTP_ERASE, %function
	.set ATOMIC_OTP_ERASE, 0x000006d9
	.global ATOMIC_OTP_LOCK
	.type ATOMIC_OTP_LOCK, %function
	.set ATOMIC_OTP_LOCK, 0x0000070d
	.global ATOMIC_OTP_READ
	.type ATOMIC_OTP_READ, %function
	.set ATOMIC_OTP_READ, 0x00000741
	.global ATOMIC_OTP_WRITE
	.type ATOMIC_OTP_WRITE, %function
	.set ATOMIC_OTP_WRITE, 0x0000077d
	.global ATOMIC_PP
	.type ATOMIC_PP, %function
	.set ATOMIC_PP, 0x000007b9
	.global ATOMIC_QPP
	.type ATOMIC_QPP, %function
	.set ATOMIC_QPP, 0x000007f5
	.global ATOMIC_QREAD
	.type ATOMIC_QREAD, %function
	.set ATOMIC_QREAD, 0x00000831
	.global ATOMIC_READ
	.type ATOMIC_READ, %function
	.set ATOMIC_READ, 0x0000086d
	.global ATOMIC_SE
	.type ATOMIC_SE, %function
	.set ATOMIC_SE, 0x000008a9
	.global Add2SelfBigHex256
	.type Add2SelfBigHex256, %function
	.set Add2SelfBigHex256, 0x000008dd
	.global AddBigHex256
	.type AddBigHex256, %function
	.set AddBigHex256, 0x00000925
	.global AddBigHexModP256
	.type AddBigHexModP256, %function
	.set AddBigHexModP256, 0x00000975
	.global AddP256
	.type AddP256, %function
	.set AddP256, 0x000009c5
	.global AddPdiv2_256
	.type AddPdiv2_256, %function
	.set AddPdiv2_256, 0x000009f5
	.global ModuleIrqRegister
	.type ModuleIrqRegister, %function
	.set ModuleIrqRegister, 0x00001d11
	.global ROM_BE
	.type ROM_BE, %function
	.set ROM_BE, 0x00001f6b
	.global ROM_CE
	.type ROM_CE, %function
	.set ROM_CE, 0x00001f83
	.global ROM_OTP_ERASE
	.type ROM_OTP_ERASE, %function
	.set ROM_OTP_ERASE, 0x00001f97
	.global ROM_OTP_LOCK
	.type ROM_OTP_LOCK, %function
	.set ROM_OTP_LOCK, 0x00001faf
	.global ROM_OTP_READ
	.type ROM_OTP_READ, %function
	.set ROM_OTP_READ, 0x00001fc7
	.global ROM_OTP_WRITE
	.type ROM_OTP_WRITE, %function
	.set ROM_OTP_WRITE, 0x00001fe7
	.global ROM_PP
	.type ROM_PP, %function
	.set ROM_PP, 0x00002007
	.global ROM_QPP
	.type ROM_QPP, %function
	.set ROM_QPP, 0x00002027
	.global ROM_QREAD
	.type ROM_QREAD, %function
	.set ROM_QREAD, 0x00002047
	.global ROM_READ
	.type ROM_READ, %function
	.set ROM_READ, 0x00002067
	.global ROM_SE
	.type ROM_SE, %function
	.set ROM_SE, 0x00002087
	.global SubtractBigHex256
	.type SubtractBigHex256, %function
	.set SubtractBigHex256, 0x000020f1
	.global SubtractBigHexMod256
	.type SubtractBigHexMod256, %function
	.set SubtractBigHexMod256, 0x0000214d
	.global SubtractFromSelfBigHex256
	.type SubtractFromSelfBigHex256, %function
	.set SubtractFromSelfBigHex256, 0x00002249
	.global SubtractFromSelfBigHexSign256
	.type SubtractFromSelfBigHexSign256, %function
	.set SubtractFromSelfBigHexSign256, 0x0000229d
	.global aes_alloc
	.type aes_alloc, %function
	.set aes_alloc, 0x00002623
	.global aes_c1
	.type aes_c1, %function
	.set aes_c1, 0x00002639
	.global aes_cmac
	.type aes_cmac, %function
	.set aes_cmac, 0x000026bd
	.global aes_cmac_continue
	.type aes_cmac_continue, %function
	.set aes_cmac_continue, 0x00002709
	.global aes_cmac_start
	.type aes_cmac_start, %function
	.set aes_cmac_start, 0x00002835
	.global aes_encrypt
	.type aes_encrypt, %function
	.set aes_encrypt, 0x00002865
	.global aes_f4
	.type aes_f4, %function
	.set aes_f4, 0x000028f9
	.global aes_f5
	.type aes_f5, %function
	.set aes_f5, 0x0000294d
	.global aes_f6
	.type aes_f6, %function
	.set aes_f6, 0x00002a71
	.global aes_g2
	.type aes_g2, %function
	.set aes_g2, 0x00002af1
	.global aes_init
	.type aes_init, %function
	.set aes_init, 0x00002b49
	.global aes_rand
	.type aes_rand, %function
	.set aes_rand, 0x00002b99
	.global aes_result_handler
	.type aes_result_handler, %function
	.set aes_result_handler, 0x00002bc9
	.global aes_rpa_gen
	.type aes_rpa_gen, %function
	.set aes_rpa_gen, 0x00002c21
	.global aes_rpa_resolve
	.type aes_rpa_resolve, %function
	.set aes_rpa_resolve, 0x00002cb5
	.global aes_shift_left_128
	.type aes_shift_left_128, %function
	.set aes_shift_left_128, 0x00002d99
	.global aes_start
	.type aes_start, %function
	.set aes_start, 0x00002dc1
	.global aes_xor_128
	.type aes_xor_128, %function
	.set aes_xor_128, 0x00002df1
	.global ahi_init
	.type ahi_init, %function
	.set ahi_init, 0x00002e11
	.global ahi_send_msg
	.type ahi_send_msg, %function
	.set ahi_send_msg, 0x00002e71
	.global attc_l2cc_pdu_recv_handler
	.type attc_l2cc_pdu_recv_handler, %function
	.set attc_l2cc_pdu_recv_handler, 0x0000354d
	.global attc_send_att_req
	.type attc_send_att_req, %function
	.set attc_send_att_req, 0x00003c09
	.global attc_send_execute
	.type attc_send_execute, %function
	.set attc_send_execute, 0x00003c35
	.global attc_send_hdl_cfm
	.type attc_send_hdl_cfm, %function
	.set attc_send_hdl_cfm, 0x00003c59
	.global attc_send_read_ind
	.type attc_send_read_ind, %function
	.set attc_send_read_ind, 0x00003c79
	.global attm_att_get_perm
	.type attm_att_get_perm, %function
	.set attm_att_get_perm, 0x00003d9d
	.global attm_att_set_value
	.type attm_att_set_value, %function
	.set attm_att_set_value, 0x00003db9
	.global attm_att_update_perm
	.type attm_att_update_perm, %function
	.set attm_att_update_perm, 0x00003e8d
	.global attm_convert_to128
	.type attm_convert_to128, %function
	.set attm_convert_to128, 0x00003f05
	.global attm_get_value
	.type attm_get_value, %function
	.set attm_get_value, 0x00003f4d
	.global attm_init
	.type attm_init, %function
	.set attm_init, 0x000040c9
	.global attm_is_bt16_uuid
	.type attm_is_bt16_uuid, %function
	.set attm_is_bt16_uuid, 0x000040ed
	.global attm_is_bt32_uuid
	.type attm_is_bt32_uuid, %function
	.set attm_is_bt32_uuid, 0x00004125
	.global attm_svc_create_db
	.type attm_svc_create_db, %function
	.set attm_svc_create_db, 0x00004165
	.global attm_svc_create_db_128
	.type attm_svc_create_db_128, %function
	.set attm_svc_create_db_128, 0x0000425b
	.global attm_svc_get_permission
	.type attm_svc_get_permission, %function
	.set attm_svc_get_permission, 0x00004381
	.global attm_uuid16_comp
	.type attm_uuid16_comp, %function
	.set attm_uuid16_comp, 0x0000439f
	.global attm_uuid_comp
	.type attm_uuid_comp, %function
	.set attm_uuid_comp, 0x000043ad
	.global attmdb_add_service
	.type attmdb_add_service, %function
	.set attmdb_add_service, 0x00004419
	.global attmdb_att_get_permission
	.type attmdb_att_get_permission, %function
	.set attmdb_att_get_permission, 0x00004499
	.global attmdb_destroy
	.type attmdb_destroy, %function
	.set attmdb_destroy, 0x000045ed
	.global attmdb_get_attribute
	.type attmdb_get_attribute, %function
	.set attmdb_get_attribute, 0x0000461d
	.global attmdb_get_max_len
	.type attmdb_get_max_len, %function
	.set attmdb_get_max_len, 0x00004651
	.global attmdb_get_next_att
	.type attmdb_get_next_att, %function
	.set attmdb_get_next_att, 0x000046c5
	.global attmdb_get_service
	.type attmdb_get_service, %function
	.set attmdb_get_service, 0x00004749
	.global attmdb_get_uuid
	.type attmdb_get_uuid, %function
	.set attmdb_get_uuid, 0x0000479d
	.global attmdb_hash_compute
	.type attmdb_hash_compute, %function
	.set attmdb_hash_compute, 0x00004885
	.global attmdb_svc_check_hdl
	.type attmdb_svc_check_hdl, %function
	.set attmdb_svc_check_hdl, 0x00004dad
	.global attmdb_uuid16_comp
	.type attmdb_uuid16_comp, %function
	.set attmdb_uuid16_comp, 0x00005015
	.global atts_clear_prep_data
	.type atts_clear_prep_data, %function
	.set atts_clear_prep_data, 0x00005059
	.global atts_clear_read_cache
	.type atts_clear_read_cache, %function
	.set atts_clear_read_cache, 0x00005095
	.global atts_clear_rsp_data
	.type atts_clear_rsp_data, %function
	.set atts_clear_rsp_data, 0x000050b5
	.global atts_l2cc_pdu_recv_handler
	.type atts_l2cc_pdu_recv_handler, %function
	.set atts_l2cc_pdu_recv_handler, 0x000057f9
	.global atts_process_pdu
	.type atts_process_pdu, %function
	.set atts_process_pdu, 0x00005a89
	.global atts_send_error
	.type atts_send_error, %function
	.set atts_send_error, 0x00006171
	.global atts_send_event
	.type atts_send_event, %function
	.set atts_send_event, 0x00006195
	.global atts_write_rsp_send
	.type atts_write_rsp_send, %function
	.set atts_write_rsp_send, 0x0000634d
	.global atts_write_signed_cfm
	.type atts_write_signed_cfm, %function
	.set atts_write_signed_cfm, 0x00006403
	.global baseband_init
	.type baseband_init, %function
	.set baseband_init, 0x00006449
	.global bigHexInversion256
	.type bigHexInversion256, %function
	.set bigHexInversion256, 0x000064a5
	.global ble_util_buf_acl_tx_alloc
	.type ble_util_buf_acl_tx_alloc, %function
	.set ble_util_buf_acl_tx_alloc, 0x000066d9
	.global ble_util_buf_acl_tx_elt_get
	.type ble_util_buf_acl_tx_elt_get, %function
	.set ble_util_buf_acl_tx_elt_get, 0x00006701
	.global ble_util_buf_acl_tx_free
	.type ble_util_buf_acl_tx_free, %function
	.set ble_util_buf_acl_tx_free, 0x00006791
	.global ble_util_buf_adv_tx_alloc
	.type ble_util_buf_adv_tx_alloc, %function
	.set ble_util_buf_adv_tx_alloc, 0x00006835
	.global ble_util_buf_adv_tx_free
	.type ble_util_buf_adv_tx_free, %function
	.set ble_util_buf_adv_tx_free, 0x0000685d
	.global ble_util_buf_init
	.type ble_util_buf_init, %function
	.set ble_util_buf_init, 0x000068e1
	.global ble_util_buf_llcp_tx_alloc
	.type ble_util_buf_llcp_tx_alloc, %function
	.set ble_util_buf_llcp_tx_alloc, 0x00006a4d
	.global ble_util_buf_llcp_tx_free
	.type ble_util_buf_llcp_tx_free, %function
	.set ble_util_buf_llcp_tx_free, 0x00006a69
	.global ble_util_buf_rx_alloc
	.type ble_util_buf_rx_alloc, %function
	.set ble_util_buf_rx_alloc, 0x00006ac5
	.global ble_util_buf_rx_free
	.type ble_util_buf_rx_free, %function
	.set ble_util_buf_rx_free, 0x00006add
	.global chn_table_init_chip
	.type chn_table_init_chip, %function
	.set chn_table_init_chip, 0x00006b81
	.global co_bdaddr_compare
	.type co_bdaddr_compare, %function
	.set co_bdaddr_compare, 0x00006c2f
	.global co_ble_pkt_dur_in_us
	.type co_ble_pkt_dur_in_us, %function
	.set co_ble_pkt_dur_in_us, 0x00006c4f
	.global co_list_extract
	.type co_list_extract, %function
	.set co_list_extract, 0x00006c81
	.global co_list_extract_sublist
	.type co_list_extract_sublist, %function
	.set co_list_extract_sublist, 0x00006cbb
	.global co_list_init
	.type co_list_init, %function
	.set co_list_init, 0x00006cd5
	.global co_list_insert_after
	.type co_list_insert_after, %function
	.set co_list_insert_after, 0x00006cdd
	.global co_list_insert_before
	.type co_list_insert_before, %function
	.set co_list_insert_before, 0x00006d13
	.global co_list_pool_init
	.type co_list_pool_init, %function
	.set co_list_pool_init, 0x00006d63
	.global co_list_pop_front
	.type co_list_pop_front, %function
	.set co_list_pop_front, 0x00006d85
	.global co_list_push_back
	.type co_list_push_back, %function
	.set co_list_push_back, 0x00006d99
	.global co_list_push_back_sublist
	.type co_list_push_back_sublist, %function
	.set co_list_push_back_sublist, 0x00006db9
	.global co_list_push_front
	.type co_list_push_front, %function
	.set co_list_push_front, 0x00006dd9
	.global co_list_size
	.type co_list_size, %function
	.set co_list_size, 0x00006df1
	.global co_nb_good_le_channels
	.type co_nb_good_le_channels, %function
	.set co_nb_good_le_channels, 0x00006e09
	.global co_util_pack
	.type co_util_pack, %function
	.set co_util_pack, 0x00006e31
	.global co_util_unpack
	.type co_util_unpack, %function
	.set co_util_unpack, 0x00007019
	.global dl_upd_proc_start
	.type dl_upd_proc_start, %function
	.set dl_upd_proc_start, 0x00007255
	.global ecc_gen_new_public_key
	.type ecc_gen_new_public_key, %function
	.set ecc_gen_new_public_key, 0x000072c1
	.global ecc_gen_new_secret_key
	.type ecc_gen_new_secret_key, %function
	.set ecc_gen_new_secret_key, 0x000072e1
	.global ecc_generate_key256
	.type ecc_generate_key256, %function
	.set ecc_generate_key256, 0x000073d1
	.global ecc_init
	.type ecc_init, %function
	.set ecc_init, 0x00007761
	.global flash_enable_quad_mode
	.type flash_enable_quad_mode, %function
	.set flash_enable_quad_mode, 0x00007ce1
	.global flash_enter_xip
	.type flash_enter_xip, %function
	.set flash_enter_xip, 0x00007d03
	.global flash_exit_xip
	.type flash_exit_xip, %function
	.set flash_exit_xip, 0x00007d3d
	.global flash_init_by_id
	.type flash_init_by_id, %function
	.set flash_init_by_id, 0x00007d75
	.global flash_jump
	.type flash_jump, %function
	.set flash_jump, 0x00007e05
	.global flash_power
	.type flash_power, %function
	.set flash_power, 0x00007e71
	.global flash_read_id
	.type flash_read_id, %function
	.set flash_read_id, 0x00007e91
	.global flash_reset
	.type flash_reset, %function
	.set flash_reset, 0x00007ea1
	.global flash_set_qsip_mode
	.type flash_set_qsip_mode, %function
	.set flash_set_qsip_mode, 0x00007f35
	.global gapc_auth_get
	.type gapc_auth_get, %function
	.set gapc_auth_get, 0x00007f79
	.global gapc_auth_set
	.type gapc_auth_set, %function
	.set gapc_auth_set, 0x00007fb1
	.global gapc_bond_cfm_handler
	.type gapc_bond_cfm_handler, %function
	.set gapc_bond_cfm_handler, 0x00008011
	.global gapc_bond_cmd_handler
	.type gapc_bond_cmd_handler, %function
	.set gapc_bond_cmd_handler, 0x00008545
	.global gapc_cmp_evt_handler
	.type gapc_cmp_evt_handler, %function
	.set gapc_cmp_evt_handler, 0x00008791
	.global gapc_con_cleanup
	.type gapc_con_cleanup, %function
	.set gapc_con_cleanup, 0x000087f9
	.global gapc_con_create
	.type gapc_con_create, %function
	.set gapc_con_create, 0x00008809
	.global gapc_enc_keysize_get
	.type gapc_enc_keysize_get, %function
	.set gapc_enc_keysize_get, 0x00008b01
	.global gapc_encrypt_cfm_handler
	.type gapc_encrypt_cfm_handler, %function
	.set gapc_encrypt_cfm_handler, 0x00008b1d
	.global gapc_encrypt_cmd_handler
	.type gapc_encrypt_cmd_handler, %function
	.set gapc_encrypt_cmd_handler, 0x00008b8d
	.global gapc_gen_dh_key_ind_handler
	.type gapc_gen_dh_key_ind_handler, %function
	.set gapc_gen_dh_key_ind_handler, 0x00008c31
	.global gapc_get_bdaddr
	.type gapc_get_bdaddr, %function
	.set gapc_get_bdaddr, 0x00008c7d
	.global gapc_get_chan_sel_algo
	.type gapc_get_chan_sel_algo, %function
	.set gapc_get_chan_sel_algo, 0x00008ca1
	.global gapc_get_conhdl
	.type gapc_get_conhdl, %function
	.set gapc_get_conhdl, 0x00008cb9
	.global gapc_get_conidx
	.type gapc_get_conidx, %function
	.set gapc_get_conidx, 0x00008cd9
	.global gapc_get_dest_task
	.type gapc_get_dest_task, %function
	.set gapc_get_dest_task, 0x00008d05
	.global gapc_get_operation
	.type gapc_get_operation, %function
	.set gapc_get_operation, 0x0000901d
	.global gapc_get_operation_ptr
	.type gapc_get_operation_ptr, %function
	.set gapc_get_operation_ptr, 0x00009039
	.global gapc_get_requester
	.type gapc_get_requester, %function
	.set gapc_get_requester, 0x00009049
	.global gapc_get_role
	.type gapc_get_role, %function
	.set gapc_get_role, 0x00009069
	.global gapc_hci_handler
	.type gapc_hci_handler, %function
	.set gapc_hci_handler, 0x00009089
	.global gapc_init
	.type gapc_init, %function
	.set gapc_init, 0x000090fd
	.global gapc_is_local_addr_rpa
	.type gapc_is_local_addr_rpa, %function
	.set gapc_is_local_addr_rpa, 0x00009159
	.global gapc_is_sec_set
	.type gapc_is_sec_set, %function
	.set gapc_is_sec_set, 0x0000916d
	.global gapc_key_press_notification_cmd_handler
	.type gapc_key_press_notification_cmd_handler, %function
	.set gapc_key_press_notification_cmd_handler, 0x000091a9
	.global gapc_lk_sec_lvl_get
	.type gapc_lk_sec_lvl_get, %function
	.set gapc_lk_sec_lvl_get, 0x00009239
	.global gapc_param_update_sanity
	.type gapc_param_update_sanity, %function
	.set gapc_param_update_sanity, 0x00009509
	.global gapc_peer_att_info_ind_handler
	.type gapc_peer_att_info_ind_handler, %function
	.set gapc_peer_att_info_ind_handler, 0x0000953d
	.global gapc_per_adv_sync_trans_cmd_handler
	.type gapc_per_adv_sync_trans_cmd_handler, %function
	.set gapc_per_adv_sync_trans_cmd_handler, 0x000095a5
	.global gapc_process_op
	.type gapc_process_op, %function
	.set gapc_process_op, 0x0000965d
	.global gapc_reschedule_operation
	.type gapc_reschedule_operation, %function
	.set gapc_reschedule_operation, 0x000096fd
	.global gapc_security_cmd_handler
	.type gapc_security_cmd_handler, %function
	.set gapc_security_cmd_handler, 0x00009731
	.global gapc_send_complete_evt
	.type gapc_send_complete_evt, %function
	.set gapc_send_complete_evt, 0x000097cd
	.global gapc_send_disconect_ind
	.type gapc_send_disconect_ind, %function
	.set gapc_send_disconect_ind, 0x00009841
	.global gapc_send_error_evt
	.type gapc_send_error_evt, %function
	.set gapc_send_error_evt, 0x00009865
	.global gapc_set_local_addr
	.type gapc_set_local_addr, %function
	.set gapc_set_local_addr, 0x000099a5
	.global gapc_set_operation_ptr
	.type gapc_set_operation_ptr, %function
	.set gapc_set_operation_ptr, 0x00009a15
	.global gapc_sig_pdu_recv_handler
	.type gapc_sig_pdu_recv_handler, %function
	.set gapc_sig_pdu_recv_handler, 0x00009b3d
	.global gapc_sig_send_param_resp
	.type gapc_sig_send_param_resp, %function
	.set gapc_sig_send_param_resp, 0x00009b75
	.global gapc_sign_cmd_handler
	.type gapc_sign_cmd_handler, %function
	.set gapc_sign_cmd_handler, 0x00009b95
	.global gapc_smp_cleanup
	.type gapc_smp_cleanup, %function
	.set gapc_smp_cleanup, 0x0000a425
	.global gapc_smp_gapm_cmp_evt_handler
	.type gapc_smp_gapm_cmp_evt_handler, %function
	.set gapc_smp_gapm_cmp_evt_handler, 0x0000a5e5
	.global gapc_smp_pdu_recv
	.type gapc_smp_pdu_recv, %function
	.set gapc_smp_pdu_recv, 0x0000ad89
	.global gapc_smp_rep_attempts_timer_handler
	.type gapc_smp_rep_attempts_timer_handler, %function
	.set gapc_smp_rep_attempts_timer_handler, 0x0000b651
	.global gapc_smp_timeout_timer_ind_handler
	.type gapc_smp_timeout_timer_ind_handler, %function
	.set gapc_smp_timeout_timer_ind_handler, 0x0000b8f9
	.global gapc_update_state
	.type gapc_update_state, %function
	.set gapc_update_state, 0x0000bb81
	.global gapm_activity_create_cmd_handler
	.type gapm_activity_create_cmd_handler, %function
	.set gapm_activity_create_cmd_handler, 0x0000bbb9
	.global gapm_activity_delete_cmd_handler
	.type gapm_activity_delete_cmd_handler, %function
	.set gapm_activity_delete_cmd_handler, 0x0000bca1
	.global gapm_activity_start_cmd_handler
	.type gapm_activity_start_cmd_handler, %function
	.set gapm_activity_start_cmd_handler, 0x0000bd31
	.global gapm_activity_stop_cmd_handler
	.type gapm_activity_stop_cmd_handler, %function
	.set gapm_activity_stop_cmd_handler, 0x0000bda1
	.global gapm_actv_alloc
	.type gapm_actv_alloc, %function
	.set gapm_actv_alloc, 0x0000be49
	.global gapm_actv_created
	.type gapm_actv_created, %function
	.set gapm_actv_created, 0x0000be79
	.global gapm_actv_deleted
	.type gapm_actv_deleted, %function
	.set gapm_actv_deleted, 0x0000bee1
	.global gapm_actv_get_hci_own_addr_type
	.type gapm_actv_get_hci_own_addr_type, %function
	.set gapm_actv_get_hci_own_addr_type, 0x0000bf85
	.global gapm_actv_info_get
	.type gapm_actv_info_get, %function
	.set gapm_actv_info_get, 0x0000bfa9
	.global gapm_actv_rand_addr_set_ind
	.type gapm_actv_rand_addr_set_ind, %function
	.set gapm_actv_rand_addr_set_ind, 0x0000bfed
	.global gapm_actv_reset
	.type gapm_actv_reset, %function
	.set gapm_actv_reset, 0x0000c009
	.global gapm_actv_retrieve_cmd_cmp_evt
	.type gapm_actv_retrieve_cmd_cmp_evt, %function
	.set gapm_actv_retrieve_cmd_cmp_evt, 0x0000c089
	.global gapm_actv_started
	.type gapm_actv_started, %function
	.set gapm_actv_started, 0x0000c0c1
	.global gapm_actv_stopped
	.type gapm_actv_stopped, %function
	.set gapm_actv_stopped, 0x0000c0ed
	.global gapm_addr_init
	.type gapm_addr_init, %function
	.set gapm_addr_init, 0x0000c289
	.global gapm_addr_renew_cmd_handler
	.type gapm_addr_renew_cmd_handler, %function
	.set gapm_addr_renew_cmd_handler, 0x0000c2a5
	.global gapm_addr_renew_to_ind_handler
	.type gapm_addr_renew_to_ind_handler, %function
	.set gapm_addr_renew_to_ind_handler, 0x0000c395
	.global gapm_addr_set_rand_addr
	.type gapm_addr_set_rand_addr, %function
	.set gapm_addr_set_rand_addr, 0x0000c3bd
	.global gapm_adv_create
	.type gapm_adv_create, %function
	.set gapm_adv_create, 0x0000c495
	.global gapm_auto_conn_to_ind_handler
	.type gapm_auto_conn_to_ind_handler, %function
	.set gapm_auto_conn_to_ind_handler, 0x0000ca31
	.global gapm_con_cleanup
	.type gapm_con_cleanup, %function
	.set gapm_con_cleanup, 0x0000cbb1
	.global gapm_con_create
	.type gapm_con_create, %function
	.set gapm_con_create, 0x0000cbf1
	.global gapm_dev_bdaddr_ind_handler
	.type gapm_dev_bdaddr_ind_handler, %function
	.set gapm_dev_bdaddr_ind_handler, 0x0000cc8d
	.global gapm_dle_val_check
	.type gapm_dle_val_check, %function
	.set gapm_dle_val_check, 0x0000ccd5
	.global gapm_gen_dh_key_cmd_handler
	.type gapm_gen_dh_key_cmd_handler, %function
	.set gapm_gen_dh_key_cmd_handler, 0x0000ccf5
	.global gapm_gen_oob_data_cmd_handler
	.type gapm_gen_oob_data_cmd_handler, %function
	.set gapm_gen_oob_data_cmd_handler, 0x0000cd4d
	.global gapm_gen_rand_addr_cmd_handler
	.type gapm_gen_rand_addr_cmd_handler, %function
	.set gapm_gen_rand_addr_cmd_handler, 0x0000cd75
	.global gapm_get_address_type
	.type gapm_get_address_type, %function
	.set gapm_get_address_type, 0x0000cde5
	.global gapm_get_att_handle
	.type gapm_get_att_handle, %function
	.set gapm_get_att_handle, 0x0000cdf5
	.global gapm_get_bdaddr
	.type gapm_get_bdaddr, %function
	.set gapm_get_bdaddr, 0x0000ce39
	.global gapm_get_dev_info_cmd_handler
	.type gapm_get_dev_info_cmd_handler, %function
	.set gapm_get_dev_info_cmd_handler, 0x0000ce41
	.global gapm_get_id_from_task
	.type gapm_get_id_from_task, %function
	.set gapm_get_id_from_task, 0x0000cf75
	.global gapm_get_irk
	.type gapm_get_irk, %function
	.set gapm_get_irk, 0x0000cfd1
	.global gapm_get_max_mtu
	.type gapm_get_max_mtu, %function
	.set gapm_get_max_mtu, 0x0000cfd9
	.global gapm_get_operation
	.type gapm_get_operation, %function
	.set gapm_get_operation, 0x0000cfe5
	.global gapm_get_pub_key_cmd_handler
	.type gapm_get_pub_key_cmd_handler, %function
	.set gapm_get_pub_key_cmd_handler, 0x0000cffd
	.global gapm_get_ral_addr_cmd_handler
	.type gapm_get_ral_addr_cmd_handler, %function
	.set gapm_get_ral_addr_cmd_handler, 0x0000d025
	.global gapm_get_requester
	.type gapm_get_requester, %function
	.set gapm_get_requester, 0x0000d07d
	.global gapm_get_task_from_id
	.type gapm_get_task_from_id, %function
	.set gapm_get_task_from_id, 0x0000d099
	.global gapm_init
	.type gapm_init, %function
	.set gapm_init, 0x0000d159
	.global gapm_init_attr
	.type gapm_init_attr, %function
	.set gapm_init_attr, 0x0000d20d
	.global gapm_init_connection_ind
	.type gapm_init_connection_ind, %function
	.set gapm_init_connection_ind, 0x0000d245
	.global gapm_init_create
	.type gapm_init_create, %function
	.set gapm_init_create, 0x0000d2fd
	.global gapm_is_addr_type_valid
	.type gapm_is_addr_type_valid, %function
	.set gapm_is_addr_type_valid, 0x0000d545
	.global gapm_is_legacy_pairing_supp
	.type gapm_is_legacy_pairing_supp, %function
	.set gapm_is_legacy_pairing_supp, 0x0000d57d
	.global gapm_is_pref_con_param_pres
	.type gapm_is_pref_con_param_pres, %function
	.set gapm_is_pref_con_param_pres, 0x0000d58d
	.global gapm_is_sec_con_pairing_supp
	.type gapm_is_sec_con_pairing_supp, %function
	.set gapm_is_sec_con_pairing_supp, 0x0000d59d
	.global gapm_le_test_mode_ctrl_cmd_handler
	.type gapm_le_test_mode_ctrl_cmd_handler, %function
	.set gapm_le_test_mode_ctrl_cmd_handler, 0x0000d5ad
	.global gapm_lepsm_register_cmd_handler
	.type gapm_lepsm_register_cmd_handler, %function
	.set gapm_lepsm_register_cmd_handler, 0x0000d69d
	.global gapm_lepsm_unregister_cmd_handler
	.type gapm_lepsm_unregister_cmd_handler, %function
	.set gapm_lepsm_unregister_cmd_handler, 0x0000d6c5
	.global gapm_list_set_cmd_handler
	.type gapm_list_set_cmd_handler, %function
	.set gapm_list_set_cmd_handler, 0x0000d6ed
	.global gapm_oob_data_get
	.type gapm_oob_data_get, %function
	.set gapm_oob_data_get, 0x0000d745
	.global gapm_oob_data_release
	.type gapm_oob_data_release, %function
	.set gapm_oob_data_release, 0x0000d751
	.global gapm_per_adv_report_ctrl_cmd_handler
	.type gapm_per_adv_report_ctrl_cmd_handler, %function
	.set gapm_per_adv_report_ctrl_cmd_handler, 0x0000d965
	.global gapm_per_sync_clear_fragments
	.type gapm_per_sync_clear_fragments, %function
	.set gapm_per_sync_clear_fragments, 0x0000d9e5
	.global gapm_per_sync_create
	.type gapm_per_sync_create, %function
	.set gapm_per_sync_create, 0x0000da09
	.global gapm_process_op
	.type gapm_process_op, %function
	.set gapm_process_op, 0x0000dd19
	.global gapm_profile_task_add_cmd_handler
	.type gapm_profile_task_add_cmd_handler, %function
	.set gapm_profile_task_add_cmd_handler, 0x0000ddcd
	.global gapm_reset_cmd_handler
	.type gapm_reset_cmd_handler, %function
	.set gapm_reset_cmd_handler, 0x0000de59
	.global gapm_resolv_addr_cmd_handler
	.type gapm_resolv_addr_cmd_handler, %function
	.set gapm_resolv_addr_cmd_handler, 0x0000def1
	.global gapm_scan_actv_clean
	.type gapm_scan_actv_clean, %function
	.set gapm_scan_actv_clean, 0x0000df41
	.global gapm_scan_create
	.type gapm_scan_create, %function
	.set gapm_scan_create, 0x0000df95
	.global gapm_send_complete_evt
	.type gapm_send_complete_evt, %function
	.set gapm_send_complete_evt, 0x0000e401
	.global gapm_send_error_evt
	.type gapm_send_error_evt, %function
	.set gapm_send_error_evt, 0x0000e449
	.global gapm_set_adv_data_cmd_handler
	.type gapm_set_adv_data_cmd_handler, %function
	.set gapm_set_adv_data_cmd_handler, 0x0000e46d
	.global gapm_set_channel_map_cmd_handler
	.type gapm_set_channel_map_cmd_handler, %function
	.set gapm_set_channel_map_cmd_handler, 0x0000e5cd
	.global gapm_set_dev_config_cmd_handler
	.type gapm_set_dev_config_cmd_handler, %function
	.set gapm_set_dev_config_cmd_handler, 0x0000e62d
	.global gapm_set_irk_cmd_handler
	.type gapm_set_irk_cmd_handler, %function
	.set gapm_set_irk_cmd_handler, 0x0000e7e9
	.global gapm_smpc_pub_key_ind_handler
	.type gapm_smpc_pub_key_ind_handler, %function
	.set gapm_smpc_pub_key_ind_handler, 0x0000ea8d
	.global gapm_use_enc_block_cmd_handler
	.type gapm_use_enc_block_cmd_handler, %function
	.set gapm_use_enc_block_cmd_handler, 0x0000eb09
	.global gattc_cleanup
	.type gattc_cleanup, %function
	.set gattc_cleanup, 0x0000ec85
	.global gattc_con_enable
	.type gattc_con_enable, %function
	.set gattc_con_enable, 0x0000eec9
	.global gattc_con_info_send
	.type gattc_con_info_send, %function
	.set gattc_con_info_send, 0x0000ef79
	.global gattc_create
	.type gattc_create, %function
	.set gattc_create, 0x0000efed
	.global gattc_db_updated
	.type gattc_db_updated, %function
	.set gattc_db_updated, 0x0000f06d
	.global gattc_disc_char_desc_ind_handler
	.type gattc_disc_char_desc_ind_handler, %function
	.set gattc_disc_char_desc_ind_handler, 0x0000f0dd
	.global gattc_disc_char_ind_handler
	.type gattc_disc_char_ind_handler, %function
	.set gattc_disc_char_ind_handler, 0x0000f149
	.global gattc_disc_svc_incl_ind_handler
	.type gattc_disc_svc_incl_ind_handler, %function
	.set gattc_disc_svc_incl_ind_handler, 0x0000f341
	.global gattc_disc_svc_ind_handler
	.type gattc_disc_svc_ind_handler, %function
	.set gattc_disc_svc_ind_handler, 0x0000f3b1
	.global gattc_get_mtu
	.type gattc_get_mtu, %function
	.set gattc_get_mtu, 0x0000f491
	.global gattc_get_operation
	.type gattc_get_operation, %function
	.set gattc_get_operation, 0x0000f4a1
	.global gattc_get_operation_ptr
	.type gattc_get_operation_ptr, %function
	.set gattc_get_operation_ptr, 0x0000f4bd
	.global gattc_get_requester
	.type gattc_get_requester, %function
	.set gattc_get_requester, 0x0000f4cd
	.global gattc_init
	.type gattc_init, %function
	.set gattc_init, 0x0000f4ed
	.global gattc_is_db_out_of_sync
	.type gattc_is_db_out_of_sync, %function
	.set gattc_is_db_out_of_sync, 0x0000f549
	.global gattc_process_op
	.type gattc_process_op, %function
	.set gattc_process_op, 0x0000f671
	.global gattc_rc_cmp_evt_handler
	.type gattc_rc_cmp_evt_handler, %function
	.set gattc_rc_cmp_evt_handler, 0x0000f72d
	.global gattc_rc_event_req_ind_handler
	.type gattc_rc_event_req_ind_handler, %function
	.set gattc_rc_event_req_ind_handler, 0x0000f739
	.global gattc_rc_read_ind_handler
	.type gattc_rc_read_ind_handler, %function
	.set gattc_rc_read_ind_handler, 0x0000f939
	.global gattc_rc_sdp_svc_ind_handler
	.type gattc_rc_sdp_svc_ind_handler, %function
	.set gattc_rc_sdp_svc_ind_handler, 0x0000f985
	.global gattc_read_db_hash_cmd_handler
	.type gattc_read_db_hash_cmd_handler, %function
	.set gattc_read_db_hash_cmd_handler, 0x0000fc2d
	.global gattc_reschedule_operation
	.type gattc_reschedule_operation, %function
	.set gattc_reschedule_operation, 0x0000ff49
	.global gattc_robust_db_cache_en_cmd_handler
	.type gattc_robust_db_cache_en_cmd_handler, %function
	.set gattc_robust_db_cache_en_cmd_handler, 0x0000ff7d
	.global gattc_sdp_cmp_evt_handler
	.type gattc_sdp_cmp_evt_handler, %function
	.set gattc_sdp_cmp_evt_handler, 0x0000fffd
	.global gattc_sdp_svc_disc_cmd_handler
	.type gattc_sdp_svc_disc_cmd_handler, %function
	.set gattc_sdp_svc_disc_cmd_handler, 0x000101c5
	.global gattc_send_complete_evt
	.type gattc_send_complete_evt, %function
	.set gattc_send_complete_evt, 0x00010295
	.global gattc_send_error_evt
	.type gattc_send_error_evt, %function
	.set gattc_send_error_evt, 0x000102f5
	.global gattc_set_mtu
	.type gattc_set_mtu, %function
	.set gattc_set_mtu, 0x00010379
	.global gattc_set_operation_ptr
	.type gattc_set_operation_ptr, %function
	.set gattc_set_operation_ptr, 0x000103e1
	.global gattc_svc_att_info_req_ind_handler
	.type gattc_svc_att_info_req_ind_handler, %function
	.set gattc_svc_att_info_req_ind_handler, 0x000103f1
	.global gattc_svc_chg_cfm_handler
	.type gattc_svc_chg_cfm_handler, %function
	.set gattc_svc_chg_cfm_handler, 0x0001043d
	.global gattc_svc_chg_ind_send
	.type gattc_svc_chg_ind_send, %function
	.set gattc_svc_chg_ind_send, 0x00010479
	.global gattc_svc_read_req_ind_handler
	.type gattc_svc_read_req_ind_handler, %function
	.set gattc_svc_read_req_ind_handler, 0x000104cd
	.global gattc_svc_write_req_ind_handler
	.type gattc_svc_write_req_ind_handler, %function
	.set gattc_svc_write_req_ind_handler, 0x00010569
	.global gattc_update_state
	.type gattc_update_state, %function
	.set gattc_update_state, 0x000106ad
	.global gattm_att_hdl_to_idx
	.type gattm_att_hdl_to_idx, %function
	.set gattm_att_hdl_to_idx, 0x00010a45
	.global gattm_att_idx_to_hdl
	.type gattm_att_idx_to_hdl, %function
	.set gattm_att_idx_to_hdl, 0x00010a65
	.global gattm_cleanup
	.type gattm_cleanup, %function
	.set gattm_cleanup, 0x00010aad
	.global gattm_create
	.type gattm_create, %function
	.set gattm_create, 0x00010ab7
	.global gattm_db_updated
	.type gattm_db_updated, %function
	.set gattm_db_updated, 0x00010ac1
	.global gattm_init
	.type gattm_init, %function
	.set gattm_init, 0x00010b09
	.global gattm_init_attr
	.type gattm_init_attr, %function
	.set gattm_init_attr, 0x00010b39
	.global h4tl_init
	.type h4tl_init, %function
	.set h4tl_init, 0x00010c55
	.global h4tl_read_start_next
	.type h4tl_read_start_next, %function
	.set h4tl_read_start_next, 0x00010ce5
	.global h4tl_write
	.type h4tl_write, %function
	.set h4tl_write, 0x00010f99
	.global hci_acl_data_handler
	.type hci_acl_data_handler, %function
	.set hci_acl_data_handler, 0x00011005
	.global hci_acl_tx_data_alloc
	.type hci_acl_tx_data_alloc, %function
	.set hci_acl_tx_data_alloc, 0x00011171
	.global hci_acl_tx_data_received
	.type hci_acl_tx_data_received, %function
	.set hci_acl_tx_data_received, 0x000111d9
	.global hci_basic_cmd_cmp_evt_cfg_handler
	.type hci_basic_cmd_cmp_evt_cfg_handler, %function
	.set hci_basic_cmd_cmp_evt_cfg_handler, 0x00011259
	.global hci_basic_cmd_cmp_evt_rl_cfg_handler
	.type hci_basic_cmd_cmp_evt_rl_cfg_handler, %function
	.set hci_basic_cmd_cmp_evt_rl_cfg_handler, 0x000112e5
	.global hci_basic_cmd_send_2_controller
	.type hci_basic_cmd_send_2_controller, %function
	.set hci_basic_cmd_send_2_controller, 0x00011331
	.global hci_ble_conhdl_register
	.type hci_ble_conhdl_register, %function
	.set hci_ble_conhdl_register, 0x00011349
	.global hci_ble_conhdl_unregister
	.type hci_ble_conhdl_unregister, %function
	.set hci_ble_conhdl_unregister, 0x00011359
	.global hci_cmd_get_max_param_size
	.type hci_cmd_get_max_param_size, %function
	.set hci_cmd_get_max_param_size, 0x00011369
	.global hci_cmd_received
	.type hci_cmd_received, %function
	.set hci_cmd_received, 0x0001137d
	.global hci_command_handler
	.type hci_command_handler, %function
	.set hci_command_handler, 0x000116c1
	.global hci_disconnect_cmd_handler
	.type hci_disconnect_cmd_handler, %function
	.set hci_disconnect_cmd_handler, 0x0001174d
	.global hci_enc_chg_evt_handler
	.type hci_enc_chg_evt_handler, %function
	.set hci_enc_chg_evt_handler, 0x000117e5
	.global hci_enc_key_refr_evt_handler
	.type hci_enc_key_refr_evt_handler, %function
	.set hci_enc_key_refr_evt_handler, 0x00011807
	.global hci_evt_mask_set
	.type hci_evt_mask_set, %function
	.set hci_evt_mask_set, 0x00011829
	.global hci_fc_acl_buf_size_set
	.type hci_fc_acl_buf_size_set, %function
	.set hci_fc_acl_buf_size_set, 0x00011881
	.global hci_fc_acl_en
	.type hci_fc_acl_en, %function
	.set hci_fc_acl_en, 0x00011895
	.global hci_fc_acl_packet_sent
	.type hci_fc_acl_packet_sent, %function
	.set hci_fc_acl_packet_sent, 0x000118c9
	.global hci_fc_check_host_available_nb_acl_packets
	.type hci_fc_check_host_available_nb_acl_packets, %function
	.set hci_fc_check_host_available_nb_acl_packets, 0x000118dd
	.global hci_fc_host_nb_acl_pkts_complete
	.type hci_fc_host_nb_acl_pkts_complete, %function
	.set hci_fc_host_nb_acl_pkts_complete, 0x00011901
	.global hci_fc_init
	.type hci_fc_init, %function
	.set hci_fc_init, 0x00011919
	.global hci_init
	.type hci_init, %function
	.set hci_init, 0x00011a19
	.global hci_is_ext_host
	.type hci_is_ext_host, %function
	.set hci_is_ext_host, 0x00011a65
	.global hci_le_add_dev_to_per_adv_list_cmd_handler
	.type hci_le_add_dev_to_per_adv_list_cmd_handler, %function
	.set hci_le_add_dev_to_per_adv_list_cmd_handler, 0x00011a71
	.global hci_le_adv_set_term_evt_handler
	.type hci_le_adv_set_term_evt_handler, %function
	.set hci_le_adv_set_term_evt_handler, 0x00011dcd
	.global hci_le_ch_sel_algo_evt_handler
	.type hci_le_ch_sel_algo_evt_handler, %function
	.set hci_le_ch_sel_algo_evt_handler, 0x00011e55
	.global hci_le_clear_adv_sets_cmd_handler
	.type hci_le_clear_adv_sets_cmd_handler, %function
	.set hci_le_clear_adv_sets_cmd_handler, 0x00011e79
	.global hci_le_clear_per_adv_list_cmd_handler
	.type hci_le_clear_per_adv_list_cmd_handler, %function
	.set hci_le_clear_per_adv_list_cmd_handler, 0x00011eed
	.global hci_le_cmd_cmp_evt_addr_handler
	.type hci_le_cmd_cmp_evt_addr_handler, %function
	.set hci_le_cmd_cmp_evt_addr_handler, 0x0001201d
	.global hci_le_cmd_cmp_evt_adv_handler
	.type hci_le_cmd_cmp_evt_adv_handler, %function
	.set hci_le_cmd_cmp_evt_adv_handler, 0x0001204d
	.global hci_le_cmd_cmp_evt_init_handler
	.type hci_le_cmd_cmp_evt_init_handler, %function
	.set hci_le_cmd_cmp_evt_init_handler, 0x00012261
	.global hci_le_cmd_cmp_evt_list_handler
	.type hci_le_cmd_cmp_evt_list_handler, %function
	.set hci_le_cmd_cmp_evt_list_handler, 0x000122e9
	.global hci_le_cmd_cmp_evt_per_sync_handler
	.type hci_le_cmd_cmp_evt_per_sync_handler, %function
	.set hci_le_cmd_cmp_evt_per_sync_handler, 0x00012449
	.global hci_le_cmd_cmp_evt_scan_handler
	.type hci_le_cmd_cmp_evt_scan_handler, %function
	.set hci_le_cmd_cmp_evt_scan_handler, 0x00012485
	.global hci_le_con_upd_cmd_handler
	.type hci_le_con_upd_cmd_handler, %function
	.set hci_le_con_upd_cmd_handler, 0x000124f1
	.global hci_le_create_con_cancel_cmd_handler
	.type hci_le_create_con_cancel_cmd_handler, %function
	.set hci_le_create_con_cancel_cmd_handler, 0x000126b1
	.global hci_le_create_con_cmd_handler
	.type hci_le_create_con_cmd_handler, %function
	.set hci_le_create_con_cmd_handler, 0x00012711
	.global hci_le_enh_con_cmp_evt_handler
	.type hci_le_enh_con_cmp_evt_handler, %function
	.set hci_le_enh_con_cmp_evt_handler, 0x00012ae9
	.global hci_le_ext_adv_report_evt_handler
	.type hci_le_ext_adv_report_evt_handler, %function
	.set hci_le_ext_adv_report_evt_handler, 0x00012b15
	.global hci_le_ext_create_con_cmd_handler
	.type hci_le_ext_create_con_cmd_handler, %function
	.set hci_le_ext_create_con_cmd_handler, 0x00012e8d
	.global hci_le_gen_dhkey_cmp_evt_handler
	.type hci_le_gen_dhkey_cmp_evt_handler, %function
	.set hci_le_gen_dhkey_cmp_evt_handler, 0x0001331d
	.global hci_le_gen_dhkey_v2_stat_evt_handler
	.type hci_le_gen_dhkey_v2_stat_evt_handler, %function
	.set hci_le_gen_dhkey_v2_stat_evt_handler, 0x00013435
	.global hci_le_ltk_req_neg_reply_cmd_handler
	.type hci_le_ltk_req_neg_reply_cmd_handler, %function
	.set hci_le_ltk_req_neg_reply_cmd_handler, 0x00013461
	.global hci_le_ltk_req_reply_cmd_handler
	.type hci_le_ltk_req_reply_cmd_handler, %function
	.set hci_le_ltk_req_reply_cmd_handler, 0x000134fd
	.global hci_le_ltk_request_evt_handler
	.type hci_le_ltk_request_evt_handler, %function
	.set hci_le_ltk_request_evt_handler, 0x00013571
	.global hci_le_per_adv_create_sync_cancel_cmd_handler
	.type hci_le_per_adv_create_sync_cancel_cmd_handler, %function
	.set hci_le_per_adv_create_sync_cancel_cmd_handler, 0x00013675
	.global hci_le_per_adv_create_sync_cmd_handler
	.type hci_le_per_adv_create_sync_cmd_handler, %function
	.set hci_le_per_adv_create_sync_cmd_handler, 0x00013749
	.global hci_le_per_adv_report_evt_handler
	.type hci_le_per_adv_report_evt_handler, %function
	.set hci_le_per_adv_report_evt_handler, 0x0001380d
	.global hci_le_per_adv_set_info_transf_cmd_handler
	.type hci_le_per_adv_set_info_transf_cmd_handler, %function
	.set hci_le_per_adv_set_info_transf_cmd_handler, 0x00013885
	.global hci_le_per_adv_sync_est_evt_handler
	.type hci_le_per_adv_sync_est_evt_handler, %function
	.set hci_le_per_adv_sync_est_evt_handler, 0x0001392d
	.global hci_le_per_adv_sync_lost_evt_handler
	.type hci_le_per_adv_sync_lost_evt_handler, %function
	.set hci_le_per_adv_sync_lost_evt_handler, 0x000139b1
	.global hci_le_per_adv_sync_transf_cmd_handler
	.type hci_le_per_adv_sync_transf_cmd_handler, %function
	.set hci_le_per_adv_sync_transf_cmd_handler, 0x000139d1
	.global hci_le_per_adv_sync_transf_rec_evt_handler
	.type hci_le_per_adv_sync_transf_rec_evt_handler, %function
	.set hci_le_per_adv_sync_transf_rec_evt_handler, 0x00013a61
	.global hci_le_per_adv_term_sync_cmd_handler
	.type hci_le_per_adv_term_sync_cmd_handler, %function
	.set hci_le_per_adv_term_sync_cmd_handler, 0x00013b29
	.global hci_le_rd_adv_ch_tx_pw_cmd_handler
	.type hci_le_rd_adv_ch_tx_pw_cmd_handler, %function
	.set hci_le_rd_adv_ch_tx_pw_cmd_handler, 0x00013c29
	.global hci_le_rd_adv_chnl_tx_pw_cmd_cmp_evt_handler
	.type hci_le_rd_adv_chnl_tx_pw_cmd_cmp_evt_handler, %function
	.set hci_le_rd_adv_chnl_tx_pw_cmd_cmp_evt_handler, 0x00013c75
	.global hci_le_rd_chnl_map_cmd_handler
	.type hci_le_rd_chnl_map_cmd_handler, %function
	.set hci_le_rd_chnl_map_cmd_handler, 0x00013ce9
	.global hci_le_rd_local_p256_public_key_cmp_evt_handler
	.type hci_le_rd_local_p256_public_key_cmp_evt_handler, %function
	.set hci_le_rd_local_p256_public_key_cmp_evt_handler, 0x00013db9
	.global hci_le_rd_max_adv_data_len_cmd_handler
	.type hci_le_rd_max_adv_data_len_cmd_handler, %function
	.set hci_le_rd_max_adv_data_len_cmd_handler, 0x00013e99
	.global hci_le_rd_max_data_len_cmd_cmp_evt_handler
	.type hci_le_rd_max_data_len_cmd_cmp_evt_handler, %function
	.set hci_le_rd_max_data_len_cmd_cmp_evt_handler, 0x00013ee1
	.global hci_le_rd_nb_supp_adv_sets_cmd_cmp_evt_handler
	.type hci_le_rd_nb_supp_adv_sets_cmd_cmp_evt_handler, %function
	.set hci_le_rd_nb_supp_adv_sets_cmd_cmp_evt_handler, 0x00013f55
	.global hci_le_rd_nb_supp_adv_sets_cmd_handler
	.type hci_le_rd_nb_supp_adv_sets_cmd_handler, %function
	.set hci_le_rd_nb_supp_adv_sets_cmd_handler, 0x00013f91
	.global hci_le_rd_pal_size_cmd_cmp_evt_handler
	.type hci_le_rd_pal_size_cmd_cmp_evt_handler, %function
	.set hci_le_rd_pal_size_cmd_cmp_evt_handler, 0x00013ffd
	.global hci_le_rd_per_adv_list_size_cmd_handler
	.type hci_le_rd_per_adv_list_size_cmd_handler, %function
	.set hci_le_rd_per_adv_list_size_cmd_handler, 0x00014099
	.global hci_le_rd_phy_cmd_handler
	.type hci_le_rd_phy_cmd_handler, %function
	.set hci_le_rd_phy_cmd_handler, 0x00014129
	.global hci_le_rd_ral_addr_cmd_cmp_evt_handler
	.type hci_le_rd_ral_addr_cmd_cmp_evt_handler, %function
	.set hci_le_rd_ral_addr_cmd_cmp_evt_handler, 0x00014181
	.global hci_le_rd_ral_size_cmd_cmp_evt_handler
	.type hci_le_rd_ral_size_cmd_cmp_evt_handler, %function
	.set hci_le_rd_ral_size_cmd_cmp_evt_handler, 0x000141ed
	.global hci_le_rd_rem_feats_cmd_handler
	.type hci_le_rd_rem_feats_cmd_handler, %function
	.set hci_le_rd_rem_feats_cmd_handler, 0x00014249
	.global hci_le_rd_rf_path_comp_cmd_cmp_evt_handler
	.type hci_le_rd_rf_path_comp_cmd_cmp_evt_handler, %function
	.set hci_le_rd_rf_path_comp_cmd_cmp_evt_handler, 0x000143a1
	.global hci_le_rd_suggted_dft_data_len_cmd_cmp_evt_handler
	.type hci_le_rd_suggted_dft_data_len_cmd_cmp_evt_handler, %function
	.set hci_le_rd_suggted_dft_data_len_cmd_cmp_evt_handler, 0x00014441
	.global hci_le_rd_tx_pwr_cmd_cmp_evt_handler
	.type hci_le_rd_tx_pwr_cmd_cmp_evt_handler, %function
	.set hci_le_rd_tx_pwr_cmd_cmp_evt_handler, 0x000144e1
	.global hci_le_rd_wlst_size_cmd_cmp_evt_handler
	.type hci_le_rd_wlst_size_cmd_cmp_evt_handler, %function
	.set hci_le_rd_wlst_size_cmd_cmp_evt_handler, 0x00014599
	.global hci_le_read_max_adv_data_len_cmd_cmp_evt_handler
	.type hci_le_read_max_adv_data_len_cmd_cmp_evt_handler, %function
	.set hci_le_read_max_adv_data_len_cmd_cmp_evt_handler, 0x000145f5
	.global hci_le_rem_con_param_req_neg_reply_cmd_handler
	.type hci_le_rem_con_param_req_neg_reply_cmd_handler, %function
	.set hci_le_rem_con_param_req_neg_reply_cmd_handler, 0x0001468d
	.global hci_le_rem_con_param_req_reply_cmd_handler
	.type hci_le_rem_con_param_req_reply_cmd_handler, %function
	.set hci_le_rem_con_param_req_reply_cmd_handler, 0x000146f1
	.global hci_le_rmv_adv_set_cmd_handler
	.type hci_le_rmv_adv_set_cmd_handler, %function
	.set hci_le_rmv_adv_set_cmd_handler, 0x00014785
	.global hci_le_rmv_dev_from_per_adv_list_cmd_handler
	.type hci_le_rmv_dev_from_per_adv_list_cmd_handler, %function
	.set hci_le_rmv_dev_from_per_adv_list_cmd_handler, 0x000147e9
	.global hci_le_rx_test_v1_cmd_handler
	.type hci_le_rx_test_v1_cmd_handler, %function
	.set hci_le_rx_test_v1_cmd_handler, 0x0001495d
	.global hci_le_rx_test_v2_cmd_handler
	.type hci_le_rx_test_v2_cmd_handler, %function
	.set hci_le_rx_test_v2_cmd_handler, 0x0001499f
	.global hci_le_rx_test_v3_cmd_handler
	.type hci_le_rx_test_v3_cmd_handler, %function
	.set hci_le_rx_test_v3_cmd_handler, 0x000149f1
	.global hci_le_scan_req_rcvd_evt_handler
	.type hci_le_scan_req_rcvd_evt_handler, %function
	.set hci_le_scan_req_rcvd_evt_handler, 0x00014a95
	.global hci_le_scan_timeout_evt_handler
	.type hci_le_scan_timeout_evt_handler, %function
	.set hci_le_scan_timeout_evt_handler, 0x00014aed
	.global hci_le_set_adv_data_cmd_handler
	.type hci_le_set_adv_data_cmd_handler, %function
	.set hci_le_set_adv_data_cmd_handler, 0x00014b4d
	.global hci_le_set_adv_en_cmd_handler
	.type hci_le_set_adv_en_cmd_handler, %function
	.set hci_le_set_adv_en_cmd_handler, 0x00014c05
	.global hci_le_set_adv_param_cmd_handler
	.type hci_le_set_adv_param_cmd_handler, %function
	.set hci_le_set_adv_param_cmd_handler, 0x00014e51
	.global hci_le_set_adv_set_rand_addr_cmd_handler
	.type hci_le_set_adv_set_rand_addr_cmd_handler, %function
	.set hci_le_set_adv_set_rand_addr_cmd_handler, 0x00014fc1
	.global hci_le_set_data_len_cmd_handler
	.type hci_le_set_data_len_cmd_handler, %function
	.set hci_le_set_data_len_cmd_handler, 0x0001505d
	.global hci_le_set_ext_adv_data_cmd_handler
	.type hci_le_set_ext_adv_data_cmd_handler, %function
	.set hci_le_set_ext_adv_data_cmd_handler, 0x00015249
	.global hci_le_set_ext_adv_en_cmd_handler
	.type hci_le_set_ext_adv_en_cmd_handler, %function
	.set hci_le_set_ext_adv_en_cmd_handler, 0x00015421
	.global hci_le_set_ext_adv_param_cmd_handler
	.type hci_le_set_ext_adv_param_cmd_handler, %function
	.set hci_le_set_ext_adv_param_cmd_handler, 0x000159e9
	.global hci_le_set_ext_scan_en_cmd_handler
	.type hci_le_set_ext_scan_en_cmd_handler, %function
	.set hci_le_set_ext_scan_en_cmd_handler, 0x00015bf1
	.global hci_le_set_ext_scan_param_cmd_handler
	.type hci_le_set_ext_scan_param_cmd_handler, %function
	.set hci_le_set_ext_scan_param_cmd_handler, 0x00015e45
	.global hci_le_set_ext_scan_rsp_data_cmd_handler
	.type hci_le_set_ext_scan_rsp_data_cmd_handler, %function
	.set hci_le_set_ext_scan_rsp_data_cmd_handler, 0x0001604d
	.global hci_le_set_per_adv_data_cmd_handler
	.type hci_le_set_per_adv_data_cmd_handler, %function
	.set hci_le_set_per_adv_data_cmd_handler, 0x0001623d
	.global hci_le_set_per_adv_en_cmd_handler
	.type hci_le_set_per_adv_en_cmd_handler, %function
	.set hci_le_set_per_adv_en_cmd_handler, 0x000163ad
	.global hci_le_set_per_adv_param_cmd_handler
	.type hci_le_set_per_adv_param_cmd_handler, %function
	.set hci_le_set_per_adv_param_cmd_handler, 0x0001657d
	.global hci_le_set_per_adv_rec_en_cmd_handler
	.type hci_le_set_per_adv_rec_en_cmd_handler, %function
	.set hci_le_set_per_adv_rec_en_cmd_handler, 0x00016689
	.global hci_le_set_per_adv_rec_en_cmp_evt_handler
	.type hci_le_set_per_adv_rec_en_cmp_evt_handler, %function
	.set hci_le_set_per_adv_rec_en_cmp_evt_handler, 0x000166e9
	.global hci_le_set_per_adv_sync_transf_param_cmd_handler
	.type hci_le_set_per_adv_sync_transf_param_cmd_handler, %function
	.set hci_le_set_per_adv_sync_transf_param_cmd_handler, 0x0001670d
	.global hci_le_set_phy_cmd_handler
	.type hci_le_set_phy_cmd_handler, %function
	.set hci_le_set_phy_cmd_handler, 0x00016781
	.global hci_le_set_scan_en_cmd_handler
	.type hci_le_set_scan_en_cmd_handler, %function
	.set hci_le_set_scan_en_cmd_handler, 0x000169ed
	.global hci_le_set_scan_param_cmd_handler
	.type hci_le_set_scan_param_cmd_handler, %function
	.set hci_le_set_scan_param_cmd_handler, 0x00016bb1
	.global hci_le_set_scan_rsp_data_cmd_handler
	.type hci_le_set_scan_rsp_data_cmd_handler, %function
	.set hci_le_set_scan_rsp_data_cmd_handler, 0x00016cd1
	.global hci_le_start_enc_cmd_handler
	.type hci_le_start_enc_cmd_handler, %function
	.set hci_le_start_enc_cmd_handler, 0x00016d89
	.global hci_le_start_enc_stat_evt_handler
	.type hci_le_start_enc_stat_evt_handler, %function
	.set hci_le_start_enc_stat_evt_handler, 0x00016e6d
	.global hci_le_test_end_cmd_handler
	.type hci_le_test_end_cmd_handler, %function
	.set hci_le_test_end_cmd_handler, 0x00016e95
	.global hci_le_tx_test_v1_cmd_handler
	.type hci_le_tx_test_v1_cmd_handler, %function
	.set hci_le_tx_test_v1_cmd_handler, 0x00016ec1
	.global hci_le_tx_test_v2_cmd_handler
	.type hci_le_tx_test_v2_cmd_handler, %function
	.set hci_le_tx_test_v2_cmd_handler, 0x00016f91
	.global hci_le_tx_test_v3_cmd_handler
	.type hci_le_tx_test_v3_cmd_handler, %function
	.set hci_le_tx_test_v3_cmd_handler, 0x00016fed
	.global hci_look_for_cmd_desc
	.type hci_look_for_cmd_desc, %function
	.set hci_look_for_cmd_desc, 0x00017121
	.global hci_look_for_evt_desc
	.type hci_look_for_evt_desc, %function
	.set hci_look_for_evt_desc, 0x0001717d
	.global hci_look_for_le_evt_desc
	.type hci_look_for_le_evt_desc, %function
	.set hci_look_for_le_evt_desc, 0x000171a5
	.global hci_past_cmd_cmp_evt_handler
	.type hci_past_cmd_cmp_evt_handler, %function
	.set hci_past_cmd_cmp_evt_handler, 0x00017267
	.global hci_rd_auth_payl_to_cmd_handler
	.type hci_rd_auth_payl_to_cmd_handler, %function
	.set hci_rd_auth_payl_to_cmd_handler, 0x000172f5
	.global hci_rd_local_ver_info_cmd_cmp_evt_handler
	.type hci_rd_local_ver_info_cmd_cmp_evt_handler, %function
	.set hci_rd_local_ver_info_cmd_cmp_evt_handler, 0x00017451
	.global hci_rd_rem_ver_info_cmd_handler
	.type hci_rd_rem_ver_info_cmd_handler, %function
	.set hci_rd_rem_ver_info_cmd_handler, 0x00017521
	.global hci_rd_rssi_cmd_handler
	.type hci_rd_rssi_cmd_handler, %function
	.set hci_rd_rssi_cmd_handler, 0x00017689
	.global hci_rd_tx_pwr_lvl_cmd_handler
	.type hci_rd_tx_pwr_lvl_cmd_handler, %function
	.set hci_rd_tx_pwr_lvl_cmd_handler, 0x000176fd
	.global hci_send_2_controller
	.type hci_send_2_controller, %function
	.set hci_send_2_controller, 0x000177a1
	.global hci_send_2_host
	.type hci_send_2_host, %function
	.set hci_send_2_host, 0x00017821
	.global hci_test_end_cmd_cmp_evt_handler
	.type hci_test_end_cmd_cmp_evt_handler, %function
	.set hci_test_end_cmd_cmp_evt_handler, 0x000179b9
	.global hci_tl_init
	.type hci_tl_init, %function
	.set hci_tl_init, 0x00017a09
	.global hci_tl_send
	.type hci_tl_send, %function
	.set hci_tl_send, 0x00017a45
	.global hci_vs_set_max_rx_size_and_time_cmd_handler
	.type hci_vs_set_max_rx_size_and_time_cmd_handler, %function
	.set hci_vs_set_max_rx_size_and_time_cmd_handler, 0x00017e51
	.global hci_vs_set_pref_slave_evt_dur_cmd_handler
	.type hci_vs_set_pref_slave_evt_dur_cmd_handler, %function
	.set hci_vs_set_pref_slave_evt_dur_cmd_handler, 0x00017f7d
	.global hci_vs_set_pref_slave_latency_cmd_handler
	.type hci_vs_set_pref_slave_latency_cmd_handler, %function
	.set hci_vs_set_pref_slave_latency_cmd_handler, 0x00018011
	.global hci_wr_auth_payl_to_cmd_handler
	.type hci_wr_auth_payl_to_cmd_handler, %function
	.set hci_wr_auth_payl_to_cmd_handler, 0x00018091
	.global ke_check_malloc
	.type ke_check_malloc, %function
	.set ke_check_malloc, 0x000180f1
	.global ke_event_callback_set
	.type ke_event_callback_set, %function
	.set ke_event_callback_set, 0x00018181
	.global ke_event_clear
	.type ke_event_clear, %function
	.set ke_event_clear, 0x00018199
	.global ke_event_get_all
	.type ke_event_get_all, %function
	.set ke_event_get_all, 0x000181c1
	.global ke_event_init
	.type ke_event_init, %function
	.set ke_event_init, 0x000181cd
	.global ke_event_schedule
	.type ke_event_schedule, %function
	.set ke_event_schedule, 0x000181ed
	.global ke_event_set
	.type ke_event_set, %function
	.set ke_event_set, 0x00018241
	.global ke_flush
	.type ke_flush, %function
	.set ke_flush, 0x00018269
	.global ke_free
	.type ke_free, %function
	.set ke_free, 0x000182ad
	.global ke_init
	.type ke_init, %function
	.set ke_init, 0x00018379
	.global ke_is_free
	.type ke_is_free, %function
	.set ke_is_free, 0x000183a9
	.global ke_malloc
	.type ke_malloc, %function
	.set ke_malloc, 0x000183c1
	.global ke_mem_init
	.type ke_mem_init, %function
	.set ke_mem_init, 0x00018491
	.global ke_msg_alloc
	.type ke_msg_alloc, %function
	.set ke_msg_alloc, 0x000184cd
	.global ke_msg_discard
	.type ke_msg_discard, %function
	.set ke_msg_discard, 0x000184ff
	.global ke_msg_forward
	.type ke_msg_forward, %function
	.set ke_msg_forward, 0x00018505
	.global ke_msg_free
	.type ke_msg_free, %function
	.set ke_msg_free, 0x00018531
	.global ke_msg_in_queue
	.type ke_msg_in_queue, %function
	.set ke_msg_in_queue, 0x00018539
	.global ke_msg_send
	.type ke_msg_send, %function
	.set ke_msg_send, 0x00018545
	.global ke_msg_send_basic
	.type ke_msg_send_basic, %function
	.set ke_msg_send_basic, 0x0001856d
	.global ke_msg_src_id_get
	.type ke_msg_src_id_get, %function
	.set ke_msg_src_id_get, 0x000185b9
	.global ke_queue_extract
	.type ke_queue_extract, %function
	.set ke_queue_extract, 0x000185bf
	.global ke_queue_insert
	.type ke_queue_insert, %function
	.set ke_queue_insert, 0x00018601
	.global ke_sleep_check
	.type ke_sleep_check, %function
	.set ke_sleep_check, 0x00018635
	.global ke_state_get
	.type ke_state_get, %function
	.set ke_state_get, 0x00018649
	.global ke_state_set
	.type ke_state_set, %function
	.set ke_state_set, 0x0001866d
	.global ke_task_check
	.type ke_task_check, %function
	.set ke_task_check, 0x000186d5
	.global ke_task_create
	.type ke_task_create, %function
	.set ke_task_create, 0x000186f5
	.global ke_task_delete
	.type ke_task_delete, %function
	.set ke_task_delete, 0x00018729
	.global ke_task_init
	.type ke_task_init, %function
	.set ke_task_init, 0x00018755
	.global ke_task_msg_flush
	.type ke_task_msg_flush, %function
	.set ke_task_msg_flush, 0x00018771
	.global ke_timer_active
	.type ke_timer_active, %function
	.set ke_timer_active, 0x000188e5
	.global ke_timer_clear
	.type ke_timer_clear, %function
	.set ke_timer_clear, 0x00018911
	.global ke_timer_init
	.type ke_timer_init, %function
	.set ke_timer_init, 0x00018989
	.global ke_timer_set
	.type ke_timer_set, %function
	.set ke_timer_set, 0x00018a4d
	.global l2cc_cleanup
	.type l2cc_cleanup, %function
	.set l2cc_cleanup, 0x00018cfd
	.global l2cc_cmp_evt_handler
	.type l2cc_cmp_evt_handler, %function
	.set l2cc_cmp_evt_handler, 0x00018e97
	.global l2cc_create
	.type l2cc_create, %function
	.set l2cc_create, 0x00018edd
	.global l2cc_data_send
	.type l2cc_data_send, %function
	.set l2cc_data_send, 0x00018f25
	.global l2cc_init
	.type l2cc_init, %function
	.set l2cc_init, 0x000190fd
	.global l2cc_pdu_alloc
	.type l2cc_pdu_alloc, %function
	.set l2cc_pdu_alloc, 0x00019199
	.global l2cc_pdu_header_check
	.type l2cc_pdu_header_check, %function
	.set l2cc_pdu_header_check, 0x000191c5
	.global l2cc_pdu_pack
	.type l2cc_pdu_pack, %function
	.set l2cc_pdu_pack, 0x0001931d
	.global l2cc_pdu_rx_init
	.type l2cc_pdu_rx_init, %function
	.set l2cc_pdu_rx_init, 0x000196b9
	.global l2cc_pdu_send
	.type l2cc_pdu_send, %function
	.set l2cc_pdu_send, 0x00019735
	.global l2cc_pdu_unpack
	.type l2cc_pdu_unpack, %function
	.set l2cc_pdu_unpack, 0x0001979d
	.global l2cc_send_cmp_evt
	.type l2cc_send_cmp_evt, %function
	.set l2cc_send_cmp_evt, 0x00019a0d
	.global l2cc_sig_pdu_recv_handler
	.type l2cc_sig_pdu_recv_handler, %function
	.set l2cc_sig_pdu_recv_handler, 0x00019a39
	.global l2cc_sig_send_cmd_reject
	.type l2cc_sig_send_cmd_reject, %function
	.set l2cc_sig_send_cmd_reject, 0x00019a81
	.global l2cm_cleanup
	.type l2cm_cleanup, %function
	.set l2cm_cleanup, 0x00019ad9
	.global l2cm_create
	.type l2cm_create, %function
	.set l2cm_create, 0x00019af5
	.global l2cm_get_nb_buffer_available
	.type l2cm_get_nb_buffer_available, %function
	.set l2cm_get_nb_buffer_available, 0x00019afd
	.global l2cm_init
	.type l2cm_init, %function
	.set l2cm_init, 0x00019b09
	.global l2cm_set_link_layer_buff_size
	.type l2cm_set_link_layer_buff_size, %function
	.set l2cm_set_link_layer_buff_size, 0x00019b91
	.global l2cm_tx_status
	.type l2cm_tx_status, %function
	.set l2cm_tx_status, 0x00019ba1
	.global ll_channel_map_ind_handler
	.type ll_channel_map_ind_handler, %function
	.set ll_channel_map_ind_handler, 0x00019bd1
	.global ll_clk_acc_req_handler
	.type ll_clk_acc_req_handler, %function
	.set ll_clk_acc_req_handler, 0x00019c59
	.global ll_clk_acc_rsp_handler
	.type ll_clk_acc_rsp_handler, %function
	.set ll_clk_acc_rsp_handler, 0x00019cb5
	.global ll_connection_param_req_handler
	.type ll_connection_param_req_handler, %function
	.set ll_connection_param_req_handler, 0x00019cf1
	.global ll_connection_param_rsp_handler
	.type ll_connection_param_rsp_handler, %function
	.set ll_connection_param_rsp_handler, 0x00019dc9
	.global ll_connection_update_ind_handler
	.type ll_connection_update_ind_handler, %function
	.set ll_connection_update_ind_handler, 0x00019e61
	.global ll_enc_req_handler
	.type ll_enc_req_handler, %function
	.set ll_enc_req_handler, 0x00019f7d
	.global ll_enc_rsp_handler
	.type ll_enc_rsp_handler, %function
	.set ll_enc_rsp_handler, 0x0001a045
	.global ll_feature_req_handler
	.type ll_feature_req_handler, %function
	.set ll_feature_req_handler, 0x0001a0bd
	.global ll_feature_rsp_handler
	.type ll_feature_rsp_handler, %function
	.set ll_feature_rsp_handler, 0x0001a145
	.global ll_length_req_handler
	.type ll_length_req_handler, %function
	.set ll_length_req_handler, 0x0001a199
	.global ll_length_rsp_handler
	.type ll_length_rsp_handler, %function
	.set ll_length_rsp_handler, 0x0001a2e9
	.global ll_min_used_channels_ind_handler
	.type ll_min_used_channels_ind_handler, %function
	.set ll_min_used_channels_ind_handler, 0x0001a365
	.global ll_pause_enc_req_handler
	.type ll_pause_enc_req_handler, %function
	.set ll_pause_enc_req_handler, 0x0001a3e5
	.global ll_pause_enc_rsp_handler
	.type ll_pause_enc_rsp_handler, %function
	.set ll_pause_enc_rsp_handler, 0x0001a451
	.global ll_per_sync_ind_handler
	.type ll_per_sync_ind_handler, %function
	.set ll_per_sync_ind_handler, 0x0001a4a9
	.global ll_phy_req_handler
	.type ll_phy_req_handler, %function
	.set ll_phy_req_handler, 0x0001a611
	.global ll_phy_rsp_handler
	.type ll_phy_rsp_handler, %function
	.set ll_phy_rsp_handler, 0x0001a6c1
	.global ll_phy_update_ind_handler
	.type ll_phy_update_ind_handler, %function
	.set ll_phy_update_ind_handler, 0x0001a73d
	.global ll_ping_req_handler
	.type ll_ping_req_handler, %function
	.set ll_ping_req_handler, 0x0001a7b5
	.global ll_ping_rsp_handler
	.type ll_ping_rsp_handler, %function
	.set ll_ping_rsp_handler, 0x0001a7c9
	.global ll_slave_feature_req_handler
	.type ll_slave_feature_req_handler, %function
	.set ll_slave_feature_req_handler, 0x0001a825
	.global ll_start_enc_req_handler
	.type ll_start_enc_req_handler, %function
	.set ll_start_enc_req_handler, 0x0001a8ad
	.global ll_start_enc_rsp_handler
	.type ll_start_enc_rsp_handler, %function
	.set ll_start_enc_rsp_handler, 0x0001a8fd
	.global ll_terminate_ind_handler
	.type ll_terminate_ind_handler, %function
	.set ll_terminate_ind_handler, 0x0001a94d
	.global ll_version_ind_handler
	.type ll_version_ind_handler, %function
	.set ll_version_ind_handler, 0x0001a9b1
	.global llc_auth_payl_nearly_to_handler
	.type llc_auth_payl_nearly_to_handler, %function
	.set llc_auth_payl_nearly_to_handler, 0x0001aa79
	.global llc_auth_payl_real_to_handler
	.type llc_auth_payl_real_to_handler, %function
	.set llc_auth_payl_real_to_handler, 0x0001aadd
	.global llc_cleanup
	.type llc_cleanup, %function
	.set llc_cleanup, 0x0001ab6d
	.global llc_clk_acc_modify
	.type llc_clk_acc_modify, %function
	.set llc_clk_acc_modify, 0x0001abe9
	.global llc_cmd_cmp_send
	.type llc_cmd_cmp_send, %function
	.set llc_cmd_cmp_send, 0x0001acb9
	.global llc_cmd_stat_send
	.type llc_cmd_stat_send, %function
	.set llc_cmd_stat_send, 0x0001acd9
	.global llc_con_move_cbk
	.type llc_con_move_cbk, %function
	.set llc_con_move_cbk, 0x0001acf5
	.global llc_disconnect
	.type llc_disconnect, %function
	.set llc_disconnect, 0x0001ae25
	.global llc_encrypt_ind_handler
	.type llc_encrypt_ind_handler, %function
	.set llc_encrypt_ind_handler, 0x0001b04d
	.global llc_init
	.type llc_init, %function
	.set llc_init, 0x0001b2e5
	.global llc_init_term_proc
	.type llc_init_term_proc, %function
	.set llc_init_term_proc, 0x0001b3b1
	.global llc_le_ping_restart
	.type llc_le_ping_restart, %function
	.set llc_le_ping_restart, 0x0001b465
	.global llc_le_ping_set
	.type llc_le_ping_set, %function
	.set llc_le_ping_set, 0x0001b4a1
	.global llc_ll_reject_ind_pdu_send
	.type llc_ll_reject_ind_pdu_send, %function
	.set llc_ll_reject_ind_pdu_send, 0x0001b52d
	.global llc_llcp_send
	.type llc_llcp_send, %function
	.set llc_llcp_send, 0x0001b5b9
	.global llc_llcp_state_set
	.type llc_llcp_state_set, %function
	.set llc_llcp_state_set, 0x0001b635
	.global llc_llcp_tx_check
	.type llc_llcp_tx_check, %function
	.set llc_llcp_tx_check, 0x0001b6f1
	.global llc_op_ch_map_upd_ind_handler
	.type llc_op_ch_map_upd_ind_handler, %function
	.set llc_op_ch_map_upd_ind_handler, 0x0001c631
	.global llc_op_clk_acc_ind_handler
	.type llc_op_clk_acc_ind_handler, %function
	.set llc_op_clk_acc_ind_handler, 0x0001c695
	.global llc_op_con_upd_ind_handler
	.type llc_op_con_upd_ind_handler, %function
	.set llc_op_con_upd_ind_handler, 0x0001c6ed
	.global llc_op_disconnect_ind_handler
	.type llc_op_disconnect_ind_handler, %function
	.set llc_op_disconnect_ind_handler, 0x0001c781
	.global llc_op_dl_upd_ind_handler
	.type llc_op_dl_upd_ind_handler, %function
	.set llc_op_dl_upd_ind_handler, 0x0001c7f1
	.global llc_op_encrypt_ind_handler
	.type llc_op_encrypt_ind_handler, %function
	.set llc_op_encrypt_ind_handler, 0x0001c885
	.global llc_op_feats_exch_ind_handler
	.type llc_op_feats_exch_ind_handler, %function
	.set llc_op_feats_exch_ind_handler, 0x0001c8ed
	.global llc_op_le_ping_ind_handler
	.type llc_op_le_ping_ind_handler, %function
	.set llc_op_le_ping_ind_handler, 0x0001c985
	.global llc_op_past_ind_handler
	.type llc_op_past_ind_handler, %function
	.set llc_op_past_ind_handler, 0x0001c9e1
	.global llc_op_phy_upd_ind_handler
	.type llc_op_phy_upd_ind_handler, %function
	.set llc_op_phy_upd_ind_handler, 0x0001cc71
	.global llc_op_ver_exch_ind_handler
	.type llc_op_ver_exch_ind_handler, %function
	.set llc_op_ver_exch_ind_handler, 0x0001cd15
	.global llc_proc_collision_check
	.type llc_proc_collision_check, %function
	.set llc_proc_collision_check, 0x0001d191
	.global llc_proc_err_ind
	.type llc_proc_err_ind, %function
	.set llc_proc_err_ind, 0x0001d1c9
	.global llc_proc_get
	.type llc_proc_get, %function
	.set llc_proc_get, 0x0001d1f9
	.global llc_proc_id_get
	.type llc_proc_id_get, %function
	.set llc_proc_id_get, 0x0001d211
	.global llc_proc_reg
	.type llc_proc_reg, %function
	.set llc_proc_reg, 0x0001d22d
	.global llc_proc_state_get
	.type llc_proc_state_get, %function
	.set llc_proc_state_get, 0x0001d261
	.global llc_proc_state_set
	.type llc_proc_state_set, %function
	.set llc_proc_state_set, 0x0001d265
	.global llc_proc_timer_pause_set
	.type llc_proc_timer_pause_set, %function
	.set llc_proc_timer_pause_set, 0x0001d269
	.global llc_proc_timer_set
	.type llc_proc_timer_set, %function
	.set llc_proc_timer_set, 0x0001d2c1
	.global llc_proc_unreg
	.type llc_proc_unreg, %function
	.set llc_proc_unreg, 0x0001d319
	.global llc_start
	.type llc_start, %function
	.set llc_start, 0x0001ddd9
	.global llc_stop
	.type llc_stop, %function
	.set llc_stop, 0x0001dfe1
	.global llc_stopped_ind_handler
	.type llc_stopped_ind_handler, %function
	.set llc_stopped_ind_handler, 0x0001e015
	.global lld_aa_gen
	.type lld_aa_gen, %function
	.set lld_aa_gen, 0x0001e14d
	.global lld_acl_rx_ind_handler
	.type lld_acl_rx_ind_handler, %function
	.set lld_acl_rx_ind_handler, 0x0001e1cd
	.global lld_acl_tx_cfm_handler
	.type lld_acl_tx_cfm_handler, %function
	.set lld_acl_tx_cfm_handler, 0x0001e259
	.global lld_adv_adv_data_update
	.type lld_adv_adv_data_update, %function
	.set lld_adv_adv_data_update, 0x0001e389
	.global lld_adv_duration_update
	.type lld_adv_duration_update, %function
	.set lld_adv_duration_update, 0x0001e5a1
	.global lld_adv_end_ind_handler
	.type lld_adv_end_ind_handler, %function
	.set lld_adv_end_ind_handler, 0x0001e681
	.global lld_adv_evt_start_cbk
	.type lld_adv_evt_start_cbk, %function
	.set lld_adv_evt_start_cbk, 0x0001eb55
	.global lld_adv_init
	.type lld_adv_init, %function
	.set lld_adv_init, 0x0001fbd9
	.global lld_adv_rand_addr_update
	.type lld_adv_rand_addr_update, %function
	.set lld_adv_rand_addr_update, 0x0001ff5d
	.global lld_adv_rep_ind_handler
	.type lld_adv_rep_ind_handler, %function
	.set lld_adv_rep_ind_handler, 0x0001ffb1
	.global lld_adv_restart
	.type lld_adv_restart, %function
	.set lld_adv_restart, 0x000204b1
	.global lld_adv_scan_rsp_data_update
	.type lld_adv_scan_rsp_data_update, %function
	.set lld_adv_scan_rsp_data_update, 0x00020659
	.global lld_adv_start
	.type lld_adv_start, %function
	.set lld_adv_start, 0x00020691
	.global lld_adv_stop
	.type lld_adv_stop, %function
	.set lld_adv_stop, 0x00020d99
	.global lld_adv_sync_info_update
	.type lld_adv_sync_info_update, %function
	.set lld_adv_sync_info_update, 0x00020fa9
	.global lld_calc_aux_rx
	.type lld_calc_aux_rx, %function
	.set lld_calc_aux_rx, 0x0002102d
	.global lld_ch_assess_data_get
	.type lld_ch_assess_data_get, %function
	.set lld_ch_assess_data_get, 0x00021159
	.global lld_ch_idx_get
	.type lld_ch_idx_get, %function
	.set lld_ch_idx_get, 0x00021161
	.global lld_ch_map_set
	.type lld_ch_map_set, %function
	.set lld_ch_map_set, 0x00021185
	.global lld_ch_map_upd_cfm_handler
	.type lld_ch_map_upd_cfm_handler, %function
	.set lld_ch_map_upd_cfm_handler, 0x000211d1
	.global lld_channel_assess
	.type lld_channel_assess, %function
	.set lld_channel_assess, 0x00021209
	.global lld_con_activity_offset_compute
	.type lld_con_activity_offset_compute, %function
	.set lld_con_activity_offset_compute, 0x00021241
	.global lld_con_ch_map_update
	.type lld_con_ch_map_update, %function
	.set lld_con_ch_map_update, 0x000212b9
	.global lld_con_current_tx_power_get
	.type lld_con_current_tx_power_get, %function
	.set lld_con_current_tx_power_get, 0x000213f1
	.global lld_con_data_flow_set
	.type lld_con_data_flow_set, %function
	.set lld_con_data_flow_set, 0x00021431
	.global lld_con_data_len_update
	.type lld_con_data_len_update, %function
	.set lld_con_data_len_update, 0x00021539
	.global lld_con_data_tx
	.type lld_con_data_tx, %function
	.set lld_con_data_tx, 0x000215c1
	.global lld_con_enc_key_load
	.type lld_con_enc_key_load, %function
	.set lld_con_enc_key_load, 0x00021689
	.global lld_con_estab_ind_handler
	.type lld_con_estab_ind_handler, %function
	.set lld_con_estab_ind_handler, 0x000216fd
	.global lld_con_event_counter_get
	.type lld_con_event_counter_get, %function
	.set lld_con_event_counter_get, 0x00021725
	.global lld_con_init
	.type lld_con_init, %function
	.set lld_con_init, 0x00021cc1
	.global lld_con_llcp_tx
	.type lld_con_llcp_tx, %function
	.set lld_con_llcp_tx, 0x00021d09
	.global lld_con_offset_get
	.type lld_con_offset_get, %function
	.set lld_con_offset_get, 0x00021e7d
	.global lld_con_offset_upd_ind_handler
	.type lld_con_offset_upd_ind_handler, %function
	.set lld_con_offset_upd_ind_handler, 0x00021eb1
	.global lld_con_param_upd_cfm_handler
	.type lld_con_param_upd_cfm_handler, %function
	.set lld_con_param_upd_cfm_handler, 0x00021eed
	.global lld_con_param_update
	.type lld_con_param_update, %function
	.set lld_con_param_update, 0x00021f5d
	.global lld_con_peer_sca_set
	.type lld_con_peer_sca_set, %function
	.set lld_con_peer_sca_set, 0x00021fd1
	.global lld_con_phys_update
	.type lld_con_phys_update, %function
	.set lld_con_phys_update, 0x00021ff9
	.global lld_con_pref_slave_evt_dur_set
	.type lld_con_pref_slave_evt_dur_set, %function
	.set lld_con_pref_slave_evt_dur_set, 0x00022059
	.global lld_con_pref_slave_latency_set
	.type lld_con_pref_slave_latency_set, %function
	.set lld_con_pref_slave_latency_set, 0x000220c1
	.global lld_con_rssi_get
	.type lld_con_rssi_get, %function
	.set lld_con_rssi_get, 0x000220e9
	.global lld_con_rx_enc
	.type lld_con_rx_enc, %function
	.set lld_con_rx_enc, 0x00022409
	.global lld_con_start
	.type lld_con_start, %function
	.set lld_con_start, 0x00022855
	.global lld_con_stop
	.type lld_con_stop, %function
	.set lld_con_stop, 0x00022c31
	.global lld_con_sync_info_get
	.type lld_con_sync_info_get, %function
	.set lld_con_sync_info_get, 0x00022c85
	.global lld_con_time_get
	.type lld_con_time_get, %function
	.set lld_con_time_get, 0x00022cd9
	.global lld_con_tx_enc
	.type lld_con_tx_enc, %function
	.set lld_con_tx_enc, 0x00022d11
	.global lld_con_tx_len_update_for_intv
	.type lld_con_tx_len_update_for_intv, %function
	.set lld_con_tx_len_update_for_intv, 0x00022db1
	.global lld_con_tx_len_update_for_rate
	.type lld_con_tx_len_update_for_rate, %function
	.set lld_con_tx_len_update_for_rate, 0x00022ded
	.global lld_disc_ind_handler
	.type lld_disc_ind_handler, %function
	.set lld_disc_ind_handler, 0x0002336d
	.global lld_init
	.type lld_init, %function
	.set lld_init, 0x000233ad
	.global lld_init_connect_req_pack
	.type lld_init_connect_req_pack, %function
	.set lld_init_connect_req_pack, 0x000234f5
	.global lld_init_end_ind_handler
	.type lld_init_end_ind_handler, %function
	.set lld_init_end_ind_handler, 0x0002360d
	.global lld_init_init
	.type lld_init_init, %function
	.set lld_init_init, 0x00023bf9
	.global lld_init_rand_addr_update
	.type lld_init_rand_addr_update, %function
	.set lld_init_rand_addr_update, 0x00024169
	.global lld_init_start
	.type lld_init_start, %function
	.set lld_init_start, 0x0002437d
	.global lld_init_stop
	.type lld_init_stop, %function
	.set lld_init_stop, 0x00024a19
	.global lld_llcp_rx_ind_handler
	.type lld_llcp_rx_ind_handler, %function
	.set lld_llcp_rx_ind_handler, 0x00024af1
	.global lld_llcp_tx_cfm_handler
	.type lld_llcp_tx_cfm_handler, %function
	.set lld_llcp_tx_cfm_handler, 0x00024c4d
	.global lld_local_active_clk_acc_get
	.type lld_local_active_clk_acc_get, %function
	.set lld_local_active_clk_acc_get, 0x00024c91
	.global lld_local_sca_get
	.type lld_local_sca_get, %function
	.set lld_local_sca_get, 0x00024cad
	.global lld_per_adv_ch_map_update
	.type lld_per_adv_ch_map_update, %function
	.set lld_per_adv_ch_map_update, 0x00024cb9
	.global lld_per_adv_data_update
	.type lld_per_adv_data_update, %function
	.set lld_per_adv_data_update, 0x00024ec1
	.global lld_per_adv_end_ind_handler
	.type lld_per_adv_end_ind_handler, %function
	.set lld_per_adv_end_ind_handler, 0x00024f3d
	.global lld_per_adv_info_get
	.type lld_per_adv_info_get, %function
	.set lld_per_adv_info_get, 0x000256cd
	.global lld_per_adv_init
	.type lld_per_adv_init, %function
	.set lld_per_adv_init, 0x00025755
	.global lld_per_adv_init_info_get
	.type lld_per_adv_init_info_get, %function
	.set lld_per_adv_init_info_get, 0x00025795
	.global lld_per_adv_list_add
	.type lld_per_adv_list_add, %function
	.set lld_per_adv_list_add, 0x000257e9
	.global lld_per_adv_list_rem
	.type lld_per_adv_list_rem, %function
	.set lld_per_adv_list_rem, 0x00025885
	.global lld_per_adv_rep_ind_handler
	.type lld_per_adv_rep_ind_handler, %function
	.set lld_per_adv_rep_ind_handler, 0x000258fd
	.global lld_per_adv_rx_end_ind_handler
	.type lld_per_adv_rx_end_ind_handler, %function
	.set lld_per_adv_rx_end_ind_handler, 0x00025c6d
	.global lld_per_adv_start
	.type lld_per_adv_start, %function
	.set lld_per_adv_start, 0x00025e81
	.global lld_per_adv_stop
	.type lld_per_adv_stop, %function
	.set lld_per_adv_stop, 0x000260b1
	.global lld_per_adv_sync_info_get
	.type lld_per_adv_sync_info_get, %function
	.set lld_per_adv_sync_info_get, 0x00026141
	.global lld_phy_upd_cfm_handler
	.type lld_phy_upd_cfm_handler, %function
	.set lld_phy_upd_cfm_handler, 0x00026195
	.global lld_ral_search
	.type lld_ral_search, %function
	.set lld_ral_search, 0x000261cd
	.global lld_read_clock
	.type lld_read_clock, %function
	.set lld_read_clock, 0x00026229
	.global lld_res_list_add
	.type lld_res_list_add, %function
	.set lld_res_list_add, 0x00026239
	.global lld_res_list_clear
	.type lld_res_list_clear, %function
	.set lld_res_list_clear, 0x000262e5
	.global lld_res_list_local_rpa_get
	.type lld_res_list_local_rpa_get, %function
	.set lld_res_list_local_rpa_get, 0x00026305
	.global lld_res_list_peer_rpa_get
	.type lld_res_list_peer_rpa_get, %function
	.set lld_res_list_peer_rpa_get, 0x00026339
	.global lld_res_list_priv_mode_update
	.type lld_res_list_priv_mode_update, %function
	.set lld_res_list_priv_mode_update, 0x00026371
	.global lld_res_list_rem
	.type lld_res_list_rem, %function
	.set lld_res_list_rem, 0x00026395
	.global lld_rpa_renew
	.type lld_rpa_renew, %function
	.set lld_rpa_renew, 0x000263ad
	.global lld_rxdesc_buf_ready
	.type lld_rxdesc_buf_ready, %function
	.set lld_rxdesc_buf_ready, 0x00026505
	.global lld_rxdesc_check
	.type lld_rxdesc_check, %function
	.set lld_rxdesc_check, 0x00026545
	.global lld_rxdesc_free
	.type lld_rxdesc_free, %function
	.set lld_rxdesc_free, 0x00026571
	.global lld_scan_create_sync
	.type lld_scan_create_sync, %function
	.set lld_scan_create_sync, 0x000268cd
	.global lld_scan_create_sync_cancel
	.type lld_scan_create_sync_cancel, %function
	.set lld_scan_create_sync_cancel, 0x00026915
	.global lld_scan_end_ind_handler
	.type lld_scan_end_ind_handler, %function
	.set lld_scan_end_ind_handler, 0x00026a49
	.global lld_scan_init
	.type lld_scan_init, %function
	.set lld_scan_init, 0x00026f39
	.global lld_scan_params_update
	.type lld_scan_params_update, %function
	.set lld_scan_params_update, 0x00026f89
	.global lld_scan_rand_addr_update
	.type lld_scan_rand_addr_update, %function
	.set lld_scan_rand_addr_update, 0x00027b39
	.global lld_scan_req_ind_handler
	.type lld_scan_req_ind_handler, %function
	.set lld_scan_req_ind_handler, 0x00027b61
	.global lld_scan_restart
	.type lld_scan_restart, %function
	.set lld_scan_restart, 0x00027bad
	.global lld_scan_start
	.type lld_scan_start, %function
	.set lld_scan_start, 0x00027c11
	.global lld_scan_stop
	.type lld_scan_stop, %function
	.set lld_scan_stop, 0x000280e9
	.global lld_sync_ch_map_update
	.type lld_sync_ch_map_update, %function
	.set lld_sync_ch_map_update, 0x00028171
	.global lld_sync_info_get
	.type lld_sync_info_get, %function
	.set lld_sync_info_get, 0x000283ad
	.global lld_sync_init
	.type lld_sync_init, %function
	.set lld_sync_init, 0x00028435
	.global lld_sync_start
	.type lld_sync_start, %function
	.set lld_sync_start, 0x00028b5d
	.global lld_sync_start_req_handler
	.type lld_sync_start_req_handler, %function
	.set lld_sync_start_req_handler, 0x00028d21
	.global lld_sync_stop
	.type lld_sync_stop, %function
	.set lld_sync_stop, 0x00028df5
	.global lld_test_end_ind_handler
	.type lld_test_end_ind_handler, %function
	.set lld_test_end_ind_handler, 0x00028ead
	.global lld_test_init
	.type lld_test_init, %function
	.set lld_test_init, 0x00029015
	.global lld_test_start
	.type lld_test_start, %function
	.set lld_test_start, 0x00029035
	.global lld_test_stop
	.type lld_test_stop, %function
	.set lld_test_stop, 0x000294d5
	.global lld_white_list_add
	.type lld_white_list_add, %function
	.set lld_white_list_add, 0x00029565
	.global lld_white_list_rem
	.type lld_white_list_rem, %function
	.set lld_white_list_rem, 0x000295ed
	.global llhwc_phy_init_chip
	.type llhwc_phy_init_chip, %function
	.set llhwc_phy_init_chip, 0x00029651
	.global llhwc_phy_prerx
	.type llhwc_phy_prerx, %function
	.set llhwc_phy_prerx, 0x00029695
	.global llm_activity_free_get
	.type llm_activity_free_get, %function
	.set llm_activity_free_get, 0x000296a5
	.global llm_adv_act_id_get
	.type llm_adv_act_id_get, %function
	.set llm_adv_act_id_get, 0x000296f9
	.global llm_adv_hdl_to_id
	.type llm_adv_hdl_to_id, %function
	.set llm_adv_hdl_to_id, 0x00029869
	.global llm_adv_set_id_get
	.type llm_adv_set_id_get, %function
	.set llm_adv_set_id_get, 0x00029949
	.global llm_ch_map_update
	.type llm_ch_map_update, %function
	.set llm_ch_map_update, 0x00029aa5
	.global llm_ch_map_update_ind_handler
	.type llm_ch_map_update_ind_handler, %function
	.set llm_ch_map_update_ind_handler, 0x00029be9
	.global llm_clk_acc_set
	.type llm_clk_acc_set, %function
	.set llm_clk_acc_set, 0x00029c59
	.global llm_cmd_cmp_send
	.type llm_cmd_cmp_send, %function
	.set llm_cmd_cmp_send, 0x00029c89
	.global llm_cmd_stat_send
	.type llm_cmd_stat_send, %function
	.set llm_cmd_stat_send, 0x00029ca5
	.global llm_dev_list_empty_entry
	.type llm_dev_list_empty_entry, %function
	.set llm_dev_list_empty_entry, 0x00029cc1
	.global llm_dev_list_search
	.type llm_dev_list_search, %function
	.set llm_dev_list_search, 0x00029ce5
	.global llm_hci_command_handler
	.type llm_hci_command_handler, %function
	.set llm_hci_command_handler, 0x00029d91
	.global llm_init
	.type llm_init, %function
	.set llm_init, 0x00029dc5
	.global llm_is_dev_connected
	.type llm_is_dev_connected, %function
	.set llm_is_dev_connected, 0x00029f49
	.global llm_is_dev_synced
	.type llm_is_dev_synced, %function
	.set llm_is_dev_synced, 0x00029f99
	.global llm_le_evt_mask_check
	.type llm_le_evt_mask_check, %function
	.set llm_le_evt_mask_check, 0x0002a089
	.global llm_le_features_get
	.type llm_le_features_get, %function
	.set llm_le_features_get, 0x0002a0ad
	.global llm_link_disc
	.type llm_link_disc, %function
	.set llm_link_disc, 0x0002a0b5
	.global llm_master_ch_map_get
	.type llm_master_ch_map_get, %function
	.set llm_master_ch_map_get, 0x0002a159
	.global llm_per_adv_sync
	.type llm_per_adv_sync, %function
	.set llm_per_adv_sync, 0x0002a1e5
	.global llm_plan_elt_get
	.type llm_plan_elt_get, %function
	.set llm_plan_elt_get, 0x0002a2c1
	.global llm_ral_get
	.type llm_ral_get, %function
	.set llm_ral_get, 0x0002a325
	.global llm_ral_is_empty
	.type llm_ral_is_empty, %function
	.set llm_ral_is_empty, 0x0002a32d
	.global llm_ral_search
	.type llm_ral_search, %function
	.set llm_ral_search, 0x0002a355
	.global llm_rx_path_comp_get
	.type llm_rx_path_comp_get, %function
	.set llm_rx_path_comp_get, 0x0002a3ad
	.global llm_scan_period_to_handler
	.type llm_scan_period_to_handler, %function
	.set llm_scan_period_to_handler, 0x0002a3b9
	.global llm_scan_sync_info_get
	.type llm_scan_sync_info_get, %function
	.set llm_scan_sync_info_get, 0x0002a4bd
	.global llm_tx_path_comp_get
	.type llm_tx_path_comp_get, %function
	.set llm_tx_path_comp_get, 0x0002a515
	.global notEqual256
	.type notEqual256, %function
	.set notEqual256, 0x0002a569
	.global phy_upd_proc_start
	.type phy_upd_proc_start, %function
	.set phy_upd_proc_start, 0x0002a601
	.global platform_chose
	.type platform_chose, %function
	.set platform_chose, 0x0002a655
	.global platform_reset
	.type platform_reset, %function
	.set platform_reset, 0x0002a6f5
	.global pretxrx_chip
	.type pretxrx_chip, %function
	.set pretxrx_chip, 0x0002a725
	.global rf_init
	.type rf_init, %function
	.set rf_init, 0x0002aa7d
	.global rf_rssi_convert
	.type rf_rssi_convert, %function
	.set rf_rssi_convert, 0x0002ab89
	.global rom_ble_wake_exti21_cfg
	.type rom_ble_wake_exti21_cfg, %function
	.set rom_ble_wake_exti21_cfg, 0x0002ac45
	.global rom_ble_wake_exti21_isr
	.type rom_ble_wake_exti21_isr, %function
	.set rom_ble_wake_exti21_isr, 0x0002ac7d
	.global rom_calib_clk_init
	.type rom_calib_clk_init, %function
	.set rom_calib_clk_init, 0x0002ac99
	.global rom_calib_hsi_clk
	.type rom_calib_hsi_clk, %function
	.set rom_calib_hsi_clk, 0x0002acb5
	.global rom_calib_lsi_clk
	.type rom_calib_lsi_clk, %function
	.set rom_calib_lsi_clk, 0x0002ad4d
	.global rom_delay_n_10us
	.type rom_delay_n_10us, %function
	.set rom_delay_n_10us, 0x0002ae0d
	.global rom_delay_n_ms
	.type rom_delay_n_ms, %function
	.set rom_delay_n_ms, 0x0002ae25
	.global rwble_error_crypt_isr
	.type rwble_error_crypt_isr, %function
	.set rwble_error_crypt_isr, 0x0002b421
	.global rwble_hl_init
	.type rwble_hl_init, %function
	.set rwble_hl_init, 0x0002b471
	.global rwble_init
	.type rwble_init, %function
	.set rwble_init, 0x0002b48d
	.global rwble_int_init
	.type rwble_int_init, %function
	.set rwble_int_init, 0x0002b4b1
	.global rwip_active_check
	.type rwip_active_check, %function
	.set rwip_active_check, 0x0002b575
	.global rwip_aes_encrypt
	.type rwip_aes_encrypt, %function
	.set rwip_aes_encrypt, 0x0002b589
	.global rwip_clockn_isr
	.type rwip_clockn_isr, %function
	.set rwip_clockn_isr, 0x0002b649
	.global rwip_driver_init
	.type rwip_driver_init, %function
	.set rwip_driver_init, 0x0002b695
	.global rwip_fifo_isr
	.type rwip_fifo_isr, %function
	.set rwip_fifo_isr, 0x0002b8b5
	.global rwip_finetgt_isr
	.type rwip_finetgt_isr, %function
	.set rwip_finetgt_isr, 0x0002b8d1
	.global rwip_init
	.type rwip_init, %function
	.set rwip_init, 0x0002b8fd
	.global rwip_prevent_sleep_clear
	.type rwip_prevent_sleep_clear, %function
	.set rwip_prevent_sleep_clear, 0x0002ba45
	.global rwip_prevent_sleep_set
	.type rwip_prevent_sleep_set, %function
	.set rwip_prevent_sleep_set, 0x0002ba61
	.global rwip_reset
	.type rwip_reset, %function
	.set rwip_reset, 0x0002ba7d
	.global rwip_schedule
	.type rwip_schedule, %function
	.set rwip_schedule, 0x0002baf1
	.global rwip_slp_isr
	.type rwip_slp_isr, %function
	.set rwip_slp_isr, 0x0002bc39
	.global rwip_sw_int_req
	.type rwip_sw_int_req, %function
	.set rwip_sw_int_req, 0x0002bc6d
	.global rwip_sw_isr
	.type rwip_sw_isr, %function
	.set rwip_sw_isr, 0x0002bc8d
	.global rwip_time_get
	.type rwip_time_get, %function
	.set rwip_time_get, 0x0002bcad
	.global rwip_timer_1ms_set
	.type rwip_timer_1ms_set, %function
	.set rwip_timer_1ms_set, 0x0002bced
	.global rwip_timer_hs_set
	.type rwip_timer_hs_set, %function
	.set rwip_timer_hs_set, 0x0002bd41
	.global rwip_timer_hus_set
	.type rwip_timer_hus_set, %function
	.set rwip_timer_hus_set, 0x0002bd71
	.global rwip_timestamptgt1_isr
	.type rwip_timestamptgt1_isr, %function
	.set rwip_timestamptgt1_isr, 0x0002bdb1
	.global rwip_timestamptgt2_isr
	.type rwip_timestamptgt2_isr, %function
	.set rwip_timestamptgt2_isr, 0x0002bddd
	.global rwip_wakeup
	.type rwip_wakeup, %function
	.set rwip_wakeup, 0x0002be0d
	.global rwip_wakeup_end
	.type rwip_wakeup_end, %function
	.set rwip_wakeup_end, 0x0002bed9
	.global sch_alarm_init
	.type sch_alarm_init, %function
	.set sch_alarm_init, 0x0002bf81
	.global sch_alarm_set
	.type sch_alarm_set, %function
	.set sch_alarm_set, 0x0002c001
	.global sch_alarm_timer_isr
	.type sch_alarm_timer_isr, %function
	.set sch_alarm_timer_isr, 0x0002c095
	.global sch_arb_elt_cancel
	.type sch_arb_elt_cancel, %function
	.set sch_arb_elt_cancel, 0x0002c1c9
	.global sch_arb_event_start_isr
	.type sch_arb_event_start_isr, %function
	.set sch_arb_event_start_isr, 0x0002c2e9
	.global sch_arb_init
	.type sch_arb_init, %function
	.set sch_arb_init, 0x0002c3c5
	.global sch_arb_insert
	.type sch_arb_insert, %function
	.set sch_arb_insert, 0x0002c3f1
	.global sch_arb_remove
	.type sch_arb_remove, %function
	.set sch_arb_remove, 0x0002c681
	.global sch_arb_sw_isr
	.type sch_arb_sw_isr, %function
	.set sch_arb_sw_isr, 0x0002c6e5
	.global sch_plan_chk
	.type sch_plan_chk, %function
	.set sch_plan_chk, 0x0002c719
	.global sch_plan_init
	.type sch_plan_init, %function
	.set sch_plan_init, 0x0002c729
	.global sch_plan_rem
	.type sch_plan_rem, %function
	.set sch_plan_rem, 0x0002c9ed
	.global sch_plan_req
	.type sch_plan_req, %function
	.set sch_plan_req, 0x0002c9fd
	.global sch_plan_set
	.type sch_plan_set, %function
	.set sch_plan_set, 0x0002cac9
	.global sch_prog_end_isr
	.type sch_prog_end_isr, %function
	.set sch_prog_end_isr, 0x0002cb3d
	.global sch_prog_fifo_isr
	.type sch_prog_fifo_isr, %function
	.set sch_prog_fifo_isr, 0x0002cba9
	.global sch_prog_init
	.type sch_prog_init, %function
	.set sch_prog_init, 0x0002cc01
	.global sch_prog_push
	.type sch_prog_push, %function
	.set sch_prog_push, 0x0002cc41
	.global sch_prog_skip_isr
	.type sch_prog_skip_isr, %function
	.set sch_prog_skip_isr, 0x0002cd79
	.global sch_slice_bg_add
	.type sch_slice_bg_add, %function
	.set sch_slice_bg_add, 0x0002cded
	.global sch_slice_bg_remove
	.type sch_slice_bg_remove, %function
	.set sch_slice_bg_remove, 0x0002ce05
	.global sch_slice_compute
	.type sch_slice_compute, %function
	.set sch_slice_compute, 0x0002ce1d
	.global sch_slice_fg_add
	.type sch_slice_fg_add, %function
	.set sch_slice_fg_add, 0x0002cee9
	.global sch_slice_fg_remove
	.type sch_slice_fg_remove, %function
	.set sch_slice_fg_remove, 0x0002cf09
	.global sch_slice_init
	.type sch_slice_init, %function
	.set sch_slice_init, 0x0002cf39
	.global sch_slice_per_add
	.type sch_slice_per_add, %function
	.set sch_slice_per_add, 0x0002cf95
	.global sch_slice_per_remove
	.type sch_slice_per_remove, %function
	.set sch_slice_per_remove, 0x0002cfbd
	.global specialModP256
	.type specialModP256, %function
	.set specialModP256, 0x0002d045
	.global swd_enable
	.type swd_enable, %function
	.set swd_enable, 0x0002d13d
	.global swd_lock
	.type swd_lock, %function
	.set swd_lock, 0x0002d185
	.global one_bits
	.type one_bits, %object
	.set one_bits, 0x0002d2a4
	.global co_sca2ppm
	.type co_sca2ppm, %object
	.set co_sca2ppm, 0x0002d2b4
	.global co_null_bdaddr
	.type co_null_bdaddr, %object
	.set co_null_bdaddr, 0x0002d2c4
	.global co_default_bdaddr
	.type co_default_bdaddr, %object
	.set co_default_bdaddr, 0x0002d2ca
	.global co_null_key
	.type co_null_key, %object
	.set co_null_key, 0x0002d2d0
	.global co_rate_to_phy
	.type co_rate_to_phy, %object
	.set co_rate_to_phy, 0x0002d2e0
	.global co_phy_to_rate
	.type co_phy_to_rate, %object
	.set co_phy_to_rate, 0x0002d2e5
	.global co_phy_mask_to_value
	.type co_phy_mask_to_value, %object
	.set co_phy_mask_to_value, 0x0002d2e9
	.global co_phy_value_to_mask
	.type co_phy_value_to_mask, %object
	.set co_phy_value_to_mask, 0x0002d2ee
	.global co_rate_to_phy_mask
	.type co_rate_to_phy_mask, %object
	.set co_rate_to_phy_mask, 0x0002d2f2
	.global co_phy_mask_to_rate
	.type co_phy_mask_to_rate, %object
	.set co_phy_mask_to_rate, 0x0002d2f6
	.global rwip_priority
	.type rwip_priority, %object
	.set rwip_priority, 0x0002d2fb
	.global aes_cmac_zero
	.type aes_cmac_zero, %object
	.set aes_cmac_zero, 0x0002d311
	.global BasePoint_x_256
	.type BasePoint_x_256, %object
	.set BasePoint_x_256, 0x0002d338
	.global BasePoint_y_256
	.type BasePoint_y_256, %object
	.set BasePoint_y_256, 0x0002d358
	.global maxSecretKey_256
	.type maxSecretKey_256, %object
	.set maxSecretKey_256, 0x0002d378
	.global DebugE256PublicKey_x
	.type DebugE256PublicKey_x, %object
	.set DebugE256PublicKey_x, 0x0002d398
	.global DebugE256PublicKey_y
	.type DebugE256PublicKey_y, %object
	.set DebugE256PublicKey_y, 0x0002d3b8
	.global DebugE256SecretKey
	.type DebugE256SecretKey, %object
	.set DebugE256SecretKey, 0x0002d3d8
	.global coef_B
	.type coef_B, %object
	.set coef_B, 0x0002d3f8
	.global bigHexP256
	.type bigHexP256, %object
	.set bigHexP256, 0x0002d424
	.global veryBigHexP256
	.type veryBigHexP256, %object
	.set veryBigHexP256, 0x0002d450
	.global ecc_Jacobian_InfinityPoint256
	.type ecc_Jacobian_InfinityPoint256, %object
	.set ecc_Jacobian_InfinityPoint256, 0x0002d4a0
	.global ECC_4Win_Look_up_table
	.type ECC_4Win_Look_up_table, %object
	.set ECC_4Win_Look_up_table, 0x0002d524
	.global TASK_DESC_LLC
	.type TASK_DESC_LLC, %object
	.set TASK_DESC_LLC, 0x0002e004
	.global LLM_AA_CT2
	.type LLM_AA_CT2, %object
	.set LLM_AA_CT2, 0x0002e010
	.global LLM_AA_CT1
	.type LLM_AA_CT1, %object
	.set LLM_AA_CT1, 0x0002e012
	.global connect_req_dur_tab
	.type connect_req_dur_tab, %object
	.set connect_req_dur_tab, 0x0002e018
	.global byte_tx_time
	.type byte_tx_time, %object
	.set byte_tx_time, 0x0002e020
	.global fixed_tx_time
	.type fixed_tx_time, %object
	.set fixed_tx_time, 0x0002e028
	.global lld_init_max_aux_dur_tab
	.type lld_init_max_aux_dur_tab, %object
	.set lld_init_max_aux_dur_tab, 0x0002e030
	.global lld_scan_map_legacy_pdu_to_evt_type
	.type lld_scan_map_legacy_pdu_to_evt_type, %object
	.set lld_scan_map_legacy_pdu_to_evt_type, 0x0002e038
	.global lld_scan_max_aux_dur_tab
	.type lld_scan_max_aux_dur_tab, %object
	.set lld_scan_max_aux_dur_tab, 0x0002e040
	.global lld_sync_max_aux_dur_tab
	.type lld_sync_max_aux_dur_tab, %object
	.set lld_sync_max_aux_dur_tab, 0x0002e048
	.global TASK_DESC_LLM
	.type TASK_DESC_LLM, %object
	.set TASK_DESC_LLM, 0x0002e3d0
	.global hci_cmd_desc_tab_lk_ctrl
	.type hci_cmd_desc_tab_lk_ctrl, %object
	.set hci_cmd_desc_tab_lk_ctrl, 0x0002e3fc
	.global hci_cmd_desc_tab_ctrl_bb
	.type hci_cmd_desc_tab_ctrl_bb, %object
	.set hci_cmd_desc_tab_ctrl_bb, 0x0002e414
	.global hci_cmd_desc_tab_info_par
	.type hci_cmd_desc_tab_info_par, %object
	.set hci_cmd_desc_tab_info_par, 0x0002e480
	.global hci_cmd_desc_tab_stat_par
	.type hci_cmd_desc_tab_stat_par, %object
	.set hci_cmd_desc_tab_stat_par, 0x0002e4b0
	.global hci_cmd_desc_tab_le
	.type hci_cmd_desc_tab_le, %object
	.set hci_cmd_desc_tab_le, 0x0002e4bc
	.global hci_cmd_desc_tab_vs
	.type hci_cmd_desc_tab_vs, %object
	.set hci_cmd_desc_tab_vs, 0x0002e8c4
	.global hci_cmd_desc_root_tab
	.type hci_cmd_desc_root_tab, %object
	.set hci_cmd_desc_root_tab, 0x0002e900
	.global hci_evt_desc_tab
	.type hci_evt_desc_tab, %object
	.set hci_evt_desc_tab, 0x0002e930
	.global hci_evt_le_desc_tab
	.type hci_evt_le_desc_tab, %object
	.set hci_evt_le_desc_tab, 0x0002e978
	.global g_lsi_count_n_syscle
	.type g_lsi_count_n_syscle, %object
	.set g_lsi_count_n_syscle, 0x0002ea20
	.global g_lsi_1_syscle_cal_value
	.type g_lsi_1_syscle_cal_value, %object
	.set g_lsi_1_syscle_cal_value, 0x0002ea24
	.global init_addr
	.type init_addr, %object
	.set init_addr, 0x0002ed16
	.global init_data
	.type init_data, %object
	.set init_data, 0x0002ed8b
	.global init_delay
	.type init_delay, %object
	.set init_delay, 0x0002ee00
	.global attc_handlers
	.type attc_handlers, %object
	.set attc_handlers, 0x0002eeec
	.global atts_handlers
	.type atts_handlers, %object
	.set atts_handlers, 0x0002ef90
	.global TASK_DESC_GATTC
	.type TASK_DESC_GATTC, %object
	.set TASK_DESC_GATTC, 0x0002f100
	.global TASK_DESC_GATTM
	.type TASK_DESC_GATTM, %object
	.set TASK_DESC_GATTM, 0x0002f15c
	.global gapc_sig_handlers
	.type gapc_sig_handlers, %object
	.set gapc_sig_handlers, 0x0002f260
	.global TASK_DESC_GAPC
	.type TASK_DESC_GAPC, %object
	.set TASK_DESC_GAPC, 0x0002f408
	.global TASK_DESC_GAPM
	.type TASK_DESC_GAPM, %object
	.set TASK_DESC_GAPM, 0x0002f78c
	.global l2cc_sig_handlers
	.type l2cc_sig_handlers, %object
	.set l2cc_sig_handlers, 0x0002f8ac
	.global TASK_DESC_L2CC
	.type TASK_DESC_L2CC, %object
	.set TASK_DESC_L2CC, 0x0002f904
	.global rwip_rst_state
	.type rwip_rst_state, %object
	.set rwip_rst_state, 0x20000000
	.global ecc_env
	.type ecc_env, %object
	.set ecc_env, 0x20000004
	.global aa_gen
	.type aa_gen, %object
	.set aa_gen, 0x20000014
	.global lld_exp_sync_pos_tab
	.type lld_exp_sync_pos_tab, %object
	.set lld_exp_sync_pos_tab, 0x2000001c
	.global sch_slice_params
	.type sch_slice_params, %object
	.set sch_slice_params, 0x20000050
	.global hci_ext_host
	.type hci_ext_host, %object
	.set hci_ext_host, 0x20000058
	.global g_system_clk
	.type g_system_clk, %object
	.set g_system_clk, 0x20000064
	.global g_apb1_clk
	.type g_apb1_clk, %object
	.set g_apb1_clk, 0x20000068
	.global g_timeoutcnt
	.type g_timeoutcnt, %object
	.set g_timeoutcnt, 0x2000006c
	.global g_sleep_status_flag
	.type g_sleep_status_flag, %object
	.set g_sleep_status_flag, 0x20000070
	.global g_lsi_accuracy
	.type g_lsi_accuracy, %object
	.set g_lsi_accuracy, 0x20000074
	.global g_lsi_1_syscle_cnt_value
	.type g_lsi_1_syscle_cnt_value, %object
	.set g_lsi_1_syscle_cnt_value, 0x20000078
	.global g_delay_div_param
	.type g_delay_div_param, %object
	.set g_delay_div_param, 0x2000007c
	.global g_delay_us_div_param
	.type g_delay_us_div_param, %object
	.set g_delay_us_div_param, 0x2000007d
	.global g_version_sw_major
	.type g_version_sw_major, %object
	.set g_version_sw_major, 0x2000007e
	.global g_version_sw_minor
	.type g_version_sw_minor, %object
	.set g_version_sw_minor, 0x2000007f
	.global g_version_sw_build
	.type g_version_sw_build, %object
	.set g_version_sw_build, 0x20000080
	.global g_company_id
	.type g_company_id, %object
	.set g_company_id, 0x20000082
	.global g_ltk_req_neg_reply
	.type g_ltk_req_neg_reply, %object
	.set g_ltk_req_neg_reply, 0x20000084
	.global g_rc32k_trim
	.type g_rc32k_trim, %object
	.set g_rc32k_trim, 0x20000086
	.global g_adv_intv
	.type g_adv_intv, %object
	.set g_adv_intv, 0x20000088
	.global rwip_prog_delay
	.type rwip_prog_delay, %object
	.set rwip_prog_delay, 0x2000008a
	.global g_rssi_interf_thr
	.type g_rssi_interf_thr, %object
	.set g_rssi_interf_thr, 0x2000008b
	.global prf_func
	.type prf_func, %object
	.set prf_func, 0x2000008c
	.global SVC_IRQHandler_ptr
	.type SVC_IRQHandler_ptr, %object
	.set SVC_IRQHandler_ptr, 0x200000a4
	.global NMI_IRQHandler_ptr
	.type NMI_IRQHandler_ptr, %object
	.set NMI_IRQHandler_ptr, 0x200000a8
	.global HardFault_Handler_ptr
	.type HardFault_Handler_ptr, %object
	.set HardFault_Handler_ptr, 0x200000ac
	.global SysTick_IRQHandler_ptr
	.type SysTick_IRQHandler_ptr, %object
	.set SysTick_IRQHandler_ptr, 0x200000b0
	.global PendSV_IRQHandler_ptr
	.type PendSV_IRQHandler_ptr, %object
	.set PendSV_IRQHandler_ptr, 0x200000b4
	.global sch_arb_event_start_isr_ptr
	.type sch_arb_event_start_isr_ptr, %object
	.set sch_arb_event_start_isr_ptr, 0x200000b8
	.global sch_arb_insert_ptr
	.type sch_arb_insert_ptr, %object
	.set sch_arb_insert_ptr, 0x200000bc
	.global sch_arb_elt_cancel_ptr
	.type sch_arb_elt_cancel_ptr, %object
	.set sch_arb_elt_cancel_ptr, 0x200000c0
	.global hci_le_set_rand_addr_cmd_handler_ptr
	.type hci_le_set_rand_addr_cmd_handler_ptr, %object
	.set hci_le_set_rand_addr_cmd_handler_ptr, 0x200000c4
	.global hci_le_tx_test_v1_cmd_handler_ptr
	.type hci_le_tx_test_v1_cmd_handler_ptr, %object
	.set hci_le_tx_test_v1_cmd_handler_ptr, 0x200000c8
	.global rf_init_ptr
	.type rf_init_ptr, %object
	.set rf_init_ptr, 0x200000cc
	.global llhwc_phy_prerx_ptr
	.type llhwc_phy_prerx_ptr, %object
	.set llhwc_phy_prerx_ptr, 0x200000d0
	.global llhwc_phy_initialization_ptr
	.type llhwc_phy_initialization_ptr, %object
	.set llhwc_phy_initialization_ptr, 0x200000d4
	.global chn_table_init_ptr
	.type chn_table_init_ptr, %object
	.set chn_table_init_ptr, 0x200000d8
	.global platform_reset_callback
	.type platform_reset_callback, %object
	.set platform_reset_callback, 0x200000dc
	.global g_co_default_bdaddr
	.type g_co_default_bdaddr, %object
	.set g_co_default_bdaddr, 0x200000e0
	.global BLE_ADV_FRAG_NB_TX
	.type BLE_ADV_FRAG_NB_TX, %object
	.set BLE_ADV_FRAG_NB_TX, 0x200000e6
	.global BLE_ADV_FRAG_SIZE_TX
	.type BLE_ADV_FRAG_SIZE_TX, %object
	.set BLE_ADV_FRAG_SIZE_TX, 0x200000e7
	.global BLE_NORMAL_WIN_SIZE
	.type BLE_NORMAL_WIN_SIZE, %object
	.set BLE_NORMAL_WIN_SIZE, 0x200000e8
	.global BLE_RX_DESC_NB
	.type BLE_RX_DESC_NB, %object
	.set BLE_RX_DESC_NB, 0x200000e9
	.global RWIP_MINIMUM_SLEEP_TIME
	.type RWIP_MINIMUM_SLEEP_TIME, %object
	.set RWIP_MINIMUM_SLEEP_TIME, 0x200000ea
	.global BLE_NB_TX_DESC_PER_CON
	.type BLE_NB_TX_DESC_PER_CON, %object
	.set BLE_NB_TX_DESC_PER_CON, 0x200000eb
	.global SLEEP_PROG_MARGIN
	.type SLEEP_PROG_MARGIN, %object
	.set SLEEP_PROG_MARGIN, 0x200000ec
	.global RW_BLE_PTI_PRIO_AUTO
	.type RW_BLE_PTI_PRIO_AUTO, %object
	.set RW_BLE_PTI_PRIO_AUTO, 0x200000ee
	.global llc_start_max_rx_octets
	.type llc_start_max_rx_octets, %object
	.set llc_start_max_rx_octets, 0x200000ef
	.global llc_start_max_rx_time
	.type llc_start_max_rx_time, %object
	.set llc_start_max_rx_time, 0x200000f0
	.global llm_local_le_feats
	.type llm_local_le_feats, %object
	.set llm_local_le_feats, 0x200000f2
	.global g_rwip_heap_env
	.type g_rwip_heap_env, %object
	.set g_rwip_heap_env, 0x200000fc
	.global g_rwip_heap_env_size
	.type g_rwip_heap_env_size, %object
	.set g_rwip_heap_env_size, 0x20000100
	.global g_rwip_heap_db_size
	.type g_rwip_heap_db_size, %object
	.set g_rwip_heap_db_size, 0x20000102
	.global g_rwip_heap_msg_size
	.type g_rwip_heap_msg_size, %object
	.set g_rwip_heap_msg_size, 0x20000104
	.global g_rwip_heap_non_ret_size
	.type g_rwip_heap_non_ret_size, %object
	.set g_rwip_heap_non_ret_size, 0x20000106
	.global g_hci_itf_ptr
	.type g_hci_itf_ptr, %object
	.set g_hci_itf_ptr, 0x20000108
	.global g_branch
	.type g_branch, %object
	.set g_branch, 0x2000010c
	.global g_flash_info
	.type g_flash_info, %object
	.set g_flash_info, 0x20000110
	.global g_lld_con_frm_cbk_ptr
	.type g_lld_con_frm_cbk_ptr, %object
	.set g_lld_con_frm_cbk_ptr, 0x20000114
	.global g_lld_con_sched_ptr
	.type g_lld_con_sched_ptr, %object
	.set g_lld_con_sched_ptr, 0x20000118
	.global g_lld_con_pref_slave_evt_dur_set_ptr
	.type g_lld_con_pref_slave_evt_dur_set_ptr, %object
	.set g_lld_con_pref_slave_evt_dur_set_ptr, 0x2000011c
	.global g_lld_con_tx_prog_ptr
	.type g_lld_con_tx_prog_ptr, %object
	.set g_lld_con_tx_prog_ptr, 0x20000120
	.global g_lld_con_start_ptr
	.type g_lld_con_start_ptr, %object
	.set g_lld_con_start_ptr, 0x20000124
	.global g_lld_con_llcp_tx_ptr
	.type g_lld_con_llcp_tx_ptr, %object
	.set g_lld_con_llcp_tx_ptr, 0x20000128
	.global g_lld_con_data_flow_set_ptr
	.type g_lld_con_data_flow_set_ptr, %object
	.set g_lld_con_data_flow_set_ptr, 0x2000012c
	.global g_lld_con_data_len_update_ptr
	.type g_lld_con_data_len_update_ptr, %object
	.set g_lld_con_data_len_update_ptr, 0x20000130
	.global g_llm_adv_end_ind_ptr
	.type g_llm_adv_end_ind_ptr, %object
	.set g_llm_adv_end_ind_ptr, 0x20000134
	.global rf_rssi_convert_ptr
	.type rf_rssi_convert_ptr, %object
	.set rf_rssi_convert_ptr, 0x20000140
	.global set_cfg
	.type set_cfg, %object
	.set set_cfg, 0x20000144
	.global gattc_state
	.type gattc_state, %object
	.set gattc_state, 0x2000014c
	.global gattm_state
	.type gattm_state, %object
	.set gattm_state, 0x20000153
	.global gapc_state
	.type gapc_state, %object
	.set gapc_state, 0x20000154
	.global gapm_state
	.type gapm_state, %object
	.set gapm_state, 0x2000015b
	.global l2cc_state
	.type l2cc_state, %object
	.set l2cc_state, 0x2000015c
	.global ke_env
	.type ke_env, %object
	.set ke_env, 0x20000168
	.global rwip_rf
	.type rwip_rf, %object
	.set rwip_rf, 0x20000210
	.global rwip_param
	.type rwip_param, %object
	.set rwip_param, 0x20000244
	.global rwip_env
	.type rwip_env, %object
	.set rwip_env, 0x20000250
	.global aes_env
	.type aes_env, %object
	.set aes_env, 0x20000274
	.global llc_env
	.type llc_env, %object
	.set llc_env, 0x200002a8
	.global lld_env
	.type lld_env, %object
	.set lld_env, 0x200002c8
	.global lld_sync_env
	.type lld_sync_env, %object
	.set lld_sync_env, 0x2000042c
	.global llm_env
	.type llm_env, %object
	.set llm_env, 0x2000044c
	.global hci_env
	.type hci_env, %object
	.set hci_env, 0x20000b24
	.global rom_env
	.type rom_env, %object
	.set rom_env, 0x20000b7c
	.global gattc_env
	.type gattc_env, %object
	.set gattc_env, 0x20000ce4
	.global gattm_env
	.type gattm_env, %object
	.set gattm_env, 0x20000d00
	.global gapc_env
	.type gapc_env, %object
	.set gapc_env, 0x20000d38
	.global gapm_env
	.type gapm_env, %object
	.set gapm_env, 0x20000d54
	.global l2cc_env
	.type l2cc_env, %object
	.set l2cc_env, 0x20000dbc
	.global l2cm_env
	.type l2cm_env, %object
	.set l2cm_env, 0x20000dd8

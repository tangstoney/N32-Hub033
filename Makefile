# rd91_hub033 - N32WB033 单片 bring-up 固件（GCC，无 Keil）
#
# 覆盖：B01 点灯 / B02 串口 / B04 按键 / B06 雷达 / B07 语音 / B08 段码屏
# IMU(QMI8A01z) 未到货：src/imu.c 只有探测桩，到货后填 I2C1 读写即可。
# BLE(B03/B13) 用 _sdk/.../master_slave_relay/GCC 单独验证，合并是下一步。
#
# 编译： make -j8
# 发布： make release=y -j8
# 清理： make clean

TARGET    = rd91_hub033
BUILD_DIR = build

SDK_ROOT ?= D:/Tangshi/Project/N32Demo/_sdk/NSING.N32WB033_Library.1.0.1

ifeq ($(release), y)
OPT = -Os
else
OPT = -O1
endif

PREFIX = arm-none-eabi-
CC = $(PREFIX)gcc
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size

CPU = -mcpu=cortex-m0plus -mthumb
MCU = $(CPU) -mfloat-abi=soft

DEFS  = -DN32WB033
DEFS += -DUSE_STDPERIPH_DRIVER
DEFS += -DUSE_BLE_ROM_API

FW  = $(SDK_ROOT)/firmware
BSP = $(SDK_ROOT)/projects/n32wb033_EVAL/bsp
BLE_LIB = $(SDK_ROOT)/middlewares/Nationstech/ble_library

C_SOURCES  = src/main.c
C_SOURCES += src/app/alarm.c
C_SOURCES += src/services/tick.c
C_SOURCES += src/services/console.c
C_SOURCES += src/services/retarget.c
C_SOURCES += src/drivers/board.c
C_SOURCES += src/drivers/radar.c
C_SOURCES += src/drivers/voice.c
C_SOURCES += src/drivers/seg_lcd.c
C_SOURCES += src/drivers/imu.c
C_SOURCES += src/ble/ble_app.c
C_SOURCES += src/ble/hub/hub_app.c
C_SOURCES += $(BSP)/src/log.c
# 注意：不编译 bsp/src/delay.c —— 它把 SysTick 当一次性延时用（关中断），
# 与 src/tick.c 的 1ms 节拍冲突。延时统一用 tick_delay_ms()/delay_us()。
C_SOURCES += $(FW)/CMSIS/device/system_n32wb033.c
C_SOURCES += $(FW)/n32wb033_std_periph_driver/src/misc.c
C_SOURCES += $(FW)/n32wb033_std_periph_driver/src/n32wb033_exti.c
C_SOURCES += $(FW)/n32wb033_std_periph_driver/src/n32wb033_gpio.c
C_SOURCES += $(FW)/n32wb033_std_periph_driver/src/n32wb033_rcc.c
C_SOURCES += $(FW)/n32wb033_std_periph_driver/src/n32wb033_usart.c
C_SOURCES += $(FW)/n32wb033_std_periph_driver/src/n32wb033_i2c.c

# BLE 协议栈（ROM API）——M1：先接进来编译，初始化和服务在 src/ble/ 里逐步加
C_SOURCES += $(BLE_LIB)/ns_ble_stack/stack_common/rwip_driver.c
C_SOURCES += $(BLE_LIB)/ns_ble_stack/ip/ble/hl/src/att/lib_att.c
C_SOURCES += $(BLE_LIB)/ns_ble_profile/prf.c
C_SOURCES += $(BLE_LIB)/ns_ble_profile/prf_utils.c
C_SOURCES += $(BLE_LIB)/ns_ble_profile/prf_utils_128.c
C_SOURCES += $(BLE_LIB)/ns_library/sec/ns_sec.c
C_SOURCES += $(BLE_LIB)/ns_library/sleep/ns_sleep.c
C_SOURCES += $(BLE_LIB)/ns_library/timer/ns_timer.c
C_SOURCES += $(BLE_LIB)/ns_library/ble/ns_ble.c
C_SOURCES += $(BLE_LIB)/ns_library/ble/ns_ble_task.c

# 16-bit raw data transfer server（N32-Hub 的 0xFFE0 服务）
C_SOURCES += $(BLE_LIB)/ns_ble_profile/rdts/rdtss/src/rdtss_16bit.c
C_SOURCES += $(BLE_LIB)/ns_ble_profile/rdts/rdtss/src/rdtss_16bit_task.c
C_SOURCES += $(BLE_LIB)/ns_ble_profile/rdts/rdts_common.c

ASM_SOURCES = $(FW)/CMSIS/device/startup/startup_n32wb033_gcc.s
ASM_SOURCES += src/ble/rom_symbols.s

C_INCLUDES  = -Isrc
C_INCLUDES += -Isrc/app
C_INCLUDES += -Isrc/services
C_INCLUDES += -Isrc/drivers
C_INCLUDES += -I$(BSP)/inc
C_INCLUDES += -I$(FW)/CMSIS/core
C_INCLUDES += -I$(FW)/CMSIS/device
C_INCLUDES += -I$(FW)/n32wb033_std_periph_driver/inc
C_INCLUDES += -Isrc/ble
C_INCLUDES += -Isrc/ble/hub
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/dis/diss/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/bas/bass/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/hogp
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/hogp/hogpd/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/hogp/hogpd/src
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/hrp
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/hrp/hrps/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/hrp/hrps/src
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/rdts
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/rdts/rdtss/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_profile/rdts/rdtsc/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ahi/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ble/hl/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ble/hl/inc
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ble/hl/src/gap
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ble/hl/src/gatt
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ble/hl/src/l2c
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ble/ll/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ble/ll/src
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ble/ll/src/llc
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ble/ll/src/lld
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/ble/ll/src/llm
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/em/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/hci/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/ip/sch/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/modules/aes/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/modules/common/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/modules/common/src
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/modules/dbg/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/modules/ecc_p256/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/modules/h4tl/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/modules/ke/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/modules/rwip/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/rfinit/api
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/arch
C_INCLUDES += -I$(BLE_LIB)/ns_ble_stack/stack_common
C_INCLUDES += -I$(BLE_LIB)/ns_library/adv
C_INCLUDES += -I$(BLE_LIB)/ns_library/timer
C_INCLUDES += -I$(BLE_LIB)/ns_library/log
C_INCLUDES += -I$(BLE_LIB)/ns_library/delay
C_INCLUDES += -I$(BLE_LIB)/ns_library/sleep
C_INCLUDES += -I$(BLE_LIB)/ns_library/sec
C_INCLUDES += -I$(BLE_LIB)/ns_library/ble
C_INCLUDES += -I$(BLE_LIB)/ns_library/dfu

CFLAGS  = $(MCU) $(DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections -g -gdwarf-2
ASFLAGS = $(MCU) $(OPT) -Wall -fdata-sections -ffunction-sections -g -gdwarf-2

LDSCRIPT = n32wb033_flash.ld
LDFLAGS  = $(MCU) -specs=nano.specs -specs=nosys.specs -T$(LDSCRIPT) \
           -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

OBJECTS  = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) -MMD -MP -MF"$(@:%.o=%.d)" $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(CC) -c $(ASFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile $(LDSCRIPT)
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(CP) -O ihex -S $< $@

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(CP) -O binary -S $< $@

$(BUILD_DIR):
	mkdir -p $@

clean:
	-rm -fR $(BUILD_DIR)

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean

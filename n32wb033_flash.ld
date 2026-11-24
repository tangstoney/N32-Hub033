/*
 * rd91_hub033 链接脚本（台架直跑镜像，链在 0x01000000）
 *
 * 依据 N32WB033 数据手册 / MDK 工程 IRAM(0x20000000,0x10000) IROM(0x01000000,0x80000)
 *   Flash : 0x0100_0000 - 0x0107_FFFF  512KB
 *   SRAM  : 0x2000_0000 - 0x2000_FFFF   64KB
 *   BLE_SRAM: 0x2001_0000 - 0x2001_3FFF  16KB（蓝牙基带专用，不归应用）
 *
 * 注意：
 *  1) 本阶段没跑 BLE 协议栈，所以 RAM 从 0x20000000 起用满 64KB。
 *     一旦把 master_slave_relay 的 BLE 合并进来，RAM 必须改成
 *     ORIGIN = 0x20004000, LENGTH = 48K（前 16KB 归协议栈），
 *     依据 CN_UG_N32WB033_BLE_Development_Guide_V1.0 第 2.5.2 节。
 *  2) 本镜像链在 0x01000000，会覆盖 MasterBoot。
 *     做 OTA 时链接基址必须改成 0x01002000、长度 <= 0x3B000。
 *  3) N32WB033 的 Flash 不在 0x08000000，SystemInit 里 VTOR 也写 0x01000000。
 */

ENTRY(Reset_Handler)

/* 未启用 BLE 时栈顶 = 64KB SRAM 末尾 */
_estack = 0x20010000;

_Min_Heap_Size  = 0x200;
_Min_Stack_Size = 0x800;

MEMORY
{
  FLASH (rx)  : ORIGIN = 0x01000000, LENGTH = 512K
  RAM   (xrw) : ORIGIN = 0x20004000, LENGTH = 48K
}

SECTIONS
{
  /* 向量表必须在 Flash 最前 */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector))
    . = ALIGN(4);
  } >FLASH

  /* ARMCC 启动文件里向量表叫 __Vectors，GCC 启动文件里叫 g_pfnVectors，
     BLE 中间件（ns_ble.c）外引用的是 __Vectors，这里做别名。 */
  __Vectors = g_pfnVectors;

  .text :
  {
    . = ALIGN(4);
    *(.text)
    *(.text*)
    *(.glue_7)
    *(.glue_7t)
    *(.eh_frame)

    KEEP(*(.init))
    KEEP(*(.fini))

    . = ALIGN(4);
    _etext = .;
  } >FLASH

  .rodata :
  {
    . = ALIGN(4);
    *(.rodata)
    *(.rodata*)
    . = ALIGN(4);
  } >FLASH

  .ARM.extab : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >FLASH
  .ARM :
  {
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
  } >FLASH

  .preinit_array :
  {
    PROVIDE_HIDDEN(__preinit_array_start = .);
    KEEP(*(.preinit_array*))
    PROVIDE_HIDDEN(__preinit_array_end = .);
  } >FLASH

  .init_array :
  {
    PROVIDE_HIDDEN(__init_array_start = .);
    KEEP(*(SORT(.init_array.*)))
    KEEP(*(.init_array*))
    PROVIDE_HIDDEN(__init_array_end = .);
  } >FLASH

  .fini_array :
  {
    PROVIDE_HIDDEN(__fini_array_start = .);
    KEEP(*(SORT(.fini_array.*)))
    KEEP(*(.fini_array*))
    PROVIDE_HIDDEN(__fini_array_end = .);
  } >FLASH

  _sidata = LOADADDR(.data);

  .data :
  {
    . = ALIGN(4);
    _sdata = .;
    *(.data)
    *(.data*)
    . = ALIGN(4);
    _edata = .;
  } >RAM AT> FLASH

  . = ALIGN(4);
  .bss :
  {
    _sbss = .;
    __bss_start__ = _sbss;
    *(.bss)
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    _ebss = .;
    __bss_end__ = _ebss;
  } >RAM

  ._user_heap_stack :
  {
    . = ALIGN(4);
    PROVIDE(end = .);
    PROVIDE(_end = .);
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(4);
  } >RAM

  .ARM.attributes 0 : { *(.ARM.attributes) }
}

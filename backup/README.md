# N32WB033 片内 Flash 备份（2026-11-24）

- 文件：`N32WB033_flash_0x01000000_512K_20261124.bin`
- 地址范围：`0x01000000 – 0x0107FFFF`（512 KB 全片原样）
- 文件大小：524288 字节
- SHA-256：`d1070a083f9d4bcaae513a80efb50fe82c88c9bc72929848a82294f1cd65fb7a`
- 有效内容：`0x01000000` 起 `0x3FD8` 字节（最后一个非 0xFF 字节在 `0x01003FD7`），之后全部为 0xFF（空白）
- 向量表：SP=`0x20004D20`，Reset=`0x010000D5`，NMI=`0x010000DD`，HardFault=`0x010000DF`
- 注意：**这不是 rd91_hub033 的固件**（本工程 SP=`0x20010000`，Reset=`0x010042DD`）

## 采集命令

```bat
cd /d D:\Tangshi\Project\N32Demo\_sdk\NSING.N32WB033_Library.1.0.1\utilities\dfu

NSpyocd\NSpyocd.exe cmd -t n32wb033 --config=NSUtil\config.yaml ^
  -c "reset" ^
  -c "savemem 0x01000000 0x80000 D:\Tangshi\Programs\Hqvt\rd91\firmware\rd91_hub033\backup\N32WB033_flash_0x01000000_512K_20261124.bin"
```

必须先 `reset`：板子停在 ROM/ISP 状态时，调试器读 `0x01000000` 会 `TransferFault`；
复位让应用跑起来之后 flash 才可读。采集后已重新读取前 16 KB 与备份逐字节比对，一致。

## 恢复命令

```bat
NSpyocd\NSpyocd.exe load ^
  "D:\Tangshi\Programs\Hqvt\rd91\firmware\rd91_hub033\backup\N32WB033_flash_0x01000000_512K_20261124.bin@0x01000000" ^
  -t n32wb033 -M pre-reset
```

恢复会按需擦写，确认板子上没有需要保留的其它内容再执行。

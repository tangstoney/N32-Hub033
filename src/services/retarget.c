/**
 * @file    retarget.c
 * @brief   GCC/newlib 的 printf 重定向
 *
 * SDK 的 bsp/log.c 只重写了 fputc()，那是 Keil/ARMCC 的方式：
 * ARMCC 的 printf 会调用 fputc，但 GCC + newlib 的 printf 走 _write()。
 * 不定义 _write() 时链接到 libnosys 的空桩（返回 -1，不发送任何字节），
 * 而且 --gc-sections 会把没人引用的 fputc() 直接丢掉。
 *
 * 这里补上 _write()，转发给 log.c 的 fputc()（保留它的 \r\n 处理），
 * 并关闭 stdout 缓冲，保证 "> " 这种没有换行的提示符也能立即出现。
 */
#include <stdio.h>
#include "n32wb033.h"
#include "n32wb033_usart.h"
#include "retarget.h"

int _write(int fd, char *ptr, int len)
{
    int i;

    (void)fd;
    for (i = 0; i < len; i++) {
        fputc((unsigned char)ptr[i], stdout);
    }
    return len;
}

void retarget_init(void)
{
    setvbuf(stdout, NULL, _IONBF, 0);
}

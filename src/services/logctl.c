/**
 * @file    logctl.c
 * @brief   异步日志开关
 */
#include <stdio.h>
#include "logctl.h"

static bool s_on = true;

void logctl_init(void)
{
    s_on = true;
}

void logctl_set(bool on)
{
    s_on = on;
    printf("log: async logs %s\r\n", on ? "on" : "off");
}

bool logctl_enabled(void)
{
    return s_on;
}

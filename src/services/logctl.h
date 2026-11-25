/**
 * @file    logctl.h
 * @brief   运行期异步日志开关（雷达/语音/报警/充电），BLE 日志不受影响
 */
#ifndef __LOGCTL_H__
#define __LOGCTL_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>

void logctl_init(void);
void logctl_set(bool on);
bool logctl_enabled(void);

#ifdef __cplusplus
}
#endif
#endif /* __LOGCTL_H__ */

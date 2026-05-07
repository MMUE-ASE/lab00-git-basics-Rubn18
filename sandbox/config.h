/*
 * config.h — project configuration for Git workflow practice
 *
 * Ejercicio A: change BLINK_DELAY_MS from 500 to 1000
 * and commit the change with a descriptive message.
 */

#ifndef CONFIG_H
#define CONFIG_H

/* System clock frequency in Hz */
#define SYS_FREQ_HZ 100000000UL /* 100 MHz — STM32F412ZG default */

/* LED blink period in milliseconds — TODO (Ejercicio A): update to 1000 */
#define BLINK_DELAY_MS 500U

#endif /* CONFIG_H */

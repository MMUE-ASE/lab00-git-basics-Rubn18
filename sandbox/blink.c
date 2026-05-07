/*
 * blink.c — LED blink skeleton for Git workflow practice
 *
 * Author: Ruben Diaz Castillo
 *
 * This file is intentionally incomplete. Its purpose is to give students
 * a real C file to modify across multiple commits during Lab 0.
 * It does NOT need to compile or run — it is a sandbox for Git practice.
 *
 * Target board: STM32 NUCLEO-F412ZG
 * LED: LD2 → PB7 (active high)
 * Button: B1 → PC13 (active low, pull-up)
 */

#define LED_PIN   7   /* PB7 — LD2  */
#define BTN_PIN  13   /* PC13 — B1  */

/*
 * blink_init — configure GPIO clocks and pin modes
 *
 * Ejercicio A: add a comment "/* clock enabled *\/" inside this function body
 * as a placeholder (the real implementation comes in Lab 1).
 */
void blink_init(void)
{
    /* TODO (Ejercicio A): add placeholder comment here */
}

/*
 * blink_once — turn LED on, wait delay_ms, turn LED off
 *
 * Ejercicio B: implement this function body on branch feat/blink-led
 * using pseudocode comments, e.g.:
 *   /* set PB7 high *\/
 *   /* wait delay_ms cycles *\/
 *   /* set PB7 low *\/
 */
void blink_once(unsigned int delay_ms)
{
    /* TODO (Ejercicio B): implement on branch feat/blink-led */
    (void)delay_ms;
}

/*
 * blink_n_times — blink the LED n times with delay_ms between each blink
 *
 * Ejercicio E: implement this function on branch feat/blink-n-times.
 * The body should call blink_once in a loop — pseudocode in comments is fine.
 */
void blink_n_times(unsigned int n, unsigned int delay_ms)
{
    /* TODO (Ejercicio E): implement on branch feat/blink-n-times */
    (void)n;
    (void)delay_ms;
}

int main(void)
{
    blink_init();

    while (1) {
        blink_n_times(3, 500);
    }

    return 0;
}

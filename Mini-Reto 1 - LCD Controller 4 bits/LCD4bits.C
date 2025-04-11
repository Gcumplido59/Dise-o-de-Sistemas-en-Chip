#include "MKL25Z4.h"

// Pines actualizados para LCD (PORTA)
#define RS (1 << 2)     // PTA2
#define EN (1 << 1)     // PTA1
#define D4 (1 << 4)     // PTA4
#define D5 (1 << 5)     // PTA5
#define D6 (1 << 12)    // PTA12
#define D7 (1 << 13)    // PTA13

void delayMs(int n) {
    for (int i = 0; i < n * 4000; i++) {
        __NOP();
    }
}

void pulseEnable(void) {
    PTA->PSOR = EN;
    delayMs(1);
    PTA->PCOR = EN;
    delayMs(1);
}

void sendNibble(uint8_t nibble) {
    PTA->PCOR = D4 | D5 | D6 | D7;

    if (nibble & 0x01) PTA->PSOR = D4;
    if (nibble & 0x02) PTA->PSOR = D5;
    if (nibble & 0x04) PTA->PSOR = D6;
    if (nibble & 0x08) PTA->PSOR = D7;

    pulseEnable();
}

void sendByte(uint8_t byte, int isData) {
    if (isData)
        PTA->PSOR = RS;
    else
        PTA->PCOR = RS;

    sendNibble(byte >> 4);
    sendNibble(byte & 0x0F);
    delayMs(2);
}

void lcd_init(void) {
    SIM->SCGC5 |= SIM_SCGC5_PORTA_MASK;

    // Configura todos los pines como GPIO
    PORTA->PCR[1]  = PORT_PCR_MUX(1); // EN
    PORTA->PCR[2]  = PORT_PCR_MUX(1); // RS
    PORTA->PCR[4]  = PORT_PCR_MUX(1); // D4
    PORTA->PCR[5]  = PORT_PCR_MUX(1); // D5
    PORTA->PCR[12] = PORT_PCR_MUX(1); // D6
    PORTA->PCR[13] = PORT_PCR_MUX(1); // D7

    PTA->PDDR |= RS | EN | D4 | D5 | D6 | D7;

    delayMs(50);

    // Inicialización modo 4 bits
    sendNibble(0x03); delayMs(5);
    sendNibble(0x03); delayMs(5);
    sendNibble(0x03); delayMs(5);
    sendNibble(0x02); delayMs(5);  // Modo 4 bits

    sendByte(0x28, 0); // 4 bits, 2 líneas, 5x8
    sendByte(0x0C, 0); // Display ON
    sendByte(0x06, 0); // Auto incremento
    sendByte(0x01, 0); // Clear
    delayMs(2);
}

void lcd_print(const char* text) {
    while (*text) {
        sendByte(*text++, 1);
    }
}

int main(void) {
    lcd_init();

    sendByte(0x80, 0);            // Línea 1, columna 0
    lcd_print("Hola KL25Z :)");   // Mostrar texto

    while (1) {
        //
    }
}

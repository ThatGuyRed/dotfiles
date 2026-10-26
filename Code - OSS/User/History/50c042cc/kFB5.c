#include "display_macros.h"
#include <avr/interrupt.h>
#include <avr/io.h>
#include <workshop.h>
// Section 1
void enable_dp() {
  // Set PB5 low and enable output
  PORTB.DIRSET = PIN5_bm;
  
  PORTB.OUTCLR = PIN5_bm;
}

// Set this variable to 1 after tasks 1 has been completed
volatile uint8_t complete = 0;

// Section 2
void timer_init(void) {
  TCB0.CTRLB = TCB_CNTMODE_INT_gc; // Configure TCB0 in periodic interrupt mode
  TCB0.CCMP = 3333;                // Set interval for 1 ms
  TCB0.INTCTRL = TCB_CAPT_bm;      // CAPT interrupt enable
  TCB0.CTRLA = TCB_ENABLE_bm;      // Enable

  TCB1.CTRLB = TCB_CNTMODE_INT_gc; // Configure TCB1 in periodic interrupt mode
  TCB1.CCMP = 16667;                // Set interval for 5 ms
  TCB1.INTCTRL = TCB_CAPT_bm;      // CAPT interrupt enable
  TCB1.CTRLA = TCB_ENABLE_bm;      // Enable
}

// A count of elapsed time in milliseconds
volatile uint64_t elapsed_time = 0;
ISR(TCB0_INT_vect) {
  elapsed_time++;
  TCB0.INTFLAGS = TCB_CAPT_bm;
}

// Section 3

void spi_init() {
  // Uncomment for task 4

  // Step 1: Configure SPI0 to output to the 74HC595D shift register
  // (Refer to the QUTy datasheet & worksheet section 4.2)
  //
  // Step 2: Enable output on the SPI_CLK and SPI_MOSI pins
  // (Refer to QUTy datasheet)
  //
  // Step 3: Set DISP LATCH initially HIGH and enable
  // it as an output

  // Hint: The 74HC595D is not mapped to PC0-3 by default,
  // so you will have to configure that using PORTMUX
  // (More details in section 4.2)
  PORTMUX.SPIROUTEA = PORTMUX_SPI0_DEFAULT_gc; // SPI pins on PC0-3
  PORTC.DIRSET = 0x00; // Set SCK (PC0) and MOSI (PC2) as outputs

  // Set DISP LATCH initially HIGH and enable output

  // DO NOT EDIT BELOW THIS LINE
  SPI0.CTRLA = SPI_MASTER_bm;  // Master, /4 prescaler, MSB first
  SPI0.CTRLB = SPI_SSD_bm;     // Mode 0, client select disable, unbuffered
  SPI0.INTCTRL = SPI_IE_bm;    // Enable SPI interrupt
  SPI0.CTRLA |= SPI_ENABLE_bm; // Enable
}

ISR(SPI0_INT_vect) {
  // Task: Create a rising edge on DISP_LATCH to trigger
  // whenever this ISR is called

  // DO NOT EDIT BELOW THIS LINE
  SPI0.INTFLAGS = SPI_IF_bm; // Clear IF bit
}

volatile uint8_t left_byte = DISP_OFF;
volatile uint8_t right_byte = DISP_OFF;

void update_display(const uint8_t left, const uint8_t right) {
  // Workshop task
  // Task: Implement a function that would update
  // the values of left_byte and right_byte.

  // Hint: When the most significant bit (bit 7) is set
  // to HIGH, the left digit is selected; while LOW would
  // select the right digit.

  left_byte = left | (1 << 7);
  right_byte = right;
}

ISR(TCB1_INT_vect) {
  // Update pb_debounced_state of pushbuttons
  btn_debounce();

  // Task: Toggle the left and right digits of the
  // 7-segment display by setting SPI0.DATA to the desired digits
  static int swap = 0;
  if (swap)
    SPI0.DATA = 0xFF;
  else
    SPI0.DATA = 0xFF;
  swap = !swap;

  // Task: Poll the potentiometer by calling the
  // function you implemented in section 5.
  // If you have not yet completed section 5,
  // ignore this comment

  TCB1.INTFLAGS = TCB_CAPT_bm; // Clear interrupt flag
}

void buttons_init(void) {
  // TASK:
  // Enable pullup resistors for pushbutton 1-4
  // Hint: Refer to the section 4.4
}

// Section 4
void adc_init(void) {
  ADC0.CTRLA = ADC_ENABLE_bm;     // Enable ADC0
  ADC0.CTRLB = ADC_PRESC_DIV2_gc; // 2 prescaler
  ADC0.CTRLC = 0x00; // Set timebase and set reference voltage to VDD
  ADC0.CTRLE = 64;   // Sample duration
  ADC0.MUXPOS = ADC_MUXPOS_AIN2_gc; // Select ADC channel AIN2 (PA2)
}

volatile uint8_t result;
void poll_pot(void) {
  // Task B
  // Start conversion
  ADC0.COMMAND = 0x00;
  // Poll RESRDY INTFLAG
  // Hint: Use a while loop

  // Task C
  result = 0x00;
  ADC0.INTFLAGS = ADC_RESRDY_bm; // clear interrupt bit
}

// Section 5
// Scale the output from ADC0.RESULT to be able to adjust the
// brightness of the 7-segment display from 0-100%

void pwm_init() {
  PORTB.OUTCLR = PIN1_bm; // led off
  PORTB.DIRSET = PIN1_bm; // enable led

  // CLK_PER sel, 2 prescaler (1.67 MHz)
  TCA0.SINGLE.CTRLA = TCA_SINGLE_CLKSEL_DIV2_gc;
  TCA0.SINGLE.CTRLB = TCA_SINGLE_CMP1EN_bm | TCA_SINGLE_WGMODE_SINGLESLOPE_gc;
  TCA0.SINGLE.INTCTRL = TCA_SINGLE_OVF_bm;

  // Task A:
  // Configure TCA0 to drive DISP_EN at ~51 Hz,
  // and set the initial duty cycle to 50%
  //
  TCA0.SINGLE.PER = 10000;
  // Init at 50% duty cycle
  TCA0.SINGLE.CMP1 = 5000;

  // Enable TCA0
  TCA0.SINGLE.CTRLA |= TCA_SINGLE_ENABLE_bm;
}

ISR(TCA0_OVF_vect) {
  // Task B:
  // Configure the ISR to Scale ADC0.RESULT to between
  // 0 and the maximum value of TCA0.SINGLE.PER and
  // store the result in TCA0.CMP1BUF
  TCA0.SINGLE.CMP1BUF = 5000;               // update duty cycle
  TCA0.SINGLE.INTFLAGS = TCA_SINGLE_OVF_bm; // acknowledge interrupt
}

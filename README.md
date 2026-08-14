# FPGA Digital Design

A collection of Verilog RTL designs and simulation-oriented modules developed during FPGA and digital design laboratory work.

The repository is organized from the HDL work contained in the supplied lab document. It covers combinational arithmetic, sequential arithmetic, memory, FIFO, FSM, DSP, clocking, and seven-segment display designs.

## Designs Included

### Arithmetic Units
- Full adder
- 4-bit ripple carry adder
- 4-bit adder/subtractor
- 4-bit carry look-ahead adder
- Carry select adder
- Carry skip adder
- Carry save adder
- Conditional sum adder

### Multipliers
- Sequential multiplier
- 4-bit × 3-bit sequential multiplier

### Memory
- Single-port RAM
- File-initialized RAM using `$readmemh`
- Dual-port RAM

### FIFO
- Parameterized synchronous FIFO
- Asynchronous FIFO with separate read/write clock domains and pointer synchronization

### FSM
- Mealy vending machine
- Moore vending machine

### DSP / Image Processing
- 4-tap serial FIR filter
- 4-tap pipelined FIR filter
- 4-tap parallel/pipelined-style FIR implementation
- Sobel edge detection using a 3×3 kernel

### Digital Clock / Display
- Clock divider
- Digital clock with seconds, minutes, and hours
- Six-digit seven-segment clock display
- Seven-segment decoder
- Seven-segment adder
- ROM-driven seven-segment display

## Repository Structure

```text
FPGA-Digital-Design/
├── README.md
├── 01_arithmetic_units/
│   └── arithmetic_units.v
├── 02_multipliers/
│   └── sequential_multipliers.v
├── 03_memory/
│   ├── ram.v
│   └── input.txt
├── 04_fifo/
│   └── fifo.v
├── 05_fsm/
│   └── vending_machines.v
├── 06_dsp/
│   ├── fir_filters.v
│   └── sobel_edge_detection.v
├── 07_digital_clock/
│   └── digital_clock.v
├── 08_peripherals/
│   └── seven_segment_and_rom.v
└── testbenches/
    ├── digital_clock_tb.v
    ├── fifo_tb.v
    ├── fir_tb.v
    └── sobel_tb.v
```

## Tools / Workflow

- Verilog HDL
- ModelSim for simulation
- Intel Quartus Prime for FPGA-oriented design work

## Notes

The source material supplied for this repository did not include the original Quartus project files, pin assignments, waveform images, RTL screenshots, or FPGA-board photographs. Therefore, the repository does not claim hardware results that are not present in the supplied material.

Some source material contained repeated modules and formatting inconsistencies. The repository separates the designs into reusable Verilog files and avoids intentionally duplicating identical module definitions.

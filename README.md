# FPGA Digital Design

A collection of Verilog RTL designs and simulation-oriented modules developed during FPGA and digital design laboratory work.

The repository is organized from the HDL work contained in the supplied lab document. It covers combinational arithmetic, sequential arithmetic, memory, FIFO, FSM, DSP, clocking, seven-segment display designs, and FPGA-oriented FIR/Sobel implementations.

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

### DSP / FPGA Image Processing
- **4-tap serial FIR filter — FPGA implementation**
- **4-tap pipelined FIR filter — FPGA-oriented design**
- 4-tap parallel/pipelined-style FIR implementation
- **Sobel edge detection — FPGA implementation**
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
├── 06_dsp_fpga/
│   ├── fir_filters/
│   │   ├── fir_serial_fpga.v
│   │   └── fir_pipelined.v
│   └── sobel_edge_detection_fpga/
│       └── sobel_edge_detection.v
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
- Intel Quartus Prime for FPGA-oriented design and implementation

## Notes

The source material supplied for this repository did not include the original Quartus project files, pin assignments, waveform images, RTL screenshots, or FPGA-board photographs. Therefore, the repository does not claim hardware results that are not present in the supplied material.

The FIR and Sobel designs are kept under the FPGA/DSP section rather than as separate repositories because they were developed as part of the FPGA design work.

Some source material contained repeated modules and formatting inconsistencies. The repository separates the designs into reusable Verilog files and avoids intentionally duplicating identical module definitions.

# FPGA Digital Design

A collection of Verilog RTL designs and simulation-oriented modules developed during FPGA and digital design laboratory work.

The repository is organized as **one Verilog source file per design/module**, making each implementation easy to inspect, simulate, and reuse.

## Designs Included

### 01 — Arithmetic Units
- Full adder
- 4-bit ripple carry adder
- 4-bit adder/subtractor
- 4-bit carry look-ahead adder
- Carry select adder
- Carry skip adder
- Carry save adder
- Carry save final adder
- Conditional sum adder

### 02 — Multipliers
- Sequential multiplier
- 4-bit × 3-bit sequential multiplier

### 03 — Memory
- Single-port RAM
- File-initialized RAM using `$readmemh`
- Dual-port RAM
- Input memory data file

### 04 — FIFO
- Parameterized synchronous FIFO
- Asynchronous FIFO with separate read/write clock domains and pointer synchronization

### 05 — FSM
- Mealy vending machine
- Moore vending machine

### 06 — DSP / FPGA Image Processing
- 4-tap serial FIR filter — FPGA implementation
- 4-tap pipelined FIR filter
- 16-bit serial FIR implementation
- 16-bit parallel/pipelined-style FIR implementation
- Sobel edge detection — FPGA implementation using a 3×3 kernel

### 07 — Digital Clock
- Clock divider
- Digital clock core
- Real-time clock with six seven-segment outputs
- Seven-segment decoder

### 08 — FPGA Peripherals
- Full hexadecimal seven-segment decoder
- Seven-segment adder
- ROM-driven seven-segment display

## Repository Structure

```text
FPGA-Digital-Design/
├── README.md
│
├── 01_arithmetic_units/
│   ├── fulladder.v
│   ├── rca_4bit.v
│   ├── adder_subtractor.v
│   ├── cla_4bit.v
│   ├── carry_select_adder.v
│   ├── carry_skip_adder.v
│   ├── carry_save_adder.v
│   ├── carry_save_adder_final.v
│   └── conditional_sum_adder.v
│
├── 02_multipliers/
│   ├── sequential_multiplier.v
│   └── sequential_multiplier_4x3.v
│
├── 03_memory/
│   ├── single_port_ram.v
│   ├── file_initialized_ram.v
│   ├── dual_port_ram.v
│   └── input.txt
│
├── 04_fifo/
│   ├── synchronous_fifo.v
│   └── asynchronous_fifo.v
│
├── 05_fsm/
│   ├── mealy_vending_machine.v
│   └── moore_vending_machine.v
│
├── 06_dsp_fpga/
│   ├── fir_filters/
│   │   ├── fir_filter_serial.v
│   │   ├── fir_filter_pipelined.v
│   │   ├── fir_serial_16bit.v
│   │   └── fir_filter_parallel_16bit.v
│   └── sobel_edge_detection_fpga/
│       └── sobel_edge_detection.v
│
├── 07_digital_clock/
│   ├── clock_divider.v
│   ├── digital_clock_core.v
│   ├── real_clock.v
│   └── seven_segment_decoder.v
│
├── 08_peripherals/
│   ├── seven_segment_decoder_full.v
│   ├── seven_segment_adder.v
│   └── rom_display.v
│
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

FIR and Sobel are kept under the FPGA/DSP section rather than as separate repositories because they were developed as part of the FPGA design work.

The source modules are separated into individual files instead of combining unrelated designs into large Verilog files. The implementations remain based on the supplied lab material; no unsupported hardware results have been added.

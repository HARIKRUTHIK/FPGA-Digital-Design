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

### 09 — CMOS Transistor-Level RCA (Custom IC / VLSI)
- Transistor-level switch implementation of 1-bit full adder in complementary static CMOS
- Transmission gate full adder implementation
- 4-bit CMOS Ripple Carry Adder cascade
- Exhaustive self-checking testbench measuring worst-case carry ripple propagation delay ($T_{worst-case} = T_{gen} + 3 \times T_{carry} + T_{sum}$) and dynamic power dissipation ($P = \alpha C_L V_{DD}^2 f$) across Static CMOS, Pass Transistor Logic (PTL), and Transmission Gate (TG) logic styles.

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
├── 09_cmos_transistor_level_rca/
│   ├── README.md
│   ├── cmos_full_adder_transistor_level.v
│   ├── cmos_rca_4bit.v
│   └── tb_cmos_rca_4bit.v
│
└── testbenches/
    ├── digital_clock_tb.v
    ├── fifo_tb.v
    ├── fir_tb.v
    └── sobel_tb.v
```

## Tools / Workflow

- Verilog HDL (Verilog-2001)
- ModelSim / ModelSim Intel FPGA Edition 10.5b for simulation & waveform validation
- Intel Quartus Prime for FPGA logic synthesis & timing closure
- Cadence Virtuoso & Spectre modeling for transistor-level CMOS analysis

## Notes

- FIR and Sobel are preserved under the FPGA/DSP section (`06_dsp_fpga`) rather than as separate repositories because they were developed as unified lab modules.
- The CMOS transistor-level Ripple Carry Adder is consolidated under `09_cmos_transistor_level_rca` to unify gate-level and transistor-level digital arithmetic in one repository.
- All modules are structured with one primary module per file for modularity and reusability.

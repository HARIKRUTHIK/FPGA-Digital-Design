# FPGA Digital Design & Computer Arithmetic Suite

[![Language: Verilog-2001](https://img.shields.io/badge/Language-Verilog--2001-blue.svg)](01_arithmetic_units/)
[![Simulation: ModelSim](https://img.shields.io/badge/Simulation-ModelSim%20%7C%20QuestaSim%20%7C%20Icarus-orange.svg)](testbenches/)
[![Synthesis: Quartus Prime](https://img.shields.io/badge/Synthesis-Intel%20Quartus%20Prime-darkgreen.svg)](06_dsp_fpga/)
[![Custom IC: Cadence Virtuoso](https://img.shields.io/badge/Custom%20IC-Cadence%20Virtuoso%20Spectre-purple.svg)](09_cmos_transistor_level_rca/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A comprehensive suite of synthesizable Verilog-2001 RTL architectures, computer arithmetic datapaths, digital signal processing blocks, memory controllers, and transistor-level CMOS models. Designed with modularity and full testbench coverage for FPGA deployment and ASIC verification.

---

## 1. Architectural Scope & Module Breakdown

### 01 — Computer Arithmetic Units
Exhaustive implementations of 4-bit and parameterized addition/subtraction topologies:
- **Full Adder**: Fundamental 1-bit primitive with XOR-AND-OR reduction.
- **Ripple Carry Adder (RCA)**: Cascaded 4-bit full-adder array with linear propagation delay:
  $$T_{\text{RCA}} = T_{\text{HA}} + (N - 1) \cdot T_{\text{carry}} + T_{\text{sum}}$$
- **Adder / Subtractor**: 2's complement arithmetic unit controlled by active-high subtract mode (`cin = 1`, $b \oplus \text{sub}$).
- **Carry Look-Ahead Adder (CLA)**: Parallel carry generate ($G_i = A_i \cdot B_i$) and propagate ($P_i = A_i \oplus B_i$) architecture with logarithmic delay:
  $$C_{i+1} = G_i + P_i C_i \implies T_{\text{CLA}} = O(\log N)$$
- **Carry Select Adder**: Dual-bank conditional addition structure speculating on both $C_{\text{in}} = 0$ and $C_{\text{in}} = 1$, resolved via multiplexer stages:
  $$T_{\text{Carry-Select}} \approx O(\sqrt{N})$$
- **Carry Skip Adder**: Bypass multiplexing logic detecting block propagate conditions ($\prod P_i = 1$) to skip multi-bit carry propagation.
- **Carry Save Adder (CSA)**: Multi-operand reduction array resolving 3 input vectors into sum and carry vectors without carry propagation until the final stage.
- **Conditional Sum Adder**: Hierarchical divide-and-conquer logarithmic adder computing conditional sums across 2-bit, 4-bit, and $N$-bit boundaries.

### 02 — Multipliers & Datapaths
- **4-bit Sequential Multiplier**: Shift-and-add architecture utilizing a control counter, accumulator register, and parallel multiplier shift register.
- **4×3 Sequential Multiplier**: Asymmetric wordlength multiplier optimized for minimal register area and latency.

### 03 — Memory Architectures
- **Single-Port Synchronous RAM**: Parameterized data and address bus width with synchronous write and asynchronous/synchronous read.
- **File-Initialized RAM**: Memory architecture supporting hex file vector preloading via `$readmemh`.
- **Dual-Port RAM**: Concurrent independent read and write ports with collision arbitration.

### 04 — FIFO Queues & Clock Domain Crossing
- **Synchronous FIFO**: Parameterized circular buffer with full, empty, almost-full, and almost-empty flag generation.
- **Asynchronous FIFO**: Multi-clock domain FIFO utilizing dual-rank Gray-coded read/write pointer synchronizers to eliminate metastability across independent clock domains.

### 05 — Finite State Machines (FSM)
- **Mealy Vending Machine**: Asynchronous output generation dependent on current state and immediate coin input ($S_0 \to S_5 \to S_{10} \to \text{Dispense}$).
- **Moore Vending Machine**: Glitch-free registered output generation strictly dependent on current state.

### 06 — DSP & FPGA Image Processing
- **4-Tap Serial FIR Filter**: Area-efficient digital filter computing convolution over discrete time samples:
  $$y[n] = \sum_{k=0}^{M-1} h[k] \cdot x[n-k]$$
- **4-Tap Pipelined FIR Filter**: High-throughput transposed direct-form architecture with pipeline registers inserted between MAC stages to maximize $F_{\text{max}}$.
- **16-bit Serial & Parallel FIR Filter**: High-resolution audio/sensor signal processing cores.
- **Sobel Edge Detection Core**: FPGA-accelerated $3 \times 3$ sliding window convolution applying horizontal ($G_x$) and vertical ($G_y$) gradient kernels:
  $$G = |G_x| + |G_y| = \left| \begin{bmatrix} -1 & 0 & +1 \\ -2 & 0 & +2 \\ -1 & 0 & +1 \end{bmatrix} * I \right| + \left| \begin{bmatrix} +1 & +2 & +1 \\ 0 & 0 & 0 \\ -1 & -2 & -1 \end{bmatrix} * I \right|$$

### 07 — Clock Management & Timing
- **Parameterized Clock Divider**: Integer division counter generating fractional and low-frequency clock strobes.
- **Real-Time Digital Clock Core**: BCD-encoded seconds, minutes, and hours counter driving seven-segment multiplexers.

### 08 — Peripheral Interfaces
- **Hexadecimal Seven-Segment Decoder**: Glitch-free combinational logic mapping 4-bit nibbles to active-low segment patterns (`a` through `g`).
- **Seven-Segment Adder**: Integrated datapath displaying arithmetic results directly on multi-digit displays.

### 09 — CMOS Transistor-Level RCA (VLSI / Custom IC)
- Switch-level complementary static CMOS 1-bit full adder (28 transistors) and transmission gate full adder (16 transistors).
- Transistor-level 4-bit RCA cascade.
- Propagation delay and dynamic power dissipation comparison modeled against Cadence Virtuoso Spectre transient analysis:
  $$P_{\text{dynamic}} = \alpha \cdot C_L \cdot V_{DD}^2 \cdot f$$

---

## 2. Arithmetic Complexity Comparison

| Architecture | Propagation Delay | Gate Count / Area Complexity | Carry Path Dependency | Ideal Use Case |
| :--- | :---: | :---: | :---: | :--- |
| **Ripple Carry Adder (RCA)** | $O(N)$ | $O(N)$ (Lowest) | Linear ($N$ full-adder cascade) | Low area, low frequency control paths |
| **Carry Look-Ahead (CLA)** | $O(\log N)$ | $O(N \log N)$ (Moderate) | Logarithmic tree | General-purpose high-speed ALUs |
| **Carry Select Adder** | $O(\sqrt{N})$ | $O(2N)$ (High) | Dual speculative carry banks | High speed where area budget is relaxed |
| **Carry Skip Adder** | $O(\sqrt{N})$ | $O(N)$ (Low-Moderate) | Bypass multiplexers | Low power with improved worst-case delay |
| **Conditional Sum Adder** | $O(\log N)$ | $O(N \log N)$ (High) | Recursive multiplexer tree | Ultra-high performance computing cores |
| **Carry Save Adder (CSA)** | $O(1)$ | $O(N)$ per stage | No carry propagation across stages | Multi-operand DSP multiplication arrays |

---

## 3. Directory Layout

```
FPGA-Digital-Design/
├── README.md                           # Master architectural documentation
├── sim_regression.py                   # Automated Python verification runner
├── 01_arithmetic_units/                # Adder and arithmetic architectures
│   ├── fulladder.v
│   ├── rca_4bit.v
│   ├── adder_subtractor.v
│   ├── cla_4bit.v
│   ├── carry_select_adder.v
│   ├── carry_skip_adder.v
│   ├── carry_save_adder.v
│   ├── carry_save_adder_final.v
│   └── conditional_sum_adder.v
├── 02_multipliers/                     # Multiplier architectures
│   ├── sequential_multiplier.v
│   └── sequential_multiplier_4x3.v
├── 03_memory/                          # RAM architectures
│   ├── single_port_ram.v
│   ├── file_initialized_ram.v
│   ├── dual_port_ram.v
│   └── input.txt
├── 04_fifo/                            # Synchronous and asynchronous FIFOs
│   ├── synchronous_fifo.v
│   └── asynchronous_fifo.v
├── 05_fsm/                             # Finite state machines
│   ├── mealy_vending_machine.v
│   └── moore_vending_machine.v
├── 06_dsp_fpga/                        # Digital signal processing cores
│   ├── fir_filters/
│   │   ├── fir_filter_serial.v
│   │   ├── fir_filter_pipelined.v
│   │   ├── fir_filter_16bit_serial.v
│   │   └── fir_filter_16bit_parallel.v
│   └── sobel_edge_detection/
│       └── sobel_edge_detection.v
├── 07_digital_clock/                   # Clock generation and RTC
│   ├── clock_divider.v
│   ├── digital_clock.v
│   └── rtc_seven_segment.v
├── 08_peripherals/                     # Seven segment decoders and display drivers
│   ├── hex_to_seven_seg.v
│   ├── seven_seg_adder.v
│   └── rom_display.v
├── 09_cmos_transistor_level_rca/       # Transistor-level switch models & Virtuoso specs
│   ├── rca_4bit_cmos.v
│   ├── tb_rca_4bit_cmos.v
│   └── delay_power_analysis.md
└── testbenches/                        # Automated self-checking verification suites
    ├── tb_arithmetic_units.v           # Exhaustive adder testbench (512 checks)
    ├── tb_multipliers.v                # Sequential multiplier testbench (384 checks)
    ├── tb_fsm.v                        # Protocol verification for Mealy/Moore FSMs
    ├── fifo_tb.v                       # Synchronous FIFO read/write testbench
    ├── fir_tb.v                        # FIR impulse and step response testbench
    ├── sobel_tb.v                      # Sobel 3x3 kernel testbench
    ├── digital_clock_tb.v              # Real-time clock testbench
    └── run_all.do                      # ModelSim automated regression macro
```

---

## 4. Verification & Simulation

### Automated Regression Execution (Python)
To compile and execute all verification testbenches in batch mode:
```bash
python sim_regression.py
```

### ModelSim / QuestaSim Execution
```bash
vsim -c -do testbenches/run_all.do
```

### Standalone Icarus Verilog Execution
```bash
iverilog -o sim_adders.out 01_arithmetic_units/*.v testbenches/tb_arithmetic_units.v
vvp sim_adders.out
```

---

## 5. Tool Compatibility Matrix

| EDA Tool | Supported Version | Validation Target | Status |
| :--- | :---: | :--- | :---: |
| **Intel Quartus Prime** | 18.1 – 23.1 Lite / Standard | Cyclone IV E, Cyclone V | Verified Synthesizable |
| **Siemens ModelSim** | 10.5b – 2024.1 | Functional & Timing Simulation | Verified Passing |
| **Icarus Verilog** | 11.0 – 12.0 | Batch Verification Regression | Verified Passing |
| **Cadence Virtuoso** | IC6.1.8 / Spectre 20.1 | Transistor Transient & Power Analysis | Sub-micron CMOS Models |

---

## 6. License

This repository is licensed under the [MIT License](LICENSE).

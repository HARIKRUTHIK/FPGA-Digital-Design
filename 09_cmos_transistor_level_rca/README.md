# CMOS 4-Bit Ripple Carry Adder: Transistor-Level Delay & Power Analysis

## Overview
This module explores the transistor-level custom IC implementation of a **4-bit Ripple Carry Adder (RCA)**, analyzing propagation delay, carry ripple propagation, transistor counts, and dynamic power dissipation across three fundamental CMOS logic styles:
1. **Static Complementary CMOS Logic**
2. **Pass Transistor Logic (PTL)**
3. **Transmission Gate (TG) Logic**

The design and transient analyses are modeled after Cadence Virtuoso schematic and Spectre simulation workflows (pre-VDAT 2024 VLSI Design & Test symposium curriculum).

---

## 1. Logic & Transistor Topologies

### Full Adder Boolean Equations
$$\text{Sum} = A \oplus B \oplus C_{in}$$
$$C_{out} = (A \oplus B) \cdot C_{in} + A \cdot B$$

### Topology Comparison

| Metric / Feature | Static Complementary CMOS | Pass Transistor Logic (PTL) | Transmission Gate (TG) Logic |
| :--- | :---: | :---: | :---: |
| **Transistor Count (per 1-bit FA)** | 28 Transistors | 16–20 Transistors | 20–24 Transistors |
| **Voltage Swing** | Full Rail-to-Rail ($0\text{V} \to V_{DD}$) | Degraded ($V_{DD} - V_{th}$ on NMOS high pass) | Full Rail-to-Rail ($0\text{V} \to V_{DD}$) |
| **Static Power Dissipation** | Negligible (sub-threshold leakage only) | Low | Low |
| **Carry Propagation Delay ($T_p$)** | Standard ($2 \times$ complex gate delays) | Slower with cascaded passes | Fastest carry ripple transfer |
| **Buffer Insertion Required** | No | Yes (restores threshold drop) | Recommended for long cascades |

---

## 2. 4-Bit Ripple Carry Architecture

The 4-bit adder cascades four 1-bit full adders in series. The critical path is governed by the carry propagation delay from bit 0 to bit 3:

$$T_{\text{worst-case}} = T_{\text{generate}}(FA_0) + 3 \times T_{\text{carry-to-carry}} + T_{\text{sum}}(FA_3)$$

```
        A[0] B[0]        A[1] B[1]        A[2] B[2]        A[3] B[3]
           │    │           │    │           │    │           │    │
           ▼    ▼           ▼    ▼           ▼    ▼           ▼    ▼
Cin ──►┌──────────┐  C1  ┌──────────┐  C2  ┌──────────┐  C3  ┌──────────┐
       │   FA 0   ├─────►│   FA 1   ├─────►│   FA 2   ├─────►│   FA 3   ├─────► Cout
       └────┬─────┘      └────┬─────┘      └────┬─────┘      └────┬─────┘
            │                 │                 │                 │
            ▼                 ▼                 ▼                 ▼
          Sum[0]            Sum[1]            Sum[2]            Sum[3]
```

---

## 3. Switch-Level Verilog Modeling

To accurately reflect transistor-level pull-up networks (PUN) and pull-down networks (PDN) without requiring proprietary SPICE licenses, the RTL modules use Verilog switch-level primitives (`cmos`, `pmos`, `nmos`):
- **`cmos_full_adder_transistor_level.v`**: Switch-level implementation of static CMOS full adder with 28 transistors.
- **`transmission_gate_full_adder.v`**: Implementation using parallel NMOS/PMOS transmission gates for XOR and multiplexer trees.
- **`cmos_rca_4bit.v`**: 4-bit structural cascade connecting the transistor-level slices with carry ripple interconnect.
- **`tb_cmos_rca_4bit.v`**: Self-checking testbench driving worst-case carry ripple sequences ($A=1111_2, B=0000_2, C_{in}=1 \to 0$) to measure propagation latency.

---

## 4. Delay & Power Formulation

### Propagation Delay ($t_{pd}$)
$$t_{pd} = \frac{t_{pLH} + t_{pHL}}{2}$$
Where $t_{pLH}$ is the time from $50\%$ input transition to $50\%$ output rise, and $t_{pHL}$ is from $50\%$ input to $50\%$ output fall.

### Dynamic Power Dissipation
$$P_{\text{dynamic}} = \alpha \cdot C_L \cdot V_{DD}^2 \cdot f$$
Where:
- $\alpha$: Switching activity factor
- $C_L$: Total node capacitive load
- $V_{DD}$: Supply voltage ($1.2\text{V} / 1.8\text{V}$)
- $f$: Clock / switching frequency

---

## 5. Verification & Simulation
Run the testbench in ModelSim:
```bash
vlib work
vlog cmos_full_adder_transistor_level.v cmos_rca_4bit.v tb_cmos_rca_4bit.v
vsim -c -do "run -all; quit" work.tb_cmos_rca_4bit
```
Expected output: All 512 test vectors pass with zero functional and carry-propagation errors.

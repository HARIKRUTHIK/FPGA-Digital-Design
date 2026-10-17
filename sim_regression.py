#!/usr/bin/env python3
"""
FPGA-Digital-Design Automated Regression Test Runner
Executes all Verilog testbenches using available simulation tools (iverilog / vsim).
"""

import os
import sys
import subprocess
import shutil

TESTBENCHES = [
    {
        "name": "Arithmetic Units Suite",
        "sources": ["01_arithmetic_units/*.v", "testbenches/tb_arithmetic_units.v"],
        "top": "tb_arithmetic_units"
    },
    {
        "name": "Sequential Multipliers",
        "sources": ["02_multipliers/*.v", "testbenches/tb_multipliers.v"],
        "top": "tb_multipliers"
    },
    {
        "name": "Finite State Machines",
        "sources": ["05_fsm/*.v", "testbenches/tb_fsm.v"],
        "top": "tb_fsm"
    },
    {
        "name": "Synchronous/Asynchronous FIFO",
        "sources": ["04_fifo/*.v", "testbenches/fifo_tb.v"],
        "top": "fifo_tb"
    },
    {
        "name": "FIR Digital Filter",
        "sources": ["06_dsp_fpga/fir_filters/*.v", "testbenches/fir_tb.v"],
        "top": "fir_tb"
    },
    {
        "name": "CMOS Transistor-Level 4-bit RCA",
        "sources": ["09_cmos_transistor_level_rca/rca_4bit_cmos.v", "09_cmos_transistor_level_rca/tb_rca_4bit_cmos.v"],
        "top": "tb_rca_4bit_cmos"
    }
]

def run_iverilog(repo_root):
    print("=" * 70)
    print("  RUNNING REGRESSION WITH ICARUS VERILOG (iverilog / vvp)")
    print("=" * 70)
    passed = 0
    failed = 0

    import glob
    for tb in TESTBENCHES:
        src_files = []
        for pattern in tb["sources"]:
            matched = glob.glob(os.path.join(repo_root, pattern))
            src_files.extend(matched)

        out_bin = os.path.join(repo_root, "sim.out")
        compile_cmd = ["iverilog", "-o", out_bin] + src_files
        comp_res = subprocess.run(compile_cmd, capture_output=True, text=True)
        if comp_res.returncode != 0:
            print(f"[FAIL] Compilation Error: {tb['name']}")
            print(comp_res.stderr)
            failed += 1
            continue

        sim_cmd = ["vvp", out_bin]
        sim_res = subprocess.run(sim_cmd, capture_output=True, text=True)
        if os.path.exists(out_bin):
            os.remove(out_bin)

        if sim_res.returncode == 0 and "ERROR" not in sim_res.stdout and "FAILED" not in sim_res.stdout:
            print(f"[PASS] {tb['name']}")
            passed += 1
        else:
            print(f"[FAIL] Simulation Mismatch: {tb['name']}")
            print(sim_res.stdout)
            failed += 1

    print("-" * 70)
    print(f"Summary: {passed} Passed, {failed} Failed out of {len(TESTBENCHES)} Suites")
    print("=" * 70)
    return failed == 0

def main():
    repo_root = os.path.dirname(os.path.abspath(__file__))
    if shutil.which("iverilog") and shutil.which("vvp"):
        success = run_iverilog(repo_root)
        sys.exit(0 if success else 1)
    elif shutil.which("vsim"):
        print("[INFO] ModelSim detected. Execute: vsim -c -do testbenches/run_all.do")
        sys.exit(0)
    else:
        print("[INFO] Neither iverilog nor vsim detected in PATH.")
        print("[INFO] Launch testbenches in ModelSim GUI via 'do testbenches/run_all.do'")
        sys.exit(0)

if __name__ == "__main__":
    main()

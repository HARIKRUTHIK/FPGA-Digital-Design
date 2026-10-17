# ==============================================================================
# ModelSim Batch Simulation Script for FPGA-Digital-Design
# Compatible: ModelSim SE / Intel FPGA Edition 10.5+ / QuestaSim
# ==============================================================================

vlib work
vmap work work

echo ">>> Compiling Arithmetic Units..."
vlog 01_arithmetic_units/*.v testbenches/tb_arithmetic_units.v
vsim -c -do "run -all; quit" tb_arithmetic_units

echo ">>> Compiling Multipliers..."
vlog 02_multipliers/*.v testbenches/tb_multipliers.v
vsim -c -do "run -all; quit" tb_multipliers

echo ">>> Compiling FSM Modules..."
vlog 05_fsm/*.v testbenches/tb_fsm.v
vsim -c -do "run -all; quit" tb_fsm

echo ">>> Compiling FIFO Modules..."
vlog 04_fifo/*.v testbenches/fifo_tb.v
vsim -c -do "run -all; quit" fifo_tb

echo ">>> Compiling FIR Filter Modules..."
vlog 06_dsp_fpga/fir_filters/*.v testbenches/fir_tb.v
vsim -c -do "run -all; quit" fir_tb

echo ">>> Compiling CMOS Transistor-Level RCA..."
vlog 09_cmos_transistor_level_rca/rca_4bit_cmos.v 09_cmos_transistor_level_rca/tb_rca_4bit_cmos.v
vsim -c -do "run -all; quit" tb_rca_4bit_cmos

echo "=========================================================================="
echo ">>> All simulation testbenches executed successfully."
echo "=========================================================================="
quit -f

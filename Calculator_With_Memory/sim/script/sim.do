vlib work
vcom -93 -work work ../../src/Bin2SSD.vhd
vcom -93 -work work ../../src/components.vhd
vcom -93 -work work ../../src/double_dabble.vhd
vcom -93 -work work ../../src/FSM_Calc.vhd
vcom -93 -work work ../../src/generic_ALU.vhd
vcom -93 -work work ../../src/generic_rising_edge.vhd
vcom -93 -work work ../../src/generic_synchronizer.vhd
vcom -93 -work work ../../src/memory.vhd
vcom -93 -work work ../../src/Eight_Bit_Calc_Top.vhd
vcom -93 -work work ../src/Mem_Calc_tb.vhd
vsim -novopt Mem_Calc_tb
do wave.do
run 237313019 ns

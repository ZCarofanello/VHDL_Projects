# Dr. Kaputa
# Quartus II compile script for DE1-SoC  board

# 1] name your project here
set project_name "8_Bit_Calculator"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE EP2C35F672C6
set_global_assignment -name TOP_LEVEL_ENTITY Eight_Bit_Calc_Top
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/Bin2SSD.vhd
set_global_assignment -name VHDL_FILE ../../src/components.vhd
set_global_assignment -name VHDL_FILE ../../src/double_dabble.vhd
set_global_assignment -name VHDL_FILE ../../src/FSM_Calc.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_ALU.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_rising_edge.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/memory.vhd
set_global_assignment -name VHDL_FILE ../../src/Eight_Bit_Calc_Top.vhd


set_location_assignment PIN_W26  -to reset
set_location_assignment PIN_N2 -to clk

set_location_assignment PIN_N25  -to Input[0]
set_location_assignment PIN_N26  -to Input[1]
set_location_assignment PIN_P25  -to Input[2]
set_location_assignment PIN_AE14 -to Input[3]
set_location_assignment PIN_AF14 -to Input[4]
set_location_assignment PIN_AD13 -to Input[5]
set_location_assignment PIN_AC13 -to Input[6]
set_location_assignment PIN_C13  -to Input[7]

set_location_assignment PIN_B13  -to Operation[0]
set_location_assignment PIN_A13  -to Operation[1]

set_location_assignment PIN_G26  -to execute_n
set_location_assignment PIN_N23  -to ms_n
set_location_assignment PIN_P23  -to mr_n

set_location_assignment PIN_AE23 -to Dat_State[0]
set_location_assignment PIN_AF23 -to Dat_State[1]
set_location_assignment PIN_AB21 -to Dat_State[2]
set_location_assignment PIN_AC22 -to Dat_State[3]

set_location_assignment PIN_Y23  -to Thousands_Display[0]
set_location_assignment PIN_AA25   -to Thousands_Display[1]
set_location_assignment PIN_AA26  -to Thousands_Display[2]
set_location_assignment PIN_Y26  -to Thousands_Display[3]
set_location_assignment PIN_Y25  -to Thousands_Display[4]
set_location_assignment PIN_U22  -to Thousands_Display[5]
set_location_assignment PIN_W24   -to Thousands_Display[6]

set_location_assignment PIN_AB23  -to Hundreds_Display[0]
set_location_assignment PIN_V22   -to Hundreds_Display[1]
set_location_assignment PIN_AC25  -to Hundreds_Display[2]
set_location_assignment PIN_AC26  -to Hundreds_Display[3]
set_location_assignment PIN_AB26  -to Hundreds_Display[4]
set_location_assignment PIN_AB25  -to Hundreds_Display[5]
set_location_assignment PIN_Y24   -to Hundreds_Display[6]

set_location_assignment PIN_V20  -to Tens_Display[0]
set_location_assignment PIN_V21  -to Tens_Display[1]
set_location_assignment PIN_W21  -to Tens_Display[2]
set_location_assignment PIN_Y22  -to Tens_Display[3]
set_location_assignment PIN_AA24 -to Tens_Display[4]
set_location_assignment PIN_AA23 -to Tens_Display[5]
set_location_assignment PIN_AB24 -to Tens_Display[6]

set_location_assignment PIN_AF10 -to Ones_Display[0]
set_location_assignment PIN_AB12 -to Ones_Display[1]
set_location_assignment PIN_AC12 -to Ones_Display[2]
set_location_assignment PIN_AD11 -to Ones_Display[3]
set_location_assignment PIN_AE11 -to Ones_Display[4]
set_location_assignment PIN_V14  -to Ones_Display[5]
set_location_assignment PIN_V13  -to Ones_Display[6]

execute_flow -compile
project_close
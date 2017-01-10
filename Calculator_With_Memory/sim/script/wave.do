onerror {resume}
radix define radix_ssd {
    "7'b1000000" "0" -color "yellow",
    "7'b1111001" "1" -color "yellow",
    "7'b0100100" "2" -color "yellow",
    "7'b0110000" "3" -color "yellow",
    "7'b0011001" "4" -color "yellow",
    "7'b0010010" "5" -color "yellow",
    "7'b0000010" "6" -color "yellow",
    "7'b1111000" "7" -color "yellow",
    "7'b0000000" "8" -color "yellow",
    "7'b0010000" "9" -color "yellow",
    "7'b0001000" "A" -color "yellow",
    "7'b0000011" "B" -color "yellow",
    "7'b1000110" "C" -color "yellow",
    "7'b0100001" "D" -color "yellow",
    "7'b0000110" "E" -color "yellow",
    "7'b0001110" "F" -color "yellow",
    "7'b0111111" "dash" -color "yellow",
    "7'b1111111" "blank" -color "yellow",
    -default hexadecimal
}
radix define radix_fsm {
    "4'b0000" "reset" -color "blue",
    "4'b0001" "ready" -color "blue",
    "4'b0010" "save_to_mem" -color "blue",
    "4'b0100" "recall_from_mem" -color "blue",
    "4'b1000" "execute" -color "blue",
    -default hexadecimal
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mem_calc_tb/uut/clk
add wave -noupdate /mem_calc_tb/uut/reset_n
add wave -noupdate -radix unsigned -radixshowbase 0 /mem_calc_tb/uut/Input
add wave -noupdate -radix binary -radixshowbase 0 /mem_calc_tb/uut/Operation
add wave -noupdate /mem_calc_tb/uut/execute_n
add wave -noupdate /mem_calc_tb/uut/ms_n
add wave -noupdate /mem_calc_tb/uut/mr_n
add wave -noupdate -radix radix_fsm -radixshowbase 0 /mem_calc_tb/uut/Dat_State
add wave -noupdate -radix radix_ssd /mem_calc_tb/uut/Thousands_Display
add wave -noupdate -radix radix_ssd /mem_calc_tb/uut/Hundreds_Display
add wave -noupdate -radix radix_ssd /mem_calc_tb/uut/Tens_Display
add wave -noupdate -radix radix_ssd /mem_calc_tb/uut/Ones_Display
add wave -noupdate -divider {Internal Signals}
add wave -noupdate -radix unsigned /mem_calc_tb/uut/thousands_bcd
add wave -noupdate -radix unsigned /mem_calc_tb/uut/hundreds_bcd
add wave -noupdate -radix unsigned /mem_calc_tb/uut/tens_bcd
add wave -noupdate -radix unsigned /mem_calc_tb/uut/ones_bcd
add wave -noupdate -radix unsigned /mem_calc_tb/uut/data_from_ram
add wave -noupdate -divider Components
add wave -noupdate -group FSM /mem_calc_tb/uut/ZeBrains/clk
add wave -noupdate -group FSM /mem_calc_tb/uut/ZeBrains/reset_n
add wave -noupdate -group FSM /mem_calc_tb/uut/ZeBrains/execute_n
add wave -noupdate -group FSM /mem_calc_tb/uut/ZeBrains/ms_n
add wave -noupdate -group FSM /mem_calc_tb/uut/ZeBrains/mr_n
add wave -noupdate -group FSM -radix radix_fsm /mem_calc_tb/uut/ZeBrains/The_Current_State
add wave -noupdate -group FSM /mem_calc_tb/uut/ZeBrains/Dat_Sel
add wave -noupdate -group FSM /mem_calc_tb/uut/ZeBrains/Mem_Addr
add wave -noupdate -group FSM /mem_calc_tb/uut/ZeBrains/Mem_we
add wave -noupdate -group FSM -radix radix_fsm /mem_calc_tb/uut/ZeBrains/CurrentState
add wave -noupdate -group FSM -radix radix_fsm /mem_calc_tb/uut/ZeBrains/NextState
add wave -noupdate -group ALU -radix unsigned /mem_calc_tb/uut/The_ALU/a
add wave -noupdate -group ALU -radix unsigned /mem_calc_tb/uut/The_ALU/b
add wave -noupdate -group ALU /mem_calc_tb/uut/The_ALU/Operation
add wave -noupdate -group ALU -radix unsigned /mem_calc_tb/uut/The_ALU/c
add wave -noupdate -group ALU -radix unsigned /mem_calc_tb/uut/The_ALU/temp
add wave -noupdate -group ALU -radix unsigned /mem_calc_tb/uut/The_ALU/PaddingBits
add wave -noupdate -group MEM /mem_calc_tb/uut/Calc_Memory/clk
add wave -noupdate -group MEM /mem_calc_tb/uut/Calc_Memory/we
add wave -noupdate -group MEM /mem_calc_tb/uut/Calc_Memory/addr
add wave -noupdate -group MEM -radix unsigned /mem_calc_tb/uut/Calc_Memory/din
add wave -noupdate -group MEM -radix unsigned /mem_calc_tb/uut/Calc_Memory/dout
add wave -noupdate -group MEM -radix unsigned -childformat {{/mem_calc_tb/uut/Calc_Memory/RAM(3) -radix unsigned} {/mem_calc_tb/uut/Calc_Memory/RAM(2) -radix unsigned} {/mem_calc_tb/uut/Calc_Memory/RAM(1) -radix unsigned} {/mem_calc_tb/uut/Calc_Memory/RAM(0) -radix unsigned}} -subitemconfig {/mem_calc_tb/uut/Calc_Memory/RAM(3) {-height 15 -radix unsigned} /mem_calc_tb/uut/Calc_Memory/RAM(2) {-height 15 -radix unsigned} /mem_calc_tb/uut/Calc_Memory/RAM(1) {-height 15 -radix unsigned} /mem_calc_tb/uut/Calc_Memory/RAM(0) {-height 15 -radix unsigned}} /mem_calc_tb/uut/Calc_Memory/RAM
add wave -noupdate -group DD /mem_calc_tb/uut/Double_Dabblin/Data_In
add wave -noupdate -group DD /mem_calc_tb/uut/Double_Dabblin/ones
add wave -noupdate -group DD /mem_calc_tb/uut/Double_Dabblin/tens
add wave -noupdate -group DD /mem_calc_tb/uut/Double_Dabblin/hundreds
add wave -noupdate -group DD /mem_calc_tb/uut/Double_Dabblin/thousands
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13591449420 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 193
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {13590760991 ps} {13592338895 ps}

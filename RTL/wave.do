onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ALU_TOP_tb/A_tb
add wave -noupdate /ALU_TOP_tb/B_tb
add wave -noupdate /ALU_TOP_tb/ALU_FUN
add wave -noupdate /ALU_TOP_tb/CLK
add wave -noupdate /ALU_TOP_tb/RST
add wave -noupdate /ALU_TOP_tb/Arith_OUT_tb
add wave -noupdate /ALU_TOP_tb/Arith_Flag
add wave -noupdate /ALU_TOP_tb/Logic_OUT_tb
add wave -noupdate /ALU_TOP_tb/Logic_Flag
add wave -noupdate /ALU_TOP_tb/CMP_OUT_tb
add wave -noupdate /ALU_TOP_tb/CMP_Flag
add wave -noupdate /ALU_TOP_tb/SHIFT_OUT_tb
add wave -noupdate /ALU_TOP_tb/SHIFT_Flag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 192
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {304500 ns}

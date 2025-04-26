transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/register_file.v}
vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/PC.v}
vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/mux.v}
vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/imm_generator.v}
vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/data_memory.v}
vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/core.v}
vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/control_unit.v}
vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/alu_control_unit.v}
vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/alu.v}
vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/adder.v}
vlog -vlog01compat -work work +incdir+D:/Single_Cycle_RV32I_Core {D:/Single_Cycle_RV32I_Core/instruction_memory.v}


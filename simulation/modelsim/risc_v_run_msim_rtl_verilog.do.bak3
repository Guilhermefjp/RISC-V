transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Guilherme/Desktop/UFJF/Dispositivos\ LÃ³gicos\ ProgramÃ¡veis/RISC_V {C:/Users/Guilherme/Desktop/UFJF/Dispositivos Lógicos Programáveis/RISC_V/ProgramCounter.v}

vlog -vlog01compat -work work +incdir+C:/Users/Guilherme/Desktop/UFJF/Dispositivos\ LÃ³gicos\ ProgramÃ¡veis/RISC_V {C:/Users/Guilherme/Desktop/UFJF/Dispositivos Lógicos Programáveis/RISC_V/programcounter_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  programcounter_tb

add wave *
view structure
view signals
run 1 us


# NC-Sim Command File
# TOOL:	ncsim(64)	15.20-s086
#
#
# You can restore this configuration with:
#
#      irun -access +rwc -f filelist.f +cntr_roll_over_test -s -input /home/Is240809/Ishraq_work/binary_counter/cntr_verification/sim/waves.tcl
#

set tcl_prompt1 {puts -nonewline "ncsim> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
alias . run
alias iprof profile
alias quit exit
database -open -shm -into waves.shm waves -default
probe -create -database waves counter_tb_top.counter.CLK counter_tb_top.inf.A_count counter_tb_top.inf.C_out counter_tb_top.inf.clk counter_tb_top.inf.count counter_tb_top.inf.data_in counter_tb_top.inf.enable counter_tb_top.inf.load counter_tb_top.inf.reset
probe -create -database waves counter_tb_top.counter.A_count counter_tb_top.counter.C_out counter_tb_top.counter.Count counter_tb_top.counter.Data_in counter_tb_top.counter.Enable counter_tb_top.counter.Load counter_tb_top.counter.reset counter_tb_top.counter.tmp

simvision -input waves.tcl.svcf

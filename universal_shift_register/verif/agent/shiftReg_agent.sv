class shiftReg_agent;

	shiftReg_generator generator;
	shiftReg_driver driver;
	shiftReg_coverage coverage;
	shiftReg_monitor monitor;
	function new(string name, virtual interf intf);
		$display("%s is created", name);
		generator = new("generator");
		coverage = new("coverage");
		driver = new("driver", intf);
		monitor = new("monitor", intf);

		generator.gen_mb = driver.drv_mb;
		sm();
        monitor.mon2covgrp_mb = coverage.covgrp_mb;
        sm2();
	endfunction

	task sm();
		generator.sm = driver.sm;
	endtask
    
    task sm2();
		monitor.m2c = coverage.c2m;
	endtask

endclass

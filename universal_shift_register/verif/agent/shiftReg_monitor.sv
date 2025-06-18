class shiftReg_monitor;

	mailbox mon_mb;
    mailbox mon2covgrp_mb;
	transaction trans;
	virtual interf intf;
    event monitor_e1;
    semaphore m2c = new();

	function new(string name, virtual interf intf);
		$display("%s is created", name);
		mon_mb = new();
        mon2covgrp_mb = new();
		this.intf = intf;
		fork 
			capture();
		join_none
	endfunction


    task capture();
        forever begin
            @(posedge intf.clk);
            trans = new();
            //trans.A_par = intf.A_par;
            trans.I_par = intf.I_par;
            trans.reset = intf.reset;
            trans.s0 = intf.s0;
            trans.s1 = intf.s1;
            trans.MSB_in = intf.MSB_in;
            trans.LSB_in = intf.LSB_in;
            //$display("%0p", trans);
			//mon_mb.put(trans);
            
            @(negedge intf.clk);
            //trans = new();
            trans.A_par = intf.A_par;
          /*  trans.I_par = intf.I_par;
            trans.reset = intf.reset;
            trans.s0 = intf.s0;
            trans.s1 = intf.s1;
            trans.MSB_in = intf.MSB_in;
            trans.LSB_in = intf.LSB_in;*/
            //$display("%0p", trans);
			mon_mb.put(trans);
            mon2covgrp_mb.put(trans);
            //$display("input: %0b, output: %0b", trans.I_par, trans.A_par);
            wait(monitor_e1.triggered);
            
            if($test$plusargs("covmode")) begin
                m2c.get(1);   
            end
		end
	endtask


/*	task capture();
		forever begin
			@(negedge intf.clk);
			if(intf.reset == 1'b0)
				begin
					trans = new();
					trans.A_par = intf.A_par;
					trans.I_par = intf.I_par;
					trans.reset = intf.reset;
					trans.s0 = intf.s0;
					trans.s1 = intf.s1;
					trans.MSB_in = intf.MSB_in;
					trans.LSB_in = intf.LSB_in;
					$display("reset :: %0p", trans);
					mon_mb.put(trans);
				end
			else if(intf.reset == 1'b1 & intf.s0 == 1'b1 & intf.s1 == 1'b1)
				begin
					trans = new();
					trans.A_par = intf.A_par;
					trans.I_par = intf.I_par;
					trans.reset = intf.reset;
					trans.s0 = intf.s0;
					trans.s1 = intf.s1;
					trans.MSB_in = intf.MSB_in;
					trans.LSB_in = intf.LSB_in;
					$display("set_data :: %0p", trans);
					mon_mb.put(trans);
				end
			else if(intf.reset == 1'b1 & intf.s0 == 1'b0 & intf.s1 == 1'b1)
				begin
					trans = new();
					trans.A_par = intf.A_par;
					trans.I_par = intf.I_par;
					trans.reset = intf.reset;
					trans.s0 = intf.s0;
					trans.s1 = intf.s1;
					trans.MSB_in = intf.MSB_in;
					trans.LSB_in = intf.LSB_in;
					$display("left_shift :: %0p", trans);
					mon_mb.put(trans);
				end
			else if(intf.reset == 1'b1 & intf.s0 == 1'b1 & intf.s1 == 1'b0)
				begin
					trans = new();
					trans.A_par = intf.A_par;
					trans.I_par = intf.I_par;
					trans.reset = intf.reset;
					trans.s0 = intf.s0;
					trans.s1 = intf.s1;
					trans.MSB_in = intf.MSB_in;
					trans.LSB_in = intf.LSB_in;
					$display("right_shift :: %0p", trans);
					mon_mb.put(trans);
				end
			else if(intf.reset == 1'b1 & intf.s0 == 1'b0 & intf.s1 == 1'b0)
				begin
					trans = new();
					trans.A_par = intf.A_par;
					trans.I_par = intf.I_par;
					trans.reset = intf.reset;
					trans.s0 = intf.s0;
					trans.s1 = intf.s1;
					trans.MSB_in = intf.MSB_in;
					trans.LSB_in = intf.LSB_in;
					$display("hold :: %0p", trans);
					mon_mb.put(trans);
				end
		end
	endtask  */

endclass

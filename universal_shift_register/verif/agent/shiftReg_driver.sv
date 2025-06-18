class shiftReg_driver;
	virtual interf intf;

	mailbox drv_mb;
	transaction trans;
	semaphore sm = new();

	function new(string name, virtual interf intf);
		$display("%s is created", name);
		this.intf = intf;
		drv_mb = new();
		fork		
			drive();
		join_none
	endfunction

	task drive();	
		forever begin
			drv_mb.get(trans);
  
			//$display("from driver, mailbox received");
			//$display("%0b, %0b, %0b, %0b, %0b, %0b", trans.reset, trans.s0, trans.s1, trans.MSB_in, trans.LSB_in, trans.I_par);
				if(trans.reset == 1'b0) begin
				    reset();	
				end
				else if(trans.s1 == 1'b1 & trans.s0 == 1'b1) begin
					set_data();
				end 
				else if(trans.s1 == 1'b1 & trans.s0 == 1'b0) begin
					left_shift();
				end
				else if(trans.s1 == 1'b0 & trans.s0 == 1'b1) begin
					right_shift();
				end
				else if(trans.s1 == 1'b0 & trans.s0 == 1'b0) begin
					hold();
				end
			//$display("from driver, driver task fin");
			sm.put(1);
		end
		
	endtask

	task reset();
		//drv_mb.get(trans);
		//@(negedge intf.clk);
		//#2;
		intf.reset <= trans.reset;
		intf.s0 <= trans.s0;
		intf.s1 <= trans.s1;
		intf.MSB_in <= trans.MSB_in;
		intf.LSB_in <= trans.LSB_in;
		intf.I_par <= trans.I_par;
		repeat(trans.num)@(negedge intf.clk);
		intf.reset <= 1'b1;
		@(negedge intf.clk);
		
	endtask

	task set_data();
		//drv_mb.get(trans);
		//@(negedge intf.clk);
		intf.reset <= trans.reset;
		intf.s0 <= trans.s0;
		intf.s1 <= trans.s1;
		intf.MSB_in <= trans.MSB_in;
		intf.LSB_in <= trans.LSB_in;
		intf.I_par <= trans.I_par;
		@(negedge intf.clk);
	endtask

	task left_shift();
        repeat(trans.num) begin		
        //drv_mb.get(trans);
		//set_data();
		//drv_mb.get(trans);
		intf.s0 <= trans.s0;
		intf.s1 <= trans.s1;
		intf.MSB_in <= trans.MSB_in;
		intf.LSB_in <= trans.LSB_in;
		//intf.I_par <= trans.I_par;
		//repeat(4)@(negedge intf.clk);
		@(negedge intf.clk);
        end
	endtask

	task right_shift();
        repeat(trans.num) begin	
		//set_data(ipar);
		intf.s0 <= trans.s0;
		intf.s1 <= trans.s1;
		intf.MSB_in <= trans.MSB_in;
        //$display("MSB from driver = %0b", trans.MSB_in);
		intf.LSB_in <= trans.LSB_in;
		//intf.I_par <= ipar;
		//repeat(4)@(negedge intf.clk);
		@(negedge intf.clk);
        end
	endtask

	task hold();
        repeat(trans.num) begin	
		//drv_mb.get(trans);
		//set_data();
		//drv_mb.get(trans);
		//intf.s0 <= 1'b0;
		//intf.s1 <= 1'b1;;
		//intf.MSB_in <= 1'b0;
		//intf.LSB_in <= trans.LSB_in;
		//intf.I_par <= trans.I_par;
		//repeat(2)@(negedge intf.clk);
		intf.s0 <= trans.s0;
		intf.s1 <= trans.s1;
		//repeat(2)@(negedge intf.clk);
		//intf.s0 <= 1'b0;
		//intf.s1 <= 1'b1;
		@(negedge intf.clk);
        end
	endtask

endclass

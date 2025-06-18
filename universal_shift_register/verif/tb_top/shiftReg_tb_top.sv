


module tb_top;

	bit clk =0;
	interf intf(clk);

    reset_test test_reset;
    data_load_test test_set;
    left_shift_test test_lshift;
    right_shift_test test_rshift;
    hold_test test_hold;
    //MSB_check test_MSB;
    //LSB_check test_LSB;
	random_test test;

    int delay = 10;
    string test_name;

	initial begin
		if($value$plusargs("delay=%0d", delay))
			begin
				$display("delay is %0d", delay);
			end
		else
			begin
				$display("delay not set");
			end
	end

	Universal_Shift_Register DUT (
		.clk(clk),
		.reset(intf.reset),
		.A_par(intf.A_par),
		.I_par(intf.I_par),
		.MSB_in(intf.MSB_in),
		.LSB_in(intf.LSB_in),
		.s0(intf.s0),
		.s1(intf.s1)
		);

	always begin
		#delay clk = ~clk;
		//#10 clk = ~clk;
	end

	initial begin

		$display("1 cycle = %0d ns", delay*2); 

		//test = new("test", intf);
        //test.run_test();
        
        //intf.reset = 1'b1;
        //#100;        
    
        if($test$plusargs("reset_test"))
			begin
				$display("reset test is called.");
                test_reset = new("test", intf);
                test_reset.run_test();
			end
		else if($test$plusargs("data_load_test"))
			begin
				$display("data load test is called");
                test_set = new("test", intf);
                test_set.run_test();
			end
        else if($test$plusargs("left_shift_test"))
			begin
				$display("left shift test is called");
                test_lshift = new("test", intf);
                test_lshift.run_test();
			end
        else if($test$plusargs("right_shift_test"))
			begin
				$display("right shift test is called");
                test_rshift = new("test", intf);
                test_rshift.run_test();
			end
        else if($test$plusargs("hold_test"))
			begin
				$display("hold test is called");
                test_hold = new("test", intf);
                test_hold.run_test();
			end  
        else if($test$plusargs("random_test"))
			begin
				$display("random test is called");
                test = new("test", intf);
                test.run_test();
			end
    
        /*else
            begin
                int a = $random%6;
                $display("a = %0d", a);
                if(a == 0) begin
                    $display("reset test is called.");
                    test_reset = new("test", intf);
                    test_reset.run_test();
			    end
                else if(a == 1)
			        begin
				        $display("data load test is called");
                        test_set = new("test", intf);
                        test_set.run_test();
			        end
                else if(a == 2)
			        begin
				        $display("left shift test is called");
                        test_lshift = new("test", intf);
                        test_lshift.run_test();
			        end
                else if(a == 3)
			        begin
				        $display("right shift test is called");
                        test_rshift = new("test", intf);
                        test_rshift.run_test();
			        end
                else if(a == 4)
			        begin
				        $display("hold test is called");
                        test_hold = new("test", intf);
                        test_hold.run_test();
			        end
                else if(a == 5)
			        begin
				        $display("random test is called");
                        test = new("test", intf);
                        test.run_test();
			        end
            end */

		$finish;

	end

endmodule


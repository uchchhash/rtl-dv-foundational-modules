class LSB_check extends baseTest;

    //mailbox check;

    function new(string name, virtual interf intf);
        super.new(name, intf);
		$display("%s is created from data_load_test", name);
        //check = new();
		//check = env.scb.check;
	endfunction
    
    task run_test();
        //bit chk = 1'b1;
        //check.put(chk);
        env.agent.generator.reset(2, 0);
        
        for (int i = 0; i < 17; i++)
            begin
                env.agent.generator.set_data(i, 0);
                env.agent.generator.left_shift(1'b0, 2, 0);
                //env.agent.generator.hold(1);
                //env.agent.generator.left_shift(1'b0, 1);
            //env.agent.generator.hold(2);
            end
          env.scb.result();
          env.agent.coverage.display_coverage();
    endtask

endclass

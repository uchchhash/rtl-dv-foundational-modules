class baseTest;

	environment env;
	function new(string name, virtual interf intf);
		$display("%s is created", name);
		env = new("env", intf);
	endfunction
/*
	task run_test();
		
		env.agent.generator.reset(2);

		//env.agent.generator.set_data(4'b0001, 0);

		//env.agent.generator.left_shift(1'b1, 1);
		
		//env.agent.generator.hold(2);

		//env.agent.generator.left_shift(1'b1, 1);

		//env.agent.generator.hold(2);

        for(int i = 0; i<16; i++) begin
           // env.agent.generator.reset(2);
            env.agent.generator.set_data(i, 0);
            env.agent.generator.left_shift(1'b0, 2);
            env.agent.generator.hold(1);
            env.agent.generator.left_shift(1'b0, 1);
            //env.agent.generator.hold(2);
            //$display("\n");
        end 

		#10 $finish; 
	endtask
*/
endclass

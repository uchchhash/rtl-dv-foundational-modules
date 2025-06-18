class left_shift_test extends baseTest;

    function new(string name, virtual interf intf);
        super.new(name, intf);
		$display("%s is created from data_load_test", name);
		
	endfunction
    
    task run_test();
        env.agent.generator.reset(2, 0);
        for (int i = 0; i < 17; i++)begin
            env.agent.generator.set_data(i, 0);
            env.agent.generator.hold(1, 0);
            env.agent.generator.left_shift(1'b1, 4, 0);
        end

        for (int i = 0; i < 17; i++) begin
            env.agent.generator.set_data(i, 0);
            env.agent.generator.hold(1, 0);
            env.agent.generator.left_shift(1'b0, 4, 0);
        end
        env.scb.result();
        env.agent.coverage.display_coverage();
    endtask

endclass

class random_test extends baseTest;

    function new(string name, virtual interf intf);
        super.new(name, intf);
		$display("%s is created from data_load_test", name);
		
	endfunction
    
    task run_test();
        //env.agent.generator.reset(2);
        repeat(5) begin
            randsequence (test)
                test : rand join A B C D E;

                    A : {env.agent.generator.reset(2, 1); };
                    B : {env.agent.generator.set_data(4'b0101, 1); };
                    C : {env.agent.generator.left_shift(1'b1, 2, 1); };
                    D : {env.agent.generator.right_shift(1'b1, 2, 1); };
                    E : {env.agent.generator.hold(2, 1); };
            endsequence
        end
         env.scb.result();
         env.agent.coverage.display_coverage();
    endtask

endclass

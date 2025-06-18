class reset_test extends baseTest;
    
   // baseTest test;

    function new(string name, virtual interf intf);
        super.new(name, intf);
		$display("%s is created from reset_test", name);
	endfunction
    
    task run_test();
        env.agent.generator.reset(4, 0);
        //$display("%0d", num);
        //#10 $finish;
         env.scb.result();
         env.agent.coverage.display_coverage();
    endtask

endclass

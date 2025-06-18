class environment;

	shiftReg_agent agent;
	shiftReg_scoreboard scb;
	function new(string name, virtual interf intf);
		$display("%s is created", name);
		agent = new("agent", intf);
		scb = new("scb");
		
		agent.monitor.mon_mb = scb.scb_mb;
        agent.monitor.monitor_e1 = scb.scb_e1;
	endfunction

endclass

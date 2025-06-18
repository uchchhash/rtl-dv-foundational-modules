class shiftReg_generator;

	mailbox gen_mb;
	transaction trans;
	semaphore sm = new();

	function new(string name);
		$display("%s is created", name);
		gen_mb = new();
	endfunction

	task reset(logic[3:0] num, logic random);
		//$display("from generator, reset task is called");
        trans = new();
		trans.reset = 1'b0;
		trans.MSB_in = 1'b0;
		trans.LSB_in = 1'b0;
		trans.s0 = 1'b0;
		trans.s1 = 1'b0;
		trans.I_par = 4'b0000;
        if(!random) begin
		    trans.num = num;
        end
        else begin
            trans.randomize();
        end 
		gen_mb.put(trans);
		//$display("from generator, mailbox sent");
		sm.get(1);
	endtask

	task set_data(logic[3:0] I_par, logic random);
		//$display("from generator, set data task is called");
		trans = new();
		trans.reset = 1'b1;
		//trans.MSB_in = 1'b0;
		//trans.LSB_in = 1'b0;
		trans.s0 = 1'b1;
		trans.s1 = 1'b1;
		if(!random) begin
			trans.I_par = I_par;
            trans.MSB_in = 1'b0;
		    trans.LSB_in = 1'b0;
		end
		else begin
			trans.randomize();
		end
		gen_mb.put(trans);
		//$display("from generator, mailbox sent");
		sm.get(1);
	endtask

	task left_shift(logic LSB_in, logic[3:0] num, logic random);
		//repeat(num) begin
			//set_data(I_par);
			trans = new();
			trans.reset = 1'b1;
			//trans.MSB_in = 1'b0;
			//trans.LSB_in = LSB_in;
			trans.s0 = 1'b0;
			trans.s1 = 1'b1;
			//trans.I_par = I_par;
			//trans.num = num;
            if(!random) begin
                trans.MSB_in = 1'b0;
		        trans.LSB_in = LSB_in;
                trans.num = num;
		    end
		    else begin
			    trans.randomize();
		    end 
			gen_mb.put(trans);
			sm.get(1);
            //$display("%0t esheche", $time);
		//end
	endtask

	task right_shift(logic MSB_in, logic[3:0] num, logic random);
		//repeat(num) begin
			//set_data(I_par);
			trans = new();
			trans.reset = 1'b1;
            //$display("MSB from gen = %0b", MSB_in);
			//trans.MSB_in = MSB_in;
			//trans.LSB_in = 1'b1;
			trans.s0 = 1'b1;
			trans.s1 = 1'b0;
			//trans.I_par = I_par;
			//trans.num = num;
            if(!random) begin
                trans.MSB_in = MSB_in;
		        trans.LSB_in = 1'b0;
                trans.num = num;
		    end
		    else begin
			    trans.randomize();
		    end  
			gen_mb.put(trans);
			sm.get(1);
		//end
	endtask

	task hold(logic[3:0] num, logic random);
		//repeat(num) begin
			//set_data(I_par);
			trans = new();
			trans.reset = 1'b1;
			//trans.MSB_in = 1'b0;
			//trans.LSB_in = LSB_in;
			trans.s0 = 1'b0;
			trans.s1 = 1'b0;
			//trans.I_par = I_par;
            if(!random) begin
                trans.num = num;
            end
            else begin
                trans.randomize();
            end
			gen_mb.put(trans);
			//trans.num = num; 
			sm.get(1);
		//end
	endtask

endclass

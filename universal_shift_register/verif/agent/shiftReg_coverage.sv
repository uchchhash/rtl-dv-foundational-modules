class shiftReg_coverage;
        
    mailbox covgrp_mb;
    transaction trans;
    semaphore c2m = new();

    covergroup cover_func;
        reset : coverpoint trans.reset {bins reset0 = {0};//, 1};}
                                    bins reset1 = {1};}

        sel0 : coverpoint trans.s0 {bins s0_0 = {0};//, 1};}
                                    bins s0_1 = {1};}

        sel1 : coverpoint trans.s1 {bins s1_0 = {0};//, 1};}
                                    bins s1_1 = {1};}

        MSB : coverpoint trans.MSB_in {bins MSB_0 = {0};//, 1};}
                                     bins MSB_1 = {1};}

        LSB : coverpoint trans.LSB_in {bins LSB_0 = {0};//, 1};}
                                    bins LSB_1 = {1};}

        in : coverpoint trans.I_par {bins I_par_bin[] = {[0:$]};}
        out : coverpoint trans.A_par {bins A_par_bin[] = {[0:$]};}

        //cross1 : cross cp2.b0, cp3.b0, cp7;
        //{ignore_bins b = binsof(cp2.b1);
                                      //ignore_bins c = binsof(cp3.b1);}
        //cross2 : cross cp2, cp3, cp4, cp5, cp7 {bins b = binsof(cp2.b1) && binsof(cp3.b0) && binsof(cp4);
          //                                      bins c = binsof(cp2.b0) && binsof(cp3.b1) && binsof(cp5);
            //                                    bins d = binsof(cp2.b0) && binsof(cp3.b0) && binsof(cp7);}
        //cross3 : cross cp2, cp3, cp5 {bins b = binsof(cp2.b0) && binsof(cp3.b1) && binsof(cp5);}
        
        crossRS : cross  sel0, sel1, MSB {ignore_bins b = binsof( sel0.s0_0);        // cross for right shift functionality
                                            ignore_bins c = binsof(sel1.s1_1);}
        crossLS : cross  sel0, sel1, LSB {ignore_bins b = binsof( sel0.s0_1);        //cross for left shift functionality
                                            ignore_bins c = binsof(sel1.s1_0);}
        //cross0 : cross cp1, cp7 {bins b = binsof(cp1.b0);}  
        crossHold : cross  sel0, sel1, out {bins b = binsof( sel0.s0_0) && binsof(sel1.s1_0) && binsof(out) intersect {[0:15]};}

        //crossSel : cross  sel0, sel1;                                                                                  //cross of selection pins
        crossSET : cross sel0, sel1, in, out {bins b = binsof(in) intersect {[0:15]} && binsof(out) intersect {[0:15]};
                                              ignore_bins c = binsof( sel0.s0_0);        // cross for right shift functionality
                                              ignore_bins d = binsof(sel1.s1_0);}
             
    endgroup

    //cover_func cov_func;
    
	function new(string name);
		$display("%s is created", name);
        covgrp_mb = new();
        cover_func = new();
        fork
            coverage();
        join_none        
	endfunction

    task coverage();
        if($test$plusargs("covmode")) begin
            forever begin
                covgrp_mb.get(trans);
                //this.trans = trans;
                cover_func.sample();
                //$display("coverage = %0f", $get_coverage()); 
                c2m.put(1);
            end
        end
    endtask

    task display_coverage();
        if($test$plusargs("covmode")) begin
            $display("coverage = %0f", $get_coverage());   
        end
    endtask



endclass

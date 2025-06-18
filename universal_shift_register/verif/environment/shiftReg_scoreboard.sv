class shiftReg_scoreboard;

    mailbox scb_mb;
    transaction trans;
    event scb_e1;
    logic[3:0] a;

    int result_p, result_f; 

    function new(string name);
        $display("%s is created", name);
        scb_mb = new();
        fork
            score();
        join_none
    endfunction


    task score();
        forever begin
            scb_mb.get(trans);

            if (trans.reset == 1'b0)
                begin
                    //a = trans.I_par;
                    a = 0;
                    if(trans.A_par == 4'b0000)begin
                        $display("PASS reset");
                        result_p++ ;
                    end
                    else begin
                        $display("FAIL reset");
                        result_f++ ;
                    end
                end

            else if (trans.reset == 1'b1 & trans.s0 == 1'b1 & trans.s1 ==1'b1)
                begin
                    a = trans.I_par;
                    if(trans.A_par == trans.I_par)
                        begin
                            $display("PASS set :: I_par = %0b :: A_par = %0b", trans.I_par, trans.A_par);
                            result_p++ ;
                        end
                    else
                        begin
                            $display("FAIL set :: I_par = %0b :: A_par = %0b", trans.I_par, trans.A_par);
                            result_f++ ;
                        end
                end
             
             else if (trans.reset == 1'b1 & trans.s0 == 1'b0 & trans.s1 ==1'b1)
                begin
                    a = a << 1;
                    a[0] = trans.LSB_in;
                    if(trans.A_par == a)
                        begin
                            $display("PASS left_shift :: expected = %0b :: actual = %0b", a, trans.A_par);
                            result_p++ ;
                        end
                    else
                        begin
                            $display("FAIL left_shift :: expected = %0b :: actual = %0b", a, trans.A_par); 
                            result_f++ ;
                            if(a[0] != trans.A_par[0])
                                //result_f++ ;
                                begin
                                    if(trans.A_par[0] == trans.MSB_in)
                                        begin
                                            $display("FAIL left shift :: following MSB_in pin not LSB_in pin:: expected = %0b :: actual = %0b :: MSB_in = %0b", a[0], trans.A_par[0], trans.MSB_in); 
                                        end
                                    else
                                        begin
                                            $display("FAIL left shift :: following wrong LSB_in pin :: expected = %0b :: actual = %0b", a[0], trans.A_par[0]);
                                        end 
                                end 
                        end
                end
            else if (trans.reset == 1'b1 & trans.s0 == 1'b1 & trans.s1 ==1'b0)
                begin
                    a = a >> 1;
                    a[3] = trans.MSB_in;
                    //$display("MSB = %0b", trans.MSB_in);
                    if(trans.A_par == a)
                        begin
                            $display("PASS right_shift :: expected = %0b :: actual = %0b", a, trans.A_par);
                            result_p++ ;
                        end
                    else
                        begin
                            $display("FAIL right_shift :: expected = %0b :: actual = %0b", a, trans.A_par);
                            //result_f++ ;
                            if(a[3] != trans.A_par[3])
                                 result_f++ ;
                                begin
                                    if(trans.A_par[3] == trans.LSB_in)
                                        begin
                                            $display("FAIL right shift :: following LSB_in pin not MSB_in pin:: expected = %0b :: actual = %0b :: LSB_in = %0b", a[3], trans.A_par[3], trans.LSB_in); 
                                        end
                                    else
                                        begin
                                            $display("FAIL right shift :: following wrong MSB_in pin :: expected = %0b :: actual = %0b", a[3], trans.A_par[3]);
                                        end 
                                end
                        end
                end

            

              else if (trans.reset == 1'b1 & trans.s0 == 1'b0 & trans.s1 ==1'b0)
                begin
                    if(trans.A_par == a)
                        begin
                            $display("PASS hold :: expected = %0b :: actual = %0b", a, trans.A_par);
                            result_p++ ;
                        end
                    else
                        begin
                            $display("FAIL hold :: expected = %0b :: actual = %0b", a, trans.A_par);
                            result_f ++;
                        end
                end 

             ->scb_e1;
        end
        
        
    endtask

    task result();
            $display("result :: pass = %0d :: fail = %0d", result_p, result_f);
    endtask

endclass

///////////////////
/*
 else begin

            if (trans.reset == 1'b1 & trans.s0 == 1'b1 & trans.s1 ==1'b0 & chk == 1'b1)
                begin
                    a = a >> 1;
                    a[3] = trans.MSB_in;
                    //scb_mb.get(trans);
                    if(trans.A_par == a)
                        begin
                            $display("PASS right_shift :: expected = %0b :: actual = %0b", a, trans.A_par);
                        end
                    else
                        begin
                            $display("FAIL right_shift :: expected = %0b :: actual = %0b", a, trans.A_par);
                            if(a[3] != trans.A_par[3])
                                begin
                                    if(trans.A_par[3] == trans.LSB_in)
                                        begin
                                            $display("FAIL right shift :: following LSB_in pin not MSB_in pin:: expected = %0b :: actual = %0b :: LSB_in = %0b", a[3], trans.A_par[3], trans.LSB_in); 
                                        end
                                    else
                                        begin
                                            $display("FAIL right shift :: following wrong MSB_in pin :: expected = %0b :: actual = %0b", a[3], trans.A_par[3]);
                                        end 
                                end 
                        end
                end

            else if (trans.reset == 1'b1 & trans.s0 == 1'b0 & trans.s1 ==1'b1)
                begin
                    a = a << 1;
                    a[0] = trans.LSB_in;
                    //a = a << 1;
                    //a[0] = trans.LSB_in;
                    //scb_mb.get(trans);
                    //b = trans.I_par;
                    if(trans.A_par == a)
                        begin
                            $display("PASS left_shift :: expected = %0b :: actual = %0b", a, trans.A_par);
                        end
                    else
                        begin
                            $display("FAIL left_shift :: expected = %0b :: actual = %0b", a, trans.A_par);
                            if(a[0] != trans.A_par[0])
                                begin
                                    if(trans.A_par[0] == trans.MSB_in)
                                        begin
                                            $display("FAIL left shift :: following MSB_in pin not LSB_in pin:: expected = %0b :: actual = %0b :: MSB_in = %0b", a[0], trans.A_par[0], trans.MSB_in); 
                                        end
                                    else
                                        begin
                                            $display("FAIL left shift :: following wrong LSB_in pin :: expected = %0b :: actual = %0b", a[0], trans.A_par[0]);
                                        end 
                                end 
                        end
                end

            end
*/
//////////////////
    
/*    task cc;
        forever begin
            //@(negedge intf.clk);
            scb_mb.get(trans2);
            //$display("scb2 %0p", trans2);
            scb_mb.get(trans);
            //$display("scb %0p", trans);
            if(trans2.reset == 1'b0)
                begin
                    if(trans.A_par == 4'b0000)
                        begin
                            $display("PASS reset");
                        end
                    else
                        begin
                            $display("FAIL reset");
                        end
                end
            else if(trans2.reset == 1'b1 & trans2.s0 == 1'b1 & trans2.s1 ==1'b1)
                begin
                    if(trans.A_par == trans2.I_par)
                        begin
                            $display("PASS set :: I_par = %0b :: A_par = %0b", trans2.I_par, trans.A_par);
                        end
                    else
                        begin
                            $display("FAIL set :: I_par = %0b :: A_par = %0b", trans2.I_par, trans.A_par);
                        end
                end
            else if(trans2.reset == 1'b1 & trans2.s0 == 1'b0 & trans2.s1 ==1'b1)
                begin
                    if(trans.A_par[0] == trans2.LSB_in & trans.A_par[1] == trans2.I_par[0] & trans.A_par[2] == trans2.I_par[1] & trans.A_par[3] == trans2.I_par[2])
                        begin
                            $display("PASS left_shift :: I_par = %0b :: A_par = %0b :: LSB_in == %0b :: LSB_out = %0b", trans2.I_par, trans.A_par, trans2.LSB_in, trans.A_par[0]);
                        end
                    else
                        begin 
                            $display("FAIL left_shift :: I_par = %0b :: A_par = %0b :: LSB_in == %0b :: LSB_out = %0b", trans2.I_par, trans.A_par, trans2.LSB_in, trans.A_par[0]);
                        end
                end
            else if(trans2.reset == 1'b1 & trans2.s0 == 1'b1 & trans2.s1 ==1'b0)
                begin
                    if(trans.A_par[0] == trans2.I_par[1] & trans.A_par[1] == trans2.I_par[2] & trans.A_par[2] == trans2.I_par[3] & trans.A_par[3] == trans2.MSB_in)
                        begin
                            $display("PASS right_shift :: I_par = %0b :: A_par = %0b :: MSB_in == %0b :: MSB_out = %0b", trans2.I_par, trans.A_par, trans2.MSB_in, trans.A_par[3]);
                        end
                    else
                        begin
                            $display("FAIL right_shift :: I_par = %0b :: A_par = %0b :: MSB_in == %0b :: MSB_out = %0b", trans2.I_par, trans.A_par, trans2.MSB_in, trans.A_par[3]);
                        end
                end
            else if(trans2.reset == 1'b1 & trans2.s0 == 1'b0 & trans2.s1 ==1'b0)
                begin
                    if(trans.A_par == a)
                        begin
                            $display("PASS hold :: I_par = %0b :: A_par = %0b :: A_par_prev == %0b", trans2.I_par, trans.A_par, a);
                        end
                    else
                        begin
                            $display("FAIL hold :: I_par = %0b :: A_par = %0b :: A_par_prev == %0b", trans2.I_par, trans.A_par, a);
                        end
                end
            a = trans.A_par;

            ->scb_e1;
        end 
    endtask  */


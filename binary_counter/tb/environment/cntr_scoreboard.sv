class scoreboard;
    typedef mailbox #(transaction) mbx;
    mbx mon2sb;
    transaction trans_act,trans_exp;
    int pass;
    int fail;
    function new(mbx mon2sb,event b);
        this.mon2sb=new;
        this.mon2sb=mon2sb;
        this.trans_act=new;
        this.trans_exp=new;
        pass=0;
        fail=0;
        $display("Inside scoreboard");
        fork
            run(b);
        join_none
    endfunction
    task run(event b);
        forever begin
            @(b);
            mon2sb.get(trans_act);
            calculate_op(); //expected value is calculated
        end
    endtask
    task calculate_op();
        if (trans_act.reset===0) begin
            trans_exp.A_count=0;
            trans_exp.C_out=0;
            if(trans_act.A_count===trans_exp.A_count && trans_act.C_out===trans_exp.C_out ) pass++; 
            else begin fail++;
                if (trans_act.A_count!==trans_exp.A_count) 
                    $display("%0t: Test Failed for A_count when Reset: reset=%0d enable=%0d load=%0d count=%0d A_count_expected=%0d A_count_actual=%0d" ,$time, trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.A_count, trans_act.A_count );
                else $display("%0t: Test Failed for C_out when Reset: reset=%0d enable=%0d load=%0d count=%0d C_out_expected=%0d C_out_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.C_out, trans_act.C_out );
           end
        end
        else if(trans_act.reset===1) begin
            if(trans_act.enable===0) begin
                if(trans_act.A_count===trans_exp.A_count && trans_act.C_out===trans_exp.C_out ) pass++; 
            else begin fail++;
                if (trans_act.A_count!==trans_exp.A_count)
                    $display("%0t: Test Failed for A_count when Disabled: reset=%0d enable=%0d load=%0d count=%0d A_count_expected=%0d A_count_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.A_count, trans_act.A_count );
                else $display("%0t: Test Failed for C_out when Disabled: reset=%0d enable=%0d load=%0d count=%0d C_out_expected=%0d C_out_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.C_out, trans_act.C_out );
           end
            end
            else if(trans_act.enable===1) begin 
                if( trans_act.load===1) begin
                    trans_exp.A_count=trans_act.data_in;
                    trans_exp.C_out=0;
                    if(trans_act.A_count===trans_exp.A_count && trans_act.C_out===trans_exp.C_out ) pass++; 
                    else begin fail++;
                        if (trans_act.A_count!==trans_exp.A_count)
                            $display("%0t: Test Failed for A_count while Loading Data: reset=%0d enable=%0d load=%0d count=%0d A_count_expected=%0d A_count_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.A_count, trans_act.A_count );
                        else $display("%0t: Test Failed for C_out whiling Loading Data: reset=%0d enable=%0d load=%0d count=%0d C_out_expected=%0d C_out_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.C_out, trans_act.C_out);
                    end
                end
                else if(trans_act.load===0) begin
                    if (trans_act.count===1) begin
                        if (trans_exp.A_count===4'd15) begin 
                            trans_exp.C_out=1;
                            trans_exp.A_count=0;
                            if(trans_act.A_count===trans_exp.A_count && trans_act.C_out===trans_exp.C_out ) pass++; 
                            else begin fail++;
                                if (trans_act.A_count!==trans_exp.A_count)
                                    $display("%0t: Test Failed for A_count when Rolled Over: reset=%0d enable=%0d load=%0d count=%0d A_count_expected=%0d A_count_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.A_count, trans_act.A_count );
                                else $display("%0t: Test Failed for C_out when Rolled Over: reset=%0d enable=%0d load=%0d count=%0d C_out_expected=%0d C_out_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.C_out, trans_act.C_out );
                            end
                        end
                        else begin
                            trans_exp.A_count=trans_exp.A_count+1;
                            trans_exp.C_out=0;
                            if(trans_act.A_count===trans_exp.A_count && trans_act.C_out===trans_exp.C_out ) pass++; 
                            else begin fail++;
                                if (trans_act.A_count!==trans_exp.A_count)
                                    $display("%0t: Test Failed for A_count while Up Counting: reset=%0d enable=%0d load=%0d count=%0d A_count_expected=%0d A_count_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.A_count, trans_act.A_count );
                               else $display("%0t: Test Failed for C_out while Up Counting: reset=%0d enable=%0d load=%0d count=%0d C_out_expected=%0d C_out_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.C_out, trans_act.C_out);
                           end
                        end
                    end
                    else if(trans_act.count==0) begin
                            trans_exp.A_count=trans_exp.A_count-1;
                            trans_exp.C_out=0;
                            if(trans_act.A_count===trans_exp.A_count && trans_act.C_out===trans_exp.C_out ) pass++; 
                            else begin fail++;
                                if (trans_act.A_count!==trans_exp.A_count)
                                    $display("%0t: Test Failed for A_count while Down Counting: reset=%0d enable=%0d load=%0d count=%0d A_count_expected=%0d A_count_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.A_count, trans_act.A_count );
                                else $display("%0t: Test Failed for C_out while Down Counting reset=%0d enable=%0d load=%0d count=%0d C_out_expected=%0d C_out_actual=%0d" ,$time,trans_act.reset,trans_act.enable,trans_act.load,trans_act.count,trans_exp.C_out, trans_act.C_out );
                            end
                    end   
                end
            end
        end
    endtask
    task display();
        $display("%0t: Pass= %0d , Fail= %0d ",$time,pass,fail);
        if (fail>0) $display("Test Failed");
        else $display("Test Passed");
    endtask
endclass

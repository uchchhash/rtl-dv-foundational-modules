`timescale 1ns/1ps
class counter_sync_test;
    int fail=0;
    transaction trans_act,trans_exp;
    virtual inf_counter inf;
    function new(virtual inf_counter inf);
        this.inf=inf;
        this.trans_act=new;
        this.trans_exp=new;
        $display("Inside sync_test");
        fork
            monitor();
        join_none
    endfunction
    task monitor();
        forever begin
        @(negedge inf.clk); 
        trans_act.A_count=inf.A_count; 
        trans_act.C_out=inf.C_out;
        if (trans_act.A_count!=trans_exp.A_count || trans_act.C_out!=trans_exp.C_out ) begin
            $display("%0t : Test Failed", $time);
            fail++;
        end
        end
    endtask
    task run(int Half_Period);
        inf.reset<=0;
        inf.enable<=0;
        inf.load<=0;
        inf.count<=0;
        inf.data_in<=0;
        @(posedge inf.clk); #(Half_Period/4);
        trans_exp.A_count=inf.A_count;
        trans_exp.C_out=inf.C_out; #(Half_Period/2);
        inf.reset<=1;
        inf.enable<=1;
        inf.load<=1;
        inf.count<=0;
        inf.data_in<=4'd15;
        @(posedge inf.clk); #(Half_Period/4);
        trans_exp.A_count=inf.A_count;
        trans_exp.C_out=inf.C_out; #(Half_Period/2);
        inf.reset<=0;
        inf.enable<=1;
        inf.load<=1;
        inf.count<=1;
        inf.data_in<=4'd15;
        @(posedge inf.clk); #(Half_Period/4);
        trans_exp.A_count=inf.A_count;
        trans_exp.C_out=inf.C_out; #(Half_Period/2);
        inf.reset<=1;
        inf.enable<=1;
        inf.load<=0;
        inf.count<=1;
        inf.data_in<=4'd15;
        @(posedge inf.clk); #(Half_Period/4);
        trans_exp.A_count=inf.A_count;
        trans_exp.C_out=inf.C_out; #(Half_Period/2);
        inf.reset<=1;
        inf.enable<=1;
        inf.load<=0;
        inf.count<=0;
        inf.data_in<=4'd15;
        @(posedge inf.clk); #(Half_Period/4);
        trans_exp.A_count=inf.A_count;
        trans_exp.C_out=inf.C_out; #(Half_Period/2);
        inf.reset<=1;
        inf.enable<=1;
        inf.load<=0;
        inf.count<=0;
        inf.data_in<=4'd15;
        @(posedge inf.clk);
        if (fail>0) $display("Test Failed");
        else $display("Test Passed");
    endtask
endclass

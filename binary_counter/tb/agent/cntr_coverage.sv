class coverage;
     transaction trans;
     typedef mailbox #(transaction) mbx;
     mbx mon2cvg;
     event a;
     covergroup cg @(a) ;
         load: coverpoint trans.load{
             bins load_high={1};
             bins load_low={0};
             }
         enable: coverpoint trans.enable{
             bins enable_high={1};
             bins enable_low={0};
             }
         count: coverpoint trans.count{
             bins count_high={1};
             bins count_low={0};
             }
         reset: coverpoint trans.reset{
             bins reset_high={1};
             bins reset_low={0};
             }
         data: coverpoint trans.data_in; 
         A_count: coverpoint trans.A_count;
         C_out: coverpoint trans.C_out{
             bins C_out_low={0};
             bins C_out_high={1};
             }
         C_out_transition: coverpoint trans.C_out {
             bins tr1_0=(1=>0);
             bins tr0_1=(0=>1);
             }
         A_up_count_transition: coverpoint trans.A_count {
             bins tr0_1=(0=>1);
             bins tr1_2=(1=>2);
             bins tr2_3=(2=>3);
             bins tr3_4=(3=>4);
             bins tr4_5=(4=>5);
             bins tr5_6=(5=>6);
             bins tr6_7=(6=>7);
             bins tr7_8=(7=>8);
             bins tr8_9=(8=>9);
             bins tr9_10=(9=>10);
             bins tr10_11=(10=>11);
             bins tr11_12=(11=>12);
             bins tr12_13=(12=>13);
             bins tr13_14=(13=>14);
             bins tr14_15=(14=>15);
             bins tr15_0=(15=>0);
             }
         A_down_count_transition: coverpoint trans.A_count {
             bins tr1_0=(1=>0);
             bins tr2_1=(2=>1);
             bins tr3_2=(3=>2);
             bins tr4_3=(4=>3);
             bins tr5_4=(5=>4);
             bins tr6_5=(6=>5);
             bins tr7_6=(7=>6);
             bins tr8_7=(8=>7);
             bins tr9_8=(9=>8);
             bins tr10_9=(10=>9);
             bins tr11_10=(11=>10);
             bins tr12_11=(12=>11);
             bins tr13_12=(13=>12);
             bins tr14_13=(14=>13);
             bins tr15_14=(15=>14);
             bins tr0_15=(0=>15);
             }
             
         comb_up_count: cross reset, enable, load, count, A_count {
             ignore_bins ig1=binsof(reset.reset_low) || binsof(enable.enable_low) || binsof(count.count_low) || binsof(load.load_high);
             }
         comb_up_count_transition: cross reset, enable, load, count, A_up_count_transition {
             ignore_bins ig1=binsof(reset.reset_low) || binsof(enable.enable_low) || binsof(count.count_low) || binsof(load.load_high) ;
             }
         comb_down_count: cross reset, enable, count, load, A_count {
             ignore_bins ig1=binsof(reset.reset_low) || binsof(enable.enable_low) || binsof(count.count_high) || binsof(load.load_high) ;
             }
         comb_down_count_transition: cross reset, enable, count, load, A_down_count_transition {
             ignore_bins ig1=binsof(reset.reset_low) || binsof(enable.enable_low) || binsof(count.count_high) || binsof(load.load_high) ;
             }
         comb_load_data_in: cross reset, enable, load, count, data {
             ignore_bins ig2=binsof(reset.reset_low) || binsof(enable.enable_low) || binsof(load.load_low);
             }
         comb_load_load_data_out: cross reset, enable, load, count, A_count {
             ignore_bins ig2=binsof(reset.reset_low) || binsof(enable.enable_low) || binsof(load.load_low);
             }
         comb_carry_out: cross reset, enable, count, load, C_out {
             ignore_bins ig1=binsof(reset.reset_low) || binsof(enable.enable_low) || binsof(count.count_low) || binsof(load.load_high);
             }
         comb_carry_out_transition: cross reset, enable, count, load, C_out_transition {
             ignore_bins ig1=binsof(reset.reset_low) || binsof(enable.enable_low) || binsof(count.count_low) || binsof(load.load_high);
             }
     endgroup
     
     function new(mbx mon2cvg);
         this.mon2cvg=new;
         this.mon2cvg=mon2cvg;
         trans=new;
         cg=new();
         $display("Inside Coverage");
         fork
             run();
         join_none
     endfunction
     task run();
         forever begin
             mon2cvg.get(trans);
             ->a;
         end
     endtask
endclass


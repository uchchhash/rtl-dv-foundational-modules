//`timescale 1ns/1ps
module counter_tb_top;
     bit clk=0;
     int Half_Period;
     initial begin 
        $value$plusargs("Half_Period=%d",Half_Period);
     end
     always #(Half_Period) clk=~clk;
     inf_counter inf(clk);
     counter_up_count_test test3;
     counter_reset_test test1;
     counter_load_test test2;
     counter_down_count_test test4;
     counter_roll_over_test test5;
     counter_reverse_roll_over_test test6;
     counter_random_test test7;
     counter_disable_test test8;
     counter_sync_test test9;


     Binary_Counter counter(  //connection with DUT
         .CLK(inf.clk),
         .reset(inf.reset),
         .Enable(inf.enable),
         .Load(inf.load),
         .Count(inf.count),
         .Data_in(inf.data_in),
         .A_count(inf.A_count),
         .C_out(inf.C_out)
         );
     


     initial begin //taking test_name from user to run different tests
              if($test$plusargs("cntr_reset_test")) begin
                  test1=new(inf); 
                  test1.run();
              end
              else if($test$plusargs("cntr_load_test")) begin
                  test2=new(inf); 
                  test2.run();
              end
              else if($test$plusargs("cntr_up_count_test")) begin
                  test3=new(inf); 
                  test3.run(); 
              end
              else if($test$plusargs("cntr_down_count_test")) begin
                  test4=new(inf); 
                  test4.run();
              end
              else if($test$plusargs("cntr_roll_over_test")) begin
                  test5=new(inf); 
                  test5.run();
              end
              else if($test$plusargs("cntr_disable_test")) begin
                  test8=new(inf);
                  test8.run(); 
              end 
              else if($test$plusargs("cntr_reverse_roll_over_test")) begin
                  test6=new(inf); 
                  test6.run();
              end
             else if($test$plusargs("cntr_sync_test")) begin
                  test9=new(inf); 
                  test9.run(Half_Period);
              end
              else begin
                  test7=new(inf);
                  test7.run(); 
              end 
              
              //else $display("No test run");  
         $finish;
    end
endmodule

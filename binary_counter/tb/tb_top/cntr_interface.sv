interface inf_counter(input logic clk);
     logic reset;
     logic enable;
     logic load;
     logic count;
     logic [3:0]data_in;
     logic [3:0] A_count;
     logic C_out;
endinterface

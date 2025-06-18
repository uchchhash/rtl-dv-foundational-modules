class monitor;
     transaction trans;
     typedef mailbox #(transaction) mbx;
     virtual inf_counter inf;
     mbx mon2sb;
     mbx mon2cvg;
     function new(virtual inf_counter inf,mbx mon2sb,mbx mon2cvg,event b);
          this.trans=new;
          this.mon2sb=new;
          this.mon2sb=mon2sb;
          this.mon2cvg=new;
          this.mon2cvg=mon2cvg;
          this.inf=inf;
          $display("Inside monitor");
          fork
              monitor_data(b);
          join_none
     endfunction
     task monitor_data(event b);
          forever begin
          @(posedge inf.clk);
          trans.reset=inf.reset;
          trans.load=inf.load;
          trans.count=inf.count;
          trans.enable=inf.enable;
          trans.data_in=inf.data_in;
          @(negedge inf.clk);
          trans.A_count=inf.A_count;
          trans.C_out=inf.C_out;
          mon2sb.put(trans);
          mon2cvg.put(trans);
          ->b;
         end
     endtask
endclass

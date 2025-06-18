class driver;
    transaction trans;
    typedef mailbox #(transaction) mbx;
    mbx gen2drv;
    virtual inf_counter inf;
    function new(virtual inf_counter inf,mbx gen2drv,event a);
          this.inf=inf;
          this.gen2drv=new;
          this.gen2drv=gen2drv;
          trans=new;
          $display("Inside Driver");
          fork 
              drive(a);
          join_none
     endfunction
     task drive(event a);
          forever begin
               gen2drv.get(trans);  
               if(trans.hold==1) 
                   hold(trans.hold_time); 
               else run();   
          ->a;
          end
     endtask
     
     task hold(int hold_time);
         repeat(hold_time) begin
             @(negedge inf.clk);
         end
     endtask
     task run();
          inf.reset<=trans.reset;
          inf.load<=trans.load;
          inf.count<=trans.count;
          inf.enable<=trans.enable;
          inf.data_in<=trans.data_in;
      endtask
      
endclass

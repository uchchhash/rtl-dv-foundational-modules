class generator;
     transaction trans,trans_directed;
     typedef mailbox #(transaction) mbx;
     mbx gen2drv;
    function new(mbx gen2drv);
          this.trans_directed=new;
          this.gen2drv=new;
          this.gen2drv=gen2drv;
          $display("Inside generator");
     endfunction

     
     task reset(event a,bit random,bit reset);
          if (random) begin
          trans=new(); 
          void '(trans.randomize() with {reset==0;});
          gen2drv.put(trans);
          end
          else begin 
          trans_directed.reset=reset;
          gen2drv.put(trans_directed);
          end
          @(a);         
     endtask
     
     task hold(int hold_time,event a);
         trans=new(); 
         trans.hold=1;
         trans.hold_time=hold_time;
         gen2drv.put(trans);
         @(a);
     endtask

     task enable(event a,bit random,bit enable);
         if (random) begin
         trans=new();
         void '(trans.randomize() with {reset==1 ; enable==1;});
         gen2drv.put(trans);
         end
         else begin 
         trans_directed.enable=enable;
         gen2drv.put(trans_directed);
         end
         @(a);
     endtask
     
     task load(bit [3:0]data,event a,bit random,bit load);
         if (random) begin
         trans=new(); 
         void '(trans.randomize() with {reset==1; enable==1; load==1;});
         gen2drv.put(trans);
         end
         else begin 
         trans_directed.load=load;
         trans_directed.data_in=data;
         gen2drv.put(trans_directed);
         end
         @(a);
     endtask    
     
     task count(event a,bit random,bit count);
         if (random) begin
         trans=new(); 
         void '(trans.randomize() with {reset==1; enable==1; load==0;});
         gen2drv.put(trans);
         end
         else begin 
         trans_directed.count=count;
         gen2drv.put(trans_directed);
         end
         @(a);
     endtask 
     
endclass



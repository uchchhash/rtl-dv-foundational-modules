class environment;
     agent agnt;
     scoreboard sb;
     typedef mailbox #(transaction) mbx;
     mbx mon2sb;
     event b;

     function new(virtual inf_counter inf,event a);
         mon2sb=new; 
         agnt=new(inf,mon2sb,b,a);
         sb=new(mon2sb,b);
         $display("Inside environment");
     endfunction
     
endclass

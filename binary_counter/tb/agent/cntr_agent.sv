class agent;
    generator gen;
    driver drv;
    typedef mailbox #(transaction) mbx;
    mbx gen2drv;
    mbx mon2cvg;
    monitor mon;
    coverage cvg;
    function new(virtual inf_counter inf,mbx mon2sb,event b,event a);
        gen2drv=new;
        mon2cvg=new;
        gen=new(gen2drv);
        drv=new(inf,gen2drv,a);
        mon=new(inf,mon2sb,mon2cvg,b);  
        cvg=new(mon2cvg);
        $display("Inside Agent");
    endfunction
   
endclass

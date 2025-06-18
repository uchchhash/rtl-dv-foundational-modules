class counter_base_test;
    environment env;
    event a;
    function new(virtual inf_counter inf);
        env=new(inf,a);
        $display("Inside base_test");
    endfunction

    virtual task run();
    endtask

endclass

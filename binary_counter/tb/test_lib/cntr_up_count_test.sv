class counter_up_count_test extends counter_base_test;
    function new(virtual inf_counter inf);
        super.new(inf);
        $display("Inside up_count_test");
    endfunction

    task run();
        env.agnt.gen.reset(a,0,0);
        env.agnt.gen.hold(2,a);
        env.agnt.gen.reset(a,0,1);
        env.agnt.gen.enable(a,0,1);
        env.agnt.gen.load(4'd0,a,0,1);
        env.agnt.gen.hold(1,a);
        env.agnt.gen.load(4'd0,a,0,0);
        env.agnt.gen.count(a,0,1);
        env.agnt.gen.hold(20,a);
        env.agnt.gen.enable(a,0,0);
        env.agnt.gen.hold(1,a);
        env.sb.display();
    endtask
endclass

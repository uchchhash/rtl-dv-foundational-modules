class counter_random_test extends counter_base_test;
    int index;
    function new(virtual inf_counter inf);
         super.new(inf);
         $display("Inside random_test");
    endfunction
    task run();
        string array[4]={"Reset","Enable","Load","Count"};
        string test;
        env.agnt.gen.reset(a,0,0);
        env.agnt.gen.hold(2,a);
        for (int i=0; i<4; i++) begin
            index=$urandom_range(i,3);
            test=array[i];
            array[i]=array[index];
            array[index]=test;
            if (array[i]=="Reset") begin
                repeat (5) begin
                    env.agnt.gen.reset(a,1,0);
                    env.agnt.gen.hold(1,a);
                end
            end
            if (array[i]=="Enable") begin
                repeat (5) begin 
                    env.agnt.gen.enable(a,1,0);
                    env.agnt.gen.hold(1,a);
                end
            end
            if (array[i]=="Load") begin
                repeat (5) begin 
                    env.agnt.gen.load(4'd0,a,1,1);
                    env.agnt.gen.hold(1,a);
                end
            end
            if (array[i]=="Count") begin
                repeat (5) begin
                    env.agnt.gen.count(a,1,0);
                    env.agnt.gen.hold(1,a);
                end
            end
        end
        env.sb.display();
    endtask
endclass

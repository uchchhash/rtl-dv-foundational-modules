class parent;

    function new(string name);
        $display("%0s created", name);
    endfunction

endclass


class child extends parent;

    function new(string name);
        $display("child created", name);
    endfunction

endclass



module testt;
    parent pp;
    child cc;
    initial begin
        //pp = new("pp parent");
        cc = new("cc child");
    end

endmodule

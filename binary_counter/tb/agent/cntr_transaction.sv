class transaction;
    rand bit reset;
    rand bit enable;
    rand bit load;
    rand bit count;
    rand bit [3:0]data_in;
    int hold_time;
    bit hold;
    bit [3:0]A_count;
    bit C_out;
    function new();
        //$display("Inside Transaction");
    endfunction
endclass

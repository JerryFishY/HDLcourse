module as_s_tb;
    reg nRST_rc;
    reg switch;
    reg clk_out;
    wire reset_n;

    as_s dut (
        .nRST_rc(nRST_rc),
        .switch(switch),
        .clk_out(clk_out),
        .reset_n(reset_n)
    );

    initial begin
        // Initialize inputs
        nRST_rc = 0;
        switch = 0;
        clk_out = 0;
        #30
        nRST_rc=0;
        switch=1;
        #30
        nRST_rc=1;
        switch=0;
        #30
        nRST_rc=1;
        switch=1;
        #60
        nRST_rc=0;
        switch=1;
        #60
        nRST_rc=1;

        // Finish simulation
        #60;
        $finish;
    end

    always begin
        #5;
        clk_out = ~clk_out;
    end
    initial begin
        $dumpfile("as_s_tb.vcd");
        $dumpvars(0, as_s_tb);
    end
    //successfully synchronous the RST signal with the clock_out
endmodule
module pulsegen_tb;
    reg clk_RC;
    reg nRST;
    reg switch;
    wire rst_n_rc;

    pulsegen dut (
        .clk_RC(clk_RC),
        .nRST(nRST),
        .switch(switch),
        .rst_n_rc(rst_n_rc)
    );

    initial begin
        clk_RC=1;
        nRST=1;
        switch=0;
        #100
        switch=1;
        #100
        nRST=0;
        #100
        nRST=0;

        $finish; // End the simulation
    end

    always #5 clk_RC = ~clk_RC; // Toggle the clock every 5 time units

    initial begin
        $dumpfile("pulsegen_tb.vcd");
        $dumpvars(0, pulsegen_tb);
    end
    //correctly finish the pulse
endmodule
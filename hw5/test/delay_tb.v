module delay_tb;
    reg POR_n;
    reg clk_RC;
    wire switch_o;

    delay dut (
        .POR_n(POR_n),
        .clk_RC(clk_RC),
        .switch(switch_o)
    );

    initial begin
        POR_n = 1;
        clk_RC = 0;
        #5;
        POR_n = 0;
        #10;
        POR_n = 1;
        #2000;
        POR_n =0;
        #1000
        POR_n=1;
        #2000
        $finish;
    end

    always #5 clk_RC = ~clk_RC;

    initial begin
        $dumpfile("delay_tb.vcd");
        $dumpvars(0, delay_tb);
    end
    // successfully generate a switch signal after 128 cycles in the clock field of clk_RC
endmodule
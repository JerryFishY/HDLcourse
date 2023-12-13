module reset_tb;
    reg POR_n, clk_osc, clk_RC, nRST;
    wire rst_n;

    resetmod dut (
        .POR_n(POR_n),
        .clk_osc(clk_osc),
        .clk_RC(clk_RC),
        .nRST(nRST),
        .rst_n(rst_n)
    );

    initial begin
        // Initialize inputs
        POR_n = 1;
        clk_osc = 0;
        clk_RC = 0;
        nRST = 1;
        
        //system initialization
        #100
        POR_n=0;
        #40
        POR_n=1;
        #3000
        //manal reset
        nRST=0;
        //dummy signal
        #1
        nRST=1;
        #1
        nRST=0;
        #2
        nRST=1;
        #1
        nRST=0;
        #200
        //dummy signal
        nRST=1;
        #1
        nRST=0;
        #2
        nRST=1;
        #1
        nRST=0;
        #3
        nRST=1;
        #3000
        // Finish simulation
        $finish;
    end

    always #2 clk_osc=~clk_osc;
    always #5 clk_RC=~clk_RC;

    initial begin
        $dumpfile("reset_tb.vcd");
        $dumpvars(0, reset_tb);
    end
endmodule
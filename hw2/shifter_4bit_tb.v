module shifter_4bit_tb;

    // Inputs
    reg [3:0] D;
    reg D_sr, D_sl, ld, sr, sl;
    reg clk;

    // Outputs
    wire [3:0] Q;

    // Instantiate the Unit Under Test (UUT)
    shifter_4bit uut (
        .D(D),
        .D_sr(D_sr),
        .D_sl(D_sl),
        .ld(ld),
        .sr(sr),
        .sl(sl),
        .clk(clk),
        .Q(Q)
    );

    // Clock generation
    initial begin
        clk = 0;  // Initial value
        forever #10 clk = ~clk;  // Toggle every 10 ns to generate a 50 MHz clock
    end

    initial begin
        $dumpfile("wave.vcd");   // Specify the VCD file name
        $dumpvars(0, shifter_4bit_tb); // Dump all variables in the testbench
        // Initialize Inputs
        D = 4'b0000;
        D_sr = 1'b0;
        D_sl = 1'b0;
        ld = 1'b0;
        sr = 1'b0;
        sl = 1'b0;

        // Wait 100 ns for global reset to finish
        #100;

        // Test case 1: Load data
        ld = 1'b1;
        D = 4'b1010;
        #20;
        ld = 1'b0;
        if (Q !== 4'b1010) $display("Test case 1 failed");

        // Test case 2: Shift right
        sr = 1'b1;
        D_sr = 1'b1;
        #20;
        sr = 1'b0;
        if (Q !== 4'b1101) $display("Test case 2 failed");

        // Test case 3: Shift left
        sl = 1'b1;
        D_sl = 1'b1;
        #20;
        sl = 1'b0;
        if (Q !== 4'b1011) $display("Test case 3 failed");

        // Test case 4: Shift right and left
        sr = 1'b1;
        D_sr = 1'b0;
        #20;
        sr=1'b0;
        sl = 1'b1;
        D_sl = 1'b1;
        #20;
        sr = 1'b0;
        sl = 1'b0;
        if (Q !== 4'b1011) $display("Test case 4 failed");

        $display("All test cases passed");
        $finish;
    end

endmodule

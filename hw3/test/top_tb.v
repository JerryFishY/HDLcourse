module top_tb;

    // Testbench Signals
    reg start;
    reg [7:0] data_in;
    reg byt;
    reg reset_n;
    reg clk;
    wire full;
    wire [4:0] dmod;
    wire mod_en;

    // Instantiate the Unit Under Test (UUT)
    top uut (
        .start(start),
        .data_in(data_in),
        .byt(byt),
        .reset_n(reset_n),
        .clk(clk),
        .full(full),
        .dmod(dmod),
        .mod_en(mod_en)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Test procedure
    initial begin
        // Initialize Inputs
        start = 0;
        data_in = 0;
        byt = 0;
        reset_n = 0;

        #20;
        reset_n = 1;

        // Start the input sequence
        #10;
        @(posedge clk)begin
        start <= 1;
        data_in <= 8'h10; byt <= 1; // Input 10
        end
        #10;
        @(posedge clk)begin
        data_in <= 8'h02; byt <= 0; // Input X2
        end
        #10;
        @(posedge clk)begin
        data_in <= 8'h43; byt <= 1; // Input 43
        end
        #10;
        @(posedge clk)begin
        data_in <= 8'h95; byt <= 1; // Input 95
        end
        #10;
        @(posedge clk)begin
        data_in <= 8'h06; byt <= 0; // Input X6
        end
        #10;
        @(posedge clk)begin
        data_in <= 8'h87; byt <= 1; // Input 87
        end
        #10;
        @(posedge clk)begin
        start <= 0; // End of sequence
        end

        // Continue with more scenarios or end the test
        #1000;
        $finish;
    end
    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
    end
endmodule

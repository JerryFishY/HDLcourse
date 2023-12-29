module data_trans_tb;

    // Inputs
    reg reset_n;
    reg clk;
    reg start;
    reg [7:0] data_in;
    reg byt;

    // Outputs
    wire [7:0] data_o;
    wire data_en;

    // Instantiate the Unit Under Test (UUT)
    data_trans uut (
        .reset_n(reset_n), 
        .clk(clk), 
        .start(start), 
        .data_in(data_in), 
        .byt(byt), 
        .data_o(data_o), 
        .data_en(data_en)
    );

    // Clock generation
    initial begin
        clk = 1;
        forever #10 clk = ~clk; // Generate a clock with a period of 20ns
    end

    // Test procedure
    initial begin
        // Initialize Inputs
        reset_n = 0;
        start = 0;
        data_in = 0;
        byt = 0;
        #100;
        reset_n = 1;

        // Case 1: Send data with 'byt' set to 1
        @ (posedge clk)begin
        start <= 1;
        byt <= 1;
        data_in <= 8'h10; // Example data
        end
        #20

        @ (posedge clk)begin
        byt <= 0;
        data_in <= 8'h32; // Example data
        end
        #20;

        @ (posedge clk)begin
        byt <= 1;
        data_in <= 8'h43; // Example data
        end
        #20;

        @ (posedge clk)begin
        byt <= 1;
        data_in <= 8'h95; // Example data
        end
        #20;

        @ (posedge clk)begin
        byt <= 0;
        data_in <= 8'h36; // Example data
        end
        #20;

        @ (posedge clk)begin
        byt <= 1;
        data_in <= 8'h87; // Example data
        end
        #20;

        @ (posedge clk)begin
        start <= 0;
        data_in <= 8'h34; // Example data
        end
        #200;


        // Stop the test
        $finish;
    end

    initial begin
        $dumpfile("data_trans_tb.vcd");
        $dumpvars(0, data_trans_tb);
    end
    // Successfully get the output
endmodule

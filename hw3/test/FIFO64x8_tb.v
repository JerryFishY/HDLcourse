module FIFO64x8_tb;

    // Parameters
    localparam DEPTH = 3;
    localparam WIDTH = 8;

    // Testbench Signals
    reg clk;
    reg reset_n;
    reg [WIDTH-1:0] data_i;
    reg rd_en;
    reg wr_en;
    wire [WIDTH-1:0] data_o;
    wire overflow;
    wire underflow;

    // Instantiate the Unit Under Test (UUT)
    FIFO_64x8 #(DEPTH, WIDTH) uut (
        .clk(clk),
        .reset_n(reset_n),
        .data_i(data_i),
        .rd_en(rd_en),
        .wr_en(wr_en),
        .data_o(data_o),
        .overflow(overflow),
        .underflow(underflow)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Test procedure
    initial begin
        // Initialize Inputs
        reset_n = 0;
        data_i = 0;
        rd_en = 0;
        wr_en = 0;

        // Reset the FIFO
        #20;
        reset_n = 1;

        // Write data into FIFO
        #10;
        @(posedge clk)begin
        wr_en <= 1;
        data_i <= 8'hA0; 
        end

        #10
        @(posedge clk)begin
        wr_en <= 1;
        data_i <= 8'hA1; 
        end

        #10
        @(posedge clk)begin
        wr_en <= 1;
        data_i <= 8'hAA; 
        end

        #10
        @(posedge clk)begin
        wr_en <= 1;
        data_i <= 8'hAB; 
        end

        #10
        @(posedge clk)begin
        wr_en <= 1;
        data_i <= 8'hAC; 
        end

        #10
        @(posedge clk)begin
        wr_en <= 1;
        data_i <= 8'hAD; 
        end

        #10
        @(posedge clk)begin
            wr_en <= 0;
        end

        // Read data from FIFO
        #10;
        @(posedge clk)begin
        rd_en <= 1;
        end

        #10;
        @(posedge clk)begin
        rd_en <= 1;
        end

        #10;
        @(posedge clk)begin
        rd_en <= 1;
        end

        #10;
        @(posedge clk)begin
        rd_en <= 1;
        end

        #10;
        @(posedge clk)begin
        rd_en <= 1;
        end

        #10;
        @(posedge clk)begin
        rd_en <= 1;
        end

        #10
        @(posedge clk)begin
            rd_en <= 0;
        end
        // Finish the simulation
        #100;
        $finish;
    end

    initial begin
        $dumpfile("FIFO64x8_tb.vcd");
        $dumpvars(0, FIFO64x8_tb);
    end
endmodule

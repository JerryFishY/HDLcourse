module data_mod_tb;

    // Inputs
    reg clk;
    reg reset_n;
    reg rdy;
    reg [7:0] data_in;

    // Outputs
    wire mod_en;
    wire rd;
    wire [4:0] dmod;

    // Instantiate the Unit Under Test (UUT)
    data_mod uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .rdy(rdy), 
        .data_in(data_in), 
        .mod_en(mod_en), 
        .rd(rd), 
        .dmod(dmod)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period of 10 ns
    end

    // Test procedure
    initial begin
        // Initialize Inputs
        reset_n = 0; // Assert reset
        rdy = 1;
        data_in = 0;
        
        // Wait for global reset
        #100;
        reset_n = 1; // Deassert reset

        //test begin
        #1000
        
        // End of Test
        $finish;
    end

    always @(posedge clk) begin
        if(rd == 1)
            data_in <= $random & 8'hff ;
    end

    initial begin
        $dumpfile("data_mod_tb.vcd");
        $dumpvars(0, data_mod_tb);
    end
endmodule

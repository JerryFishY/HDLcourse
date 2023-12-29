module clock_switch_tb;

  // Inputs
  reg [1:0] sel_clk1;
  reg clk1;
  reg clk2;
  reg clk3;
  reg rst_n;
  // Outputs
  wire clk_out;

  // Instantiate the clock_switch module
  clock_switch dut (
    .sel_clk1(sel_clk1),
    .rst_n(rst_n),
    .clk1(clk1),
    .clk2(clk2),
    .clk3(clk3),
    .clk_out(clk_out)
  );

  // Clock generation
  always #5 clk1 = ~clk1;
  always #7 clk2 = ~clk2;
  always #9 clk3 = ~clk3;
  // Test cases
  initial begin
    // Test case 1: sel_clk1 = 0, clk1 = 0, clk2 = 0
    rst_n = 0;
    sel_clk1 = 2'b00;
    clk1 = 0;
    clk2 = 0;
    clk3 = 0; 
    #20
    rst_n = 1;
    #200;
    sel_clk1 = 2'b01 ;
    #173;
    sel_clk1 = 2'b10 ;
    #247
    sel_clk1 = 2'b01 ;
    #177
    rst_n=0;
    #100
    rst_n=1;
    #200
    sel_clk1=2'b10;
    #200
    $finish;
  end

  initial begin
        $dumpfile("clock_switch_tb.vcd");
        $dumpvars(0, clock_switch_tb);
    end
//successfully change the clock field 
endmodule
module clock_switch_tb;

  // Inputs
  reg sel_clk1;
  reg clk1;
  reg clk2;

  // Outputs
  wire clk_out;

  // Instantiate the clock_switch module
  clock_switch dut (
    .sel_clk1(sel_clk1),
    .clk1(clk1),
    .clk2(clk2),
    .clk_out(clk_out)
  );

  // Clock generation
  always #5 clk1 = ~clk1;
  always #7 clk2 = ~clk2;

  // Test cases
  initial begin
    // Test case 1: sel_clk1 = 0, clk1 = 0, clk2 = 0
    sel_clk1 = 0;
    clk1 = 0;
    clk2 = 0;
    #200;
    sel_clk1 = 1 ;
    #173;
    sel_clk1 = 0 ;
    #247
    sel_clk1 = 1 ;
    #177
    sel_clk1 = 0 ;
    $finish;
  end

  initial begin
        $dumpfile("clock_switch_tb.vcd");
        $dumpvars(0, clock_switch_tb);
    end
//successfully change the clock field 
endmodule
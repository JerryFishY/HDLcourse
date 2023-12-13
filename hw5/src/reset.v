`include "as_s.v"
`include "delay.v"
`include "clock_switch.v"
`include "pulsegen.v"
/*
The main module for this reset project, with four submodules:
1. delay: to wait for the clk_osc, when clk_osc is stable, switch is set to 1
2. pulsegen: to mitigate the signal jitter from the user
3. as_s1: to let the signal reset asynchronously and recover synchronously
4. clock_switch: to switch the clock from clk_osc to clk_RC
*/
module resetmod (
    input POR_n,     // system reset signal
    input clk_osc,   // external crystal oscillator clock
    input clk_RC,    // internal RC clock
    input nRST,      // external reset signal
    output rst_n
);
wire switch,clk_out;

delay delay1(POR_n,clk_RC,switch);
pulsegen pulsegen1(clk_RC,nRST&POR_n,switch,rst_n_rc);
as_s as_s1(rst_n_rc,switch,clk_out,rst_n);
clock_switch clock_switch1(switch,clk_osc,clk_RC,clk_out);
endmodule
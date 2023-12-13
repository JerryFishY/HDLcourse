/*
This module mitigates the signal jitter from user input rst_n_rc 
*/
module pulsegen (
    input clk_RC,           // RC clock signal
    input nRST,             // manual reset signal
    input switch,           // clock switch signal, generated by clock_switch module
    output reg rst_n_rc     // reset signal without signal jitter
);
reg reg1,reg2,reg3,reg4;
wire mid;
always @(posedge clk_RC) begin
    reg1<=nRST;
    reg2<=reg1;
    reg3<=reg2;
    reg4<=nRST|reg1|reg2|reg3;
end
always @(*)begin
    rst_n_rc=(nRST|reg1|reg2|reg3)&switch;
end
endmodule
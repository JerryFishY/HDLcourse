/*
To switch the clock from clk_osc to clk_RC, and during switch, clk_out remains low.
*/

module clock_switch(
    input sel_clk1,         // selection signal, to select clk1 or clk2
    input clk1,             // first clock signal
    input clk2,             // second clock signal
    output reg clk_out      //selected clock signal
);
reg reg1,reg2,reg3,reg4,reg5,reg6;

always@(posedge clk1)begin
    reg1<=sel_clk1&~reg6;
    reg2<=reg1;
    reg3<=reg2;
end

always@(posedge clk2)begin
    reg4<=~sel_clk1&~reg3;
    reg5<=reg4;
    reg6<=reg5;
end

always@(*)begin
    clk_out=(reg3&clk1)|(reg6&clk2);
end

endmodule
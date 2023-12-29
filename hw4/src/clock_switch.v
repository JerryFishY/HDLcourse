/*

To switch the clock between clk1,clk2,clk3.
For ease of testing, I put the generation of clk1, clk2 and clk3 into the testbench.

*/

module clock_switch(
    input [1:0] sel_clk1,         // selection signal, to select clk1 or clk2
    input rst_n,                  // reset signal , default for clk1
    input clk1,                   // first clock signal
    input clk2,                   // second clock signal
    input clk3,                   // third clock signal
    output reg clk_out            // selected clock signal
);
reg reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9;

always@(posedge clk1)begin
    if(!rst_n) begin
        // reset:sel_clk1 == 2'b00 
        reg1<=~reg6&~reg9;
    end
    else begin
    reg1<=(sel_clk1 == 2'b00)&~reg6&~reg9;
    end
    reg2<=reg1;
    reg3<=reg2;
end

always@(posedge clk2)begin
    if(!rst_n)begin
        reg4<=0;
    end
    else begin
    reg4<=(sel_clk1 == 2'b01)&~reg3&~reg9;
    end
    reg5<=reg4;
    reg6<=reg5;
end

always@(posedge clk3)begin
    if(!rst_n)begin
        reg7<=0;
    end else begin
    reg7<=(sel_clk1 == 2'b10) & ~reg3&~reg6;
    end
    reg8<=reg7;
    reg9<=reg8;
end

always@(*)begin
    clk_out=(reg3&clk1)|(reg6&clk2)|(reg9&clk3);
end

endmodule
`include "FIFO_64x8.v"
`include "data_trans.v"
`include "data_mod.v"

module top(
    input wire start,                    // Asynchronous reset
    input wire [7:0] data_in,            // Clock signal
    input wire byt,                      // Start signal
    input wire reset_n,                  // Reset
    input wire clk,                      // Clock
    output reg full,                     // Overflow signal
    output reg [4:0] dmod,
    output mod_en
);

// Internal state
wire [7:0] data_o_trans;
wire data_en_trans;
wire rd_en_fifo,empty;
wire [7:0] data_o_fifo;
wire full_fifo;
wire [4:0] dmod_fifo;

always@(*) 
    full = full_fifo;
always@(*) 
    dmod = dmod_fifo;
data_trans u1(
    .reset_n(reset_n),
    .clk(clk),
    .start(start),
    .data_in(data_in),
    .byt(byt),
    .data_o(data_o_trans),
    .data_en(data_en_trans)
);

FIFO_64x8 #(
    .DEPTH(3),
    .WIDTH(8)
) u2 (
    .reset_n(reset_n),
    .clk(clk),
    .data_i(data_o_trans),
    .wr_en(data_en_trans),
    .rd_en(rd_en_fifo),
    .data_o(data_o_fifo),
    .overflow(full_fifo),
    .underflow(empty)
);

data_mod u3(
    .clk(clk),
    .reset_n(reset_n),
    .rdy(~empty),
    .data_in(data_o_fifo),
    .mod_en(mod_en),
    .rd(rd_en_fifo),
    .dmod(dmod_fifo)
);
endmodule
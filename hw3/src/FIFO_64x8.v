/*

A configurable fifo module with MAX_COUNT slots and WIDTH bit width.
Reference code from slides.
For ease of testing, I change the depth from 6 to 3.

*/

module FIFO_64x8 #(
parameter DEPTH = 6,        
parameter WIDTH = 8,
MAX_COUNT = (1 << DEPTH)
)(
input wire clk ,                // clock
input wire reset_n ,            // asynchronous reset
input [WIDTH-1:0] data_i ,      // input data
input wire rd_en ,              // read enable
input wire wr_en ,              // write enable
output reg[WIDTH-1:0] data_o ,  // output data
output reg overflow ,           // overflow
output reg underflow            // underflow
);
reg [DEPTH-1 : 0] tail;                       // read pointer
reg [DEPTH-1 : 0] head;                       // write pointer
reg [DEPTH-1 : 0] count;                      // counter for data
reg [WIDTH-1 : 0] fifomem [MAX_COUNT - 1 : 0]; // fifomem

always@(posedge clk) // read
    if(rd_en)
        data_o <= fifomem[tail];

always@(posedge clk) // write 
    if(wr_en)
        fifomem[head] <= data_i;

always@(posedge clk) // update head pointer
    if(!reset_n)
        head <= 0;
    else if(wr_en)
        head <= head + 1'b1;

always@(posedge clk) // update tail pointer
    if(!reset_n)
        tail <= 0;
    else if(rd_en)
        tail <= tail + 1'b1;

always@(posedge clk) //count
    if(!reset_n)
        count <= 0;
    else
        case({rd_en,wr_en})
            2'b00: count <= count;
            2'b01: count <= count + 1'b1;
            2'b10: count <= count - 1'b1;
            2'b11: count <= count;
            default: count <= 'bx;
        endcase
    
always @(*) begin // update overflow and underflow
    overflow = count[(DEPTH-1)-:2] == 2'b11;
    underflow = count[(DEPTH-1)-:2] == 2'b00;
end

endmodule
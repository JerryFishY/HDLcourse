/*

A module that inputs eight bits while output five in one time.
Some reference to teacher's code

*/

module data_mod(
input wire clk ,        // clk
input wire reset_n,     // asynchronous reset
input wire rdy ,        // ready
input wire [7:0] data_in, // input data
output reg mod_en ,     // enable for output
output reg rd ,         // rd for previous module
output reg [4:0] dmod   // output data
);

//Classify the state according to the relationship between 5 and 8
localparam START = 0;
localparam DATA_IN4_0 = 1;
localparam DATA_IN1_0_DATA_R7_5 = 2;
localparam DATA_R6_2 = 3;
localparam DATA_IN3_0_DATA_R7 = 4;
localparam DATA_IN0_DATA_R7_4 = 5;
localparam DATA_R5_1 = 6;
localparam DATA_IN2_0_DATA_R7_6 = 7;
localparam DATA_R7_3 = 8;

reg [7:0] buffer;
reg [3:0] state,next_state ;

// State transfer
always @(*) begin
    case(state)
        START : next_state = DATA_IN4_0 ;
        DATA_IN4_0 : next_state = DATA_IN1_0_DATA_R7_5;
        DATA_IN1_0_DATA_R7_5 : next_state = DATA_R6_2 ;
        DATA_R6_2 : next_state = DATA_IN3_0_DATA_R7 ;
        DATA_IN3_0_DATA_R7 : next_state = DATA_IN0_DATA_R7_4 ;
        DATA_IN0_DATA_R7_4 : next_state = DATA_R5_1 ;
        DATA_R5_1 : next_state = DATA_IN2_0_DATA_R7_6;
        DATA_IN2_0_DATA_R7_6 : next_state = DATA_R7_3 ;
        DATA_R7_3 : next_state = DATA_IN4_0 ;
        default : next_state = START ;
    endcase
end

// Rd bit, sometimes the output need to take three cycles to finish, so the first one should stop receiving numbers
always @(*) begin
    case (state)
        START : rd = 1'b1 & rdy;
        DATA_IN4_0 : rd = 1'b1 & rdy;
        DATA_IN1_0_DATA_R7_5 : rd = 1'b0 ;
        DATA_R6_2 : rd = 1'b1 & rdy;
        DATA_IN3_0_DATA_R7 : rd = 1'b1 & rdy;
        DATA_IN0_DATA_R7_4 : rd = 1'b0 ;
        DATA_R5_1 : rd = 1'b1 & rdy;
        DATA_IN2_0_DATA_R7_6 : rd = 1'b0 ;
        DATA_R7_3 : rd = 1'b1 & rdy;
        default : rd = 1'b0 ;
    endcase
end

always @(*) begin
    case (state)
        START : dmod = 5'b0 ;
        DATA_IN4_0 : dmod = data_in[4:0] ;
        DATA_IN1_0_DATA_R7_5 : dmod = {data_in[1:0], buffer[7:5]};
        DATA_R6_2 : dmod = buffer[6:2] ;
        DATA_IN3_0_DATA_R7 : dmod = {data_in[3:0], buffer[7]} ;
        DATA_IN0_DATA_R7_4 : dmod = {data_in[0], buffer[7:4]} ;
        DATA_R5_1 : dmod = buffer[5:1] ;
        DATA_IN2_0_DATA_R7_6 : dmod = {data_in[2:0], buffer[7:6]};
        DATA_R7_3 : dmod = buffer[7:3] ;
        default : dmod = 5'b0 ;
    endcase
end

//state control
always @ (posedge clk or negedge reset_n)begin
    if(!reset_n) begin
        state <= START;
        buffer <= 7'b0;
        mod_en <= 1'b0;
    end else if (rdy) begin
        state <= next_state;
        buffer <= data_in;
        mod_en <= rdy;
    end
end

endmodule

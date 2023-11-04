module sequence_detector
(
    input logic A,B,
    input logic clr,clk,
    output logic Z 
);

parameter SX0 = 3'b000;
parameter S00 = 3'b001;
parameter S01 = 3'b010;
parameter S011 = 3'b011;
parameter S0111 = 3'b100;



// typedef enum {
//     SX0 ,
//     S00 ,
//     S01 ,
//     S011 ,
//     S0111  
// } state_t;

reg [3:0] current_state,next_state;
reg out_mealy=0;

// initial set up
initial begin
    current_state=S00;
    next_state=S00;
end

// state transition
always @(posedge clk or negedge clr)begin
    if(!clr)begin
        current_state<=S00;
    end
    else begin
        current_state<=next_state;
    end
end

//Next state and output logic 
always @(*)begin
    out_mealy = 0;
    case(current_state)
        SX0:
            begin
                if(A==1'b1 && B==1'b1)
                    next_state = S011;
                else if(A==1'b1 && B==1'b0)
                    next_state = SX0;
                else if(A==1'b0 && B==1'b1)
                    next_state = S01;
                else if(A==1'b0 && B==1'b0)
                    next_state = SX0;
            end
        S00:
            begin
                if(A==1'b1 && B==1'b1)
                    next_state = S00;
                else if(A==1'b1 && B==1'b0)
                    next_state = SX0;
                else if(A==1'b0 && B==1'b1)
                    next_state = S01;
                else if(A==1'b0 && B==1'b0)
                    next_state = SX0;
            end
        S01:
            begin
                if(A==1'b1 && B==1'b1)
                    next_state = S0111;
                else if(A==1'b1 && B==1'b0)
                    next_state = SX0;
                else if(A==1'b0 && B==1'b1)
                    next_state = S01;
                else if(A==1'b0 && B==1'b0)
                    next_state = SX0;
            end
        S011:
            begin
                if(A==1'b1 && B==1'b1)
                    next_state = S00;
                else if(A==1'b1 && B==1'b0)begin
                    next_state = S00;
                    out_mealy=1;
                end
                else if(A==1'b0 && B==1'b1)
                    next_state = S01;
                else if(A==1'b0 && B==1'b0)
                    next_state = SX0;
            end
        S0111:
            begin
                if(A==1'b1 && B==1'b1)
                    next_state = S00;
                else if(A==1'b1 && B==1'b0)begin
                    next_state = SX0;
                end
                else if(A==1'b0 && B==1'b1)begin
                    next_state = S00;
                    out_mealy=1;
                end
                else if(A==1'b0 && B==1'b0)begin
                    next_state = SX0;
                    out_mealy=1;
                end
            end
    endcase
    Z=out_mealy;
end

endmodule
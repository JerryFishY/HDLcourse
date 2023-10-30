/**
 * ALU Core module performs arithmetic and logical operations on two operands.
 * It supports addition, subtraction, and logical operations such as AND, OR, and XOR.
 * The module takes two operands opA and opB, operation selection signals S,M,Cin.
 * The output of the module includes the result DO, a carry output C, an overflow output V, a sign output N, and a 
 * zero output Z.
 * The result of the operation is stored in DO, and the carry output is stored in C, the carry bit is cleared after 
 * logical operation.
 * The overflow output V is set if the result of the operation overflows, this bit is cleared after logical 
 * operation.
 * The sign output N is set if the result of the operation is negative.
 * The zero output Z is set if the result of the operation is zero.
 */
module alu_core #(
parameter n = 32
) (
input wire [n-1 : 0] opA,    //operand A
opB ,                        //operand B
input wire [3 : 0]S ,        //operation select
input wire M ,               //logical mode
Cin ,                        //Ci
output reg [n-1 : 0] DO ,    //output data
output reg C ,               //carry
V ,                          //overflow
N ,                          //sign
Z                            //zero
);


always@(*) begin

    case ({Cin,M})
        2'b10 : begin
            //logical op
            DO=({(n-1){S[3]}}&opA&opB)|({(n-1){S[2]}}&opA&~opB)|({(n-1){S[1]}}&~opA&opB)|({(n-1){S[0]}}&~opA&~opB);
            C=0;
            V=0;
            N=DO[n-1];
        end
        2'b01 : begin
            // addition op
            {C,DO}={1'b0,opA}+{1'b0,opB};
            V=C^DO[n-1];
            N=DO[n-1];
        end
        2'b11 : begin
            // subtraction op
            {C,DO}={1'b0,opA}+~{1'b0,opB}+1;
            V=C^DO[n-1];
            N=DO[n-1];
        end
        default :  begin
            DO = 0;
            C = 0;
            V = 0;
            N = 0;
            Z = 1;
        end
    endcase
    Z=(DO==0);
end   

endmodule
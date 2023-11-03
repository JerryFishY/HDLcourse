module shifter_4bit
(
    input  [3:0]  D,      // 4-bit data input
    input         D_sr,   // MSB data when shifting right
    input         D_sl,   // LSB data when shifting left
    input         ld,     // load control signal
    input         sr,     // shift right control signal
    input         sl,     // shift left control signal
    input         clk,    // clock
    output reg [3:0] Q    // 4-bit data output

);
always @(posedge clk)begin
    if (ld) begin
        Q <= D;
    end else if (sr) begin
        Q <= {D_sr, Q[3:1]};
    end else if (sl) begin
        Q <= {Q[2:0], D_sl};
    end

end

endmodule

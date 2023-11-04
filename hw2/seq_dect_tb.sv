// a module that could detect sequence 01110
module tb_sequence_detector;

reg clr, clk, A, B; 
wire Z;

sequence_detector uut (
    .clr(clr),
    .clk(clk),
    .A(A),
    .B(B),
    .Z(Z)
);

initial begin
    $dumpfile("wave.vcd");   // Specify the VCD file name
    $dumpvars(0, tb_sequence_detector); // Dump 

    clr = 0;
    clk = 0;
    A = 0;
    B = 0;
    #10 clr = 1;

    // Test with a sequence: 01 10 11 10 01 01 01 10
    #10 A=0; B=1; //01
    #10 A=1; B=0; //10
    #10 A=1; B=1; //11
    #10 A=1; B=0; //10
    #10 A=1; B=0; //01
    #10 A=1; B=1; //11
    #10 A=1; B=0; //10
    #10 A=1; B=0; //10

    #10 $finish;
end

always #5 clk = ~clk; // Clock generator

endmodule

module alu_core_tb;

    // Inputs
    reg [31:0] opA;
    reg [31:0] opB;
    reg [3:0] S;
    reg M;
    reg Cin;

    // Outputs
    wire [31:0] DO;
    wire C;
    wire V;
    wire N;
    wire Z;

    // Instantiate the Device Under Test (DUT)
    alu_core #(
        .n(32)
    ) dut (
        .opA(opA),
        .opB(opB),
        .S(S),
        .M(M),
        .Cin(Cin),
        .DO(DO),
        .C(C),
        .V(V),
        .N(N),
        .Z(Z)
    );

    initial begin
        // Initialize Inputs
        opA = 32'h00000001;
        opB = 32'h00000001;
        S = 4'b0000;
        M = 0;
        Cin = 0;

        // Wait 100 ns for global reset to finish
        #100;

        // Add Test
        S = 4'b1001;
        opA = 32'h00000001;
        opB = 32'h00000001;
        M=1;
        Cin=0;
        #10;
        $display("Add Test: %d+%d=%d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        //Carry Test
        S = 4'b1001;
        opA = 32'hF0000001;
        opB = 32'hF0000001;
        M=1;
        Cin=0;
        #10;
        $display("Carry Test: %d+%d=%d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        //Overflow Test
        S = 4'b1001;
        opA = 32'hA0000001;
        opB = 32'hA0000001;
        M=1;
        Cin=0;
        #10;
        $display("Overflow Test: %d+%d=%d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        //Zero Test
        S = 4'b1001;
        opA = 32'h0;
        opB = 32'h0;
        M=1;
        Cin=0;
        #10;
        $display("Zero Test: %d+%d=%d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        // Subtract Test
        S = 4'b0011;
        opA = 32'h00000002;
        opB = 32'h00000001;
        M=1;
        Cin=1;
        #10;
        $display("Subtract Test: %d - %d = %d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        // And Test
        S = 4'b1000;
        opA = 32'h0000000F;
        opB = 32'h00000001;
        M=0;
        Cin=1;
        #10;
        $display("And Test: %d & %d = %d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        // Or Test
        S = 4'b1110;
        opA = 32'h0000000F;
        opB = 32'h00000001;
        M=0;
        Cin=1;
        #10;
        $display("Or Test: %d | %d = %d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        // Xor Test
        S = 4'b0110;
        opA = 32'h0000000F;
        opB = 32'h00000001;
        M=0;
        Cin=1;
        #10;
        $display("Xor Test: %d ^ %d = %d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        // Nand Test
        S = 4'b0111;
        opA = 32'h0000000F;
        opB = 32'h00000001;
        M=0;
        Cin=1;
        #10;
        $display("Nand Test: %d nand %d = %d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        // Nor Test
        S = 4'b0001;
        opA = 32'h0000000F;
        opB = 32'h00000001;
        M=0;
        Cin=1;
        #10;
        $display("Nor Test: %d nor %d = %d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        // transfer A Test
        S = 4'b1100;
        opA = 32'h0000000F;
        opB = 32'h00000001;
        M=0;
        Cin=1;
        #10;
        $display("transfer A Test: %d op %d = %d", opA, opB, DO);
        $display("C: %d, V: %d, N: %d, Z: %d", C, V, N, Z);

        // End Simulation
        #10;
        $finish;
    end

endmodule
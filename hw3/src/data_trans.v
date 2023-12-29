/*
A module that transfer the whole 8 bytes for fifo.
*/
module data_trans(
    input wire reset_n,        // Asynchronous reset
    input wire clk,            // Clock signal
    input wire start,          // Start signal
    input wire [7:0] data_in,  // 8-bit data input
    input wire byt,            // Byte-validity indicator
    output reg [7:0] data_o,   // 8-bit data output
    output reg data_en         // Output enable
);

// Internal variables to store intermediate data and a flag to indicate half-byte received
reg [3:0] half_data;
reg half_byte_received;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        // Asynchronous reset
        data_o <= 8'b0;
        data_en <= 0;
        half_data <= 4'b0;
        half_byte_received <= 0;
    end
    else if (start) begin
        if (byt) begin
            // If byt is 1, all 8 bits are valid
            if(!half_byte_received) begin
            data_o <= data_in;
            data_en <= 1; // Data is valid
            end else begin
                data_o <= {half_data,data_in[7:4]};
                data_en <= 1; // Data is valid
                half_byte_received <= 1;
                half_data <= data_in[3:0];
            end
        end else begin
            if (!half_byte_received) begin
                // Store the first half byte
                half_data <= data_in[3:0];
                half_byte_received <= 1;
                data_en <= 0; // Data is not yet valid
            end else begin
                // Combine with the second half byte
                data_o <= {half_data, data_in[3:0]};
                half_byte_received <= 0;
                data_en <= 1; // Data is now valid
            end
        end
    end else begin
        data_o <= 8'b0;
        data_en <= 0; // No valid data
    end
end

endmodule

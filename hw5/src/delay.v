/*
To wait for the clk_osc, when clk_osc is stable, switch is set to 1
*/
module delay (
    input wire POR_n,       // system reset signal
    input wire clk_RC,      // RC clock signal
    output reg switch       // switch signal, to indicate the
);
    reg reg0,reg1;
    reg [7:0] cnt;
    always @(posedge clk_RC, negedge POR_n) begin
        if(!POR_n) begin
            reg0 <= 0;
            reg1 <= 0;
        end
        else begin
            reg0 <= 1;
            reg1 <= reg0;
        end
    end
    always @(posedge clk_RC, negedge reg1) begin
        if(!reg1) begin
            cnt <= 0;
        end
        else begin
            if(cnt<8'h80)begin
            cnt <= cnt + 1;
            end
            else begin
                cnt<=cnt;
            end
        end
    end
    always @(*) begin
        if(cnt==8'h80)begin
            switch = 1;
        end
        else begin
            switch = 0;
        end
    end
endmodule
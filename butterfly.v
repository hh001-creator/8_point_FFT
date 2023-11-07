module butterfly(
    input signed [15:0] x1_r,
    input signed [15:0] x1_i,
    input signed [15:0] x2_r,
    input signed [15:0] x2_i,
    input signed [15:0] w_r,
    input signed [15:0] w_i,
    input clk,
    input start,
    output signed [15:0] y1_r,
    output signed [15:0] y1_i,
    output signed [15:0] y2_r,
    output signed [15:0] y2_i
    );
    reg signed [15:0] y1_r_reg, y1_i_reg, y2_r_reg, y2_i_reg;
    assign y1_r = y1_r_reg;
    assign y1_i = y1_i_reg;
    assign y2_r = y2_r_reg;
    assign y2_i = y2_i_reg;
    always @(posedge clk) begin
        if(start == 1) begin
            y1_r_reg = x1_r + x2_r;
            y1_i_reg = x1_i + x2_i;
            y2_r_reg = (x1_r - x2_r) * w_r - (x1_i - x2_i) * w_i;
            y2_i_reg = (x1_r - x2_r) * w_i + (x1_i - x2_i) * w_r;
        end
        else begin
            y1_r_reg = 0;
            y1_i_reg = 0;
            y2_r_reg = 0;
            y2_i_reg = 0;
        end
    end

endmodule

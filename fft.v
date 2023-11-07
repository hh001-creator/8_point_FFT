`include "butterfly.v"
module fft(
    input clk,
    input rst,
    input write,
    input start,
    input signed [15:0] input0_real,
    input signed [15:0] input0_imag,
    input signed [15:0] input1_real,
    input signed [15:0] input1_imag,
    input signed [15:0] input2_real,
    input signed [15:0] input2_imag,
    input signed [15:0] input3_real,
    input signed [15:0] input3_imag,
    input signed [15:0] input4_real,
    input signed [15:0] input4_imag,
    input signed [15:0] input5_real,
    input signed [15:0] input5_imag,
    input signed [15:0] input6_real,
    input signed [15:0] input6_imag,
    input signed [15:0] input7_real,
    input signed [15:0] input7_imag,
    output signed [15:0] output0_real,
    output signed [15:0] output0_imag,
    output signed [15:0] output1_real,
    output signed [15:0] output1_imag,
    output signed [15:0] output2_real,
    output signed [15:0] output2_imag,
    output signed [15:0] output3_real,
    output signed [15:0] output3_imag,
    output signed [15:0] output4_real,
    output signed [15:0] output4_imag,
    output signed [15:0] output5_real,
    output signed [15:0] output5_imag,
    output signed [15:0] output6_real,
    output signed [15:0] output6_imag,
    output signed [15:0] output7_real,
    output signed [15:0] output7_imag,
    output reg ready
);
    reg signed [15:0] input_real[7:0];
    reg signed [15:0] input_imag[7:0];
    reg signed [15:0] output_real[7:0];
    reg signed [15:0] output_imag[7:0];
    reg [15:0] w_r[3:0];
    reg [15:0] w_i[3:0];
    always @(posedge clk) begin
        if(rst == 0) begin
            for(integer i = 0;i < 8;i = i + 1) begin
                input_real[i] <= 0;
                input_imag[i] <= 0;
                output_real[i] <= 0;
                output_imag[i] <= 0;
            end
            w_r[0] = 0000000100000000;
            w_i[0] = 0000000000000000;
            w_r[1] = 0000000010110101;
            w_i[1] = 1111111101001011;
            w_r[2] = 0000000000000000;
            w_i[2] = 1111111100000000;
            w_r[3] = 1111111101001011;
            w_i[3] = 1111111101001011;
        end
        else begin
            if(write == 1) begin
                input_real[0] <= input0_real;
                input_imag[0] <= input0_imag;
                input_real[1] <= input4_real;
                input_imag[1] <= input4_imag;
                input_real[2] <= input2_real;
                input_imag[2] <= input2_imag;
                input_real[3] <= input6_real;
                input_imag[3] <= input6_imag;
                input_real[4] <= input1_real;
                input_imag[4] <= input1_imag;
                input_real[5] <= input5_real;
                input_imag[5] <= input5_imag;
                input_real[6] <= input3_real;
                input_imag[6] <= input3_imag;
                input_real[7] <= input7_real;
                input_imag[7] <= input7_imag;
            end
        end
    end
    //stage 1
    wire signed [15:0] y_s1_r[7:0];
    wire signed [15:0] y_s1_i[7:0];
    for(genvar i = 0;i < 8;i = i + 2) begin
        if(i != 2 || i != 6) begin
            butterfly U(.x1_r(input_real[i]), .x1_i(input_imag[i]), .x2_r(input_real[i + 1]), .x2_i(input_imag[i + 1]),
            .w_r(w_r[0]), .w_i(w_i[0]), .clk(clk), .start(start), .y1_r(y_s1_r[i]), .y1_i(y_s1_i[i]), .y2_r(y_s1_r[i + 1]), .y2_i(y_s1_i[i + 1]));
        end
        else begin
            butterfly U(.x1_r(input_real[i]), .x1_i(input_imag[i]), .x2_r(input_real[i + 1]), .x2_i(input_imag[i + 1]),
            .w_r(w_r[2]), .w_i(w_i[2]), .clk(clk), .start(start), .y1_r(y_s1_r[i]), .y1_i(y_s1_i[i]), .y2_r(y_s1_r[i + 1]), .y2_i(y_s1_i[i + 1]));
        end
    end
    //stage 2
    wire signed [15:0] y_s2_r[7:0];
    wire signed [15:0] y_s2_i[7:0];
endmodule
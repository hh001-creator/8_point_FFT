`include "butterfly.v"
`timescale 1ns/1ps
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
    reg signed [15:0] w_r[3:0];
    reg signed [15:0] w_i[3:0];
    integer k, l;
    always @(posedge clk) begin
        if(rst == 0) begin
            l = 0;
            ready = 0;
            for(k = 0;k < 8;k = k + 1) begin
                input_real[k] <= 0;
                input_imag[k] <= 0;
                output_real[k] <= 0;
                output_imag[k] <= 0;
            end
            w_r[0] = 16'b0000000100000000;
            w_i[0] = 16'b0000000000000000;
            w_r[1] = 16'b0000000010110101;
            w_i[1] = 16'b1111111101001011;
            w_r[2] = 16'b0000000000000000;
            w_i[2] = 16'b1111111100000000;
            w_r[3] = 16'b1111111101001011;
            w_i[3] = 16'b1111111101001011;
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
        l = l + 1;
        if(l == 5) begin
            ready = 1;
            l = 0;
        end
    end
    //stage 1
    genvar i;
    wire signed [15:0] y_s1_r[7:0];
    wire signed [15:0] y_s1_i[7:0];
    for(i = 0;i < 8;i = i + 2) begin
        
            butterfly U(.x1_r(input_real[i]), .x1_i(input_imag[i]), .x2_r(input_real[i + 1]), .x2_i(input_imag[i + 1]),
            .w_r(w_r[0]), .w_i(w_i[0]), .clk(clk), .start(start), .y1_r(y_s1_r[i]), .y1_i(y_s1_i[i]), .y2_r(y_s1_r[i + 1]), .y2_i(y_s1_i[i + 1]));
        
    end
    //stage 2
    wire signed [15:0] y_s2_r[7:0];
    wire signed [15:0] y_s2_i[7:0];
    for(i=0;i < 4;i = i+1) begin
        if(i % 2 == 0)begin
            butterfly U(.x1_r(y_s1_r[2*i]), .x1_i(y_s1_i[2*i]), .x2_r(y_s1_r[2*(i + 1)]), .x2_i(y_s1_i[2*(i + 1)]),
            .w_r(w_r[0]), .w_i(w_i[0]), .clk(clk), .start(start), .y1_r(y_s2_r[2*i]), .y1_i(y_s2_i[2*i]), .y2_r(y_s2_r[2*(i + 1)]), .y2_i(y_s2_i[2*(i + 1)]));
        end
        else begin
            butterfly U(.x1_r(y_s1_r[2*i-1]), .x1_i(y_s1_i[2*i-1]), .x2_r(y_s1_r[2*(i)+ 1]), .x2_i(y_s1_i[2*(i) + 1]),
            .w_r(w_r[2]), .w_i(w_i[2]), .clk(clk), .start(start), .y1_r(y_s2_r[2*i-1]), .y1_i(y_s2_i[2*i-1]), .y2_r(y_s2_r[2*(i) + 1]), .y2_i(y_s2_i[2*(i) + 1]));
        end
    end
    //stage 3
    wire signed [15:0] y_s3_r[7:0];
    wire signed [15:0] y_s3_i[7:0];

    for(i=0;i<4;i=i+1) begin
        butterfly U(.x1_r(y_s2_r[i]), .x1_i(y_s2_i[i]), .x2_r(y_s2_r[i + 4]), .x2_i(y_s2_i[i + 4]),
            .w_r(w_r[i]), .w_i(w_i[i]), .clk(clk), .start(start), .y1_r(y_s3_r[i]), .y1_i(y_s3_i[i]), .y2_r(y_s3_r[i + 4]), .y2_i(y_s3_i[i + 4]));
    end
    assign output0_real=y_s3_r[0];
    assign output0_imag=y_s3_i[0];
    assign output1_real=y_s3_r[1];
    assign output1_imag=y_s3_i[1];
    assign output2_real=y_s3_r[2];
    assign output2_imag=y_s3_i[2];
    assign output3_real=y_s3_r[3];
    assign output3_imag=y_s3_i[3];
    assign output4_real=y_s3_r[4];
    assign output4_imag=y_s3_i[4];
    assign output5_real=y_s3_r[5];
    assign output5_imag=y_s3_i[5];
    assign output6_real=y_s3_r[6];
    assign output6_imag=y_s3_i[6];
    assign output7_real=y_s3_r[7];
    assign output7_imag=y_s3_i[7];
endmodule
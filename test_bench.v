`include "fft.v"
`timescale 1ns/1ps
module test();
    reg clk, rst, write, start;
    reg signed [15:0] input0_real, input0_imag;
    reg signed [15:0] input1_real, input1_imag;
    reg signed [15:0] input2_real, input2_imag;
    reg signed [15:0] input3_real, input3_imag;
    reg signed [15:0] input4_real, input4_imag;
    reg signed [15:0] input5_real, input5_imag;
    reg signed [15:0] input6_real, input6_imag;
    reg signed [15:0] input7_real, input7_imag;
    wire signed [15:0] output0_real, output0_imag;
    wire signed [15:0] output1_real, output1_imag;
    wire signed [15:0] output2_real, output2_imag;
    wire signed [15:0] output3_real, output3_imag;
    wire signed [15:0] output4_real, output4_imag;
    wire signed [15:0] output5_real, output5_imag;
    wire signed [15:0] output6_real, output6_imag;
    wire signed [15:0] output7_real, output7_imag;

    fft U0(.clk(clk), .rst(rst), .write(write), .start(start), .input0_real(input0_real), .input0_imag(input0_imag), .input1_real(input1_real), .input1_imag(input1_imag),
    .input2_real(input2_real), .input2_imag(input2_imag), .input3_real(input3_real), .input3_imag(input3_imag), .input4_real(input4_real), .input4_imag(input4_imag),
    .input5_real(input5_real), .input5_imag(input5_imag), .input6_real(input6_real), .input6_imag(input6_imag), .input7_real(input7_real), .input7_imag(input7_imag),
    .output0_real(output0_real), .output0_imag(output0_imag), .output1_real(output1_real), .output1_imag(output1_imag), .output2_real(output2_real), .output2_imag(output2_imag),
    .output3_real(output3_real), .output3_imag(output3_imag), .output4_real(output4_real), .output4_imag(output4_imag), .output5_real(output5_real), .output5_imag(output5_imag),
    .output6_real(output6_real), .output6_imag(output6_imag), .output7_real(output7_real), .output7_imag(output7_imag));
    initial begin
        clk = 0;
        #10 rst = 0;
        write = 0;
        #10 start = 0;
        input0_real = 16'b0000000000000000;
        input1_real = 16'b0000000100000000;
        input2_real = 16'b0000001000000000;
        input3_real = 16'b0000001100000000;
        input4_real = 16'b0000010000000000;
        input5_real = 16'b0000010100000000;
        input6_real = 16'b0000011000000000;
        input7_real = 16'b0000011100000000;
        input0_imag = 16'b0000000000000000;
        input1_imag = 16'b0000000000000000;
        input2_imag = 16'b0000000000000000;
        input3_imag = 16'b0000000000000000;
        input4_imag = 16'b0000000000000000;
        input5_imag = 16'b0000000000000000;
        input6_imag = 16'b0000000000000000;
        input7_imag = 16'b0000000000000000;
        #10 rst = 1;
        #10 write = 1;
        #10 start = 1;
        #10 write = 0;
    end
    always #5 clk = ~clk;

    initial begin
        $dumpfile("fft.vcd");
        $dumpvars(0, test);
        #200 $finish;
    end
    initial begin
        $display("X[0]_real = %b, X[0]_imag = %b", output0_real, output0_imag);
        $display("X[1]_real = %b, X[1]_imag = %b", output1_real, output1_imag);
        $display("X[2]_real = %b, X[2]_imag = %b", output2_real, output2_imag);
        $display("X[3]_real = %b, X[3]_imag = %b", output3_real, output3_imag);
        $display("X[4]_real = %b, X[4]_imag = %b", output4_real, output4_imag);
        $display("X[5]_real = %b, X[5]_imag = %b", output5_real, output5_imag);
        $display("X[6]_real = %b, X[6]_imag = %b", output6_real, output6_imag);
        $display("X[7]_real = %b, X[7]_imag = %b", output7_real, output7_imag);
    end
endmodule
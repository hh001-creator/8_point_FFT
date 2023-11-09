`timescale 1ns/1ps
`include "butterfly.v"
module test();
reg [15:0] x1_r, x1_i, x2_r, x2_i, w_r, w_i;  
reg clk, start;
wire [15:0] y1_r, y1_i, y2_r, y2_i;

butterfly butterfly_inst(
    .x1_r(x1_r),
    .x1_i(x1_i),
    .x2_r(x2_r),
    .x2_i(x2_i),
    .w_r(w_r),
    .w_i(w_i),
    .clk(clk),
    .start(start),
    .y1_r(y1_r),
    .y1_i(y1_i),
    .y2_r(y2_r),
    .y2_i(y2_i)
);

initial begin
    clk = 0;
    start = 0;
    x1_r = 16'b1111110000000000; // -4
    x1_i = 16'b0000000000000000; // 0
    x2_r = 16'b0000001000000000; // 2
    x2_i = 16'b0000000000000000; // 0
    w_r = 16'b0000000010110101; // 0.707
    w_i = 16'b1111111101001011; // -0.707
end

always begin
    #5 clk = ~clk;
end

initial begin
    #10 start = 1;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, butterfly_inst);
end
initial begin
    $monitor("y1_r = %b, y1_i = %b, y2_r = %b, y2_i = %b", y1_r[15:0], y1_i, y2_r, y2_i);
    #100 $finish;
end

endmodule
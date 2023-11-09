module test();
    reg signed [15:0] x1_r;
    reg signed [15:0] x1_i;
    reg signed [15:0] x2_r;
    reg signed [15:0] x2_i;
    reg signed [15:0] w_r;
    reg signed [15:0] w_i;
    reg signed [63:0] x3;
    initial begin
    x1_r = 16'b1111110100000000; // -3
    x1_i = 16'b0000000000000000; // 0
    x2_r = 16'b0000001000000000; // 2
    x2_i = 16'b0000000000000000; // 0
    w_r = 16'b0000000010110101; // 0.707
    w_i = 16'b1111111101001011; // -0.707
        x3 = ((x2_r * w_r)) >> 8;
        x3 = x3 + (x1_r);
        $display("x1 = %0b %0d , x2 = %0b %0d, w = %0b %0d, x3 = %b %0d", x1_r, x1_r, x2_r, x2_r, w_r, w_r, x3[15:0], x3);
    end
    endmodule
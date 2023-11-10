module test();
    real n;
    reg signed [15:0] x1_r;
    reg signed [7:0] dec;
    reg sign;
    real float;
    reg [15:0] fix_num;
    initial begin
        x1_r = 1 * 256;
        //x = $urandom_range(-126, 127);
        dec = x1_r[15:8];
        float = x1_r[7:0] / (256.0);
        $display("n = %b, %d, %f", x1_r, dec, float);
    end
endmodule
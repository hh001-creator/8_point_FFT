module test();
    real n;
    reg signed [15:0] x;
    reg signed [7:0] dec;
    reg sign;
    real float;
    reg [15:0] fix_num;
    initial begin
        x = -(1) * (2**8);
        //x = $urandom_range(-126, 127);
        dec = x[15:8];
        float = x[7:0] / (256.0);
        $display("n = %b, %d, %f", x, dec, float);
    end
endmodule
module RegisterB10bit(in, en, rst, clk, out, dvz);
    parameter N = 10;

    input [N-1:0] in;
    input  en, clk, rst;

    output reg [N-1:0] out;
    output  dvz;


    assign dvz = (in == 0) ? 1'b1 : 1'b0 ;

    always @(posedge clk ) begin
        if (rst)
            out <= 10'b0000000000;
  
        else if (en)
            out <= in;
    end

endmodule

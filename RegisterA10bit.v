module RegisterA10bit(in, en, rst, clk, out);
    parameter N = 10;

    input [N-1:0] in;
    input  en, clk, rst;

    output reg [N-1:0] out;

    always @(posedge clk) begin
        if (rst)
            out <= {N{10'b0}};
 	 
        else if (en)
            out <= in;
    end

endmodule

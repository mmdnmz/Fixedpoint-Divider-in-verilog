module bit_counter(clk, cen, rst, out);

input clk, cen, rst;
output reg [3:0] out;

always @(posedge clk , rst ) 

  begin

    if(rst) out <= 4'b0000;

    else if(cen) out <= out + 1;

  end
endmodule

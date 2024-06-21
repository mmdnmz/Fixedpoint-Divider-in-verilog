module Mux3to1_11bit(slc, a, b, c, w);
    parameter N = 11;
    
    input [1:0] slc;
    input [N-1:0] a, b, c;

    output [N-1:0] w;
    
    assign w = (slc == 2'b00) ? a : (slc == 2'b01) ? b : (slc == 2'b10) ? c : 11'bz; 

endmodule


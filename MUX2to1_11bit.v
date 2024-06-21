module Mux2to1_11bit(slc, a, b, w);
    parameter N = 11;
    
    input slc;
    input [N-1:0] a, b;

    output [N-1:0] w;
    
    assign w = ~slc ? a : b;

endmodule

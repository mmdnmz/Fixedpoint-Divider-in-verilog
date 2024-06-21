module Mux2to1_1bit(slc, a, b, w);
    
    
    input slc;
    input  a, b;

    output  w;
    
    assign w = ~slc ? a : b;

endmodule

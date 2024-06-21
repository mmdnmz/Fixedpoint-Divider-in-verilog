module comperator(input[10:0] a,b,output ge);
  assign ge = a >= b ? 1'b1 : 1'b0;
endmodule

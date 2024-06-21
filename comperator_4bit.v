module comperator_4bit(input[3:0] i,output eq9, output eq14);
  assign eq9  = i >= 9  ? 1'b1 : 1'b0;
  assign eq14 = i == 14 ? 1'b1 : 1'b0;
endmodule
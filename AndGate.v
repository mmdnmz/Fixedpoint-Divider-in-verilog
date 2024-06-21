module ANDer(in1, in2, flagout);
  input [5:0] in1;
  input in2;
  output flagout;
  assign flagout = in1 && in2;

endmodule
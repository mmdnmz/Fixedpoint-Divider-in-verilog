`timescale 1ns/1ns
module TB();

reg [9:0] A_in, B_in;
reg start , sclr , clk;

wire[9:0] Q_out;
wire busy , valid;

Mivider DUT(.A_in(A_in) , .B_in(B_in) , .start(start) , .sclr(sclr) , .clk(clk));

always #5 clk <= ~clk ;

initial begin

    clk=1'b0;
    start=1'b0;
    sclr=1'b0;
    A_in=10'b0001000000;
    B_in=10'b0000100000;
    #13 start=1'b1;
    #23 start=1'b0;
    #1000 $stop;
end
endmodule 
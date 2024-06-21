module Mydivider(A_in, B_in, ldQ, ldQnext, ldACC, ldACCnext,
                 enB, enA, cen, sclrA, rstc, Q_out, dvz,
                 sel3, sclr, clk, sel1, sel2, sel4, ldA, ldB, ge, sel5, flagout, eq9, eq14);

input [9:0] A_in, B_in;
input [1:0] sel3;

input ldQ, ldQnext, ldACC, ldACCnext, enB, enA, cen, ldA, ldB, sclrA, rstc, sclr, clk, sel1, sel2, sel4, sel5;

output [9:0] Q_out;
output dvz, ge, flagout, eq9, eq14;


wire [9:0] outA, outB, outmuxAandQnext, outQnext;

wire [10:0] outACC, outmuxelevenbit, Accnextout, subout, outmainmux, outkatdi;

wire [3:0] pout;

wire outmuxoneOrzero, outmaincomp, cen;

RegisterA10bit A (.in(A_in), .en(ldA), .rst(sclrA), .clk(clk), .out(outA));

RegisterB10bit B (.in(B_in), .en(ldB), .rst(sclrB), .clk(clk), .out(outB), .dvz(dvz));

RegisterA10bit Q (.in(outmuxAandQnext), .en(ldQ), .rst(rst), .clk(clk), .out(Q_out));

RegisterA10bit Qnext (.in({Q_out[8:0],outmuxoneOrzero}), .en(ldQnext), .rst(rst), .clk(clk), .out(outQnext));

Register11bit ACCnext (.in(outmainmux), .en(ldACCnext), .rst(rst), .clk(clk), .out(Accnextout));

Register11bit ACC (.in(outmuxelevenbit), .en(ldACC), .rst(rst), .clk(clk), .out(outACC));

Mux2to1_10bit AandQnext (.slc(sel1), .a({outA[8:0],1'b0}), .b(outQnext), .w(outmuxAandQnext));

Mux2to1_1bit oneOrzero (.slc(sel2), .a(1'b0), .b(1'b1), .w(outmuxoneOrzero));

Mux2to1_11bit elevenbit (.slc(sel4), .a(Accnextout), .b({10'b0,outA[9]}), .w(outmuxelevenbit));

Mux2to1_11bit katdi   (.slc(sel5), .a(outmuxelevenbit), .b(outACC), .w(outkatdi));


comperator maincomp (.a(outkatdi),.b({1'b0,outB}),.ge(ge));

Mux3to1_11bit mainmux (.slc(sel3), .a(subout), .b({Accnextout[9:0],Q_out[9]}), .c({outACC[9:0],Q_out[9]}), .w(outmainmux));

comperator_4bit cum (.i(pout), .eq9(eq9), .eq14(eq14));

bit_counter bitcount (.clk(clk), .rst(rstc), .cen(cen), .out(pout));

ANDer alland (.in1({outQnext[9:4]}), .in2(eq9), .flagout(flagout));

sub amiz (.a(outACC), .b({1'b0,outB}), .c(subout));

endmodule

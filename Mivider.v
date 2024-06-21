module Mivider(clk, A_in, B_in, start, sclr);
    input clk, A_in, B_in, start, sclr;
    
    wire [9:0] A_in, B_in;
    wire [1:0] sel3;

    wire ldQ, ldQnext, ldACC, ldACCnext, ldB, ldA, cen,
         sclrA, rstc, start, sclr, clk, sel1, sel2,
         sel4, sel5, flagout, valid, busy, outmuxoneOrzero,
         outmaincomp, eq9, eq14;

    wire [9:0] Q_out;
    wire dvz, ge;


    controller CUM  (.start(start), .clk(clk), .sclr(sclr), .dvz(dvz), .ge(ge), .flagout(flagout),
                    .eq14(eq14), .eq9(eq9), .ldQ(ldQ), .ldQnext(ldQnext), .ldACC(ldACC), .ldACCnext(ldACCnext),
                    .sel1(sel1), .sel2(sel2), .sel4(sel4), .sel5(sel5), .sel3(sel3), .valid(valid), .busy(busy), .ldA(ldA),
                    .ldB(ldB), .sclrA(slcrA), .sclrB(slcrB), .rstc(rstc), .cen(cen), .ovf(ovf) );


    Mydivider DP    (.A_in(A_in), .B_in(B_in), .ldQ(ldQ), .ldQnext(ldQnext), .ldACC(ldACC), .ldACCnext(ldACCnext),
                    .enB(enB), .enA(enA), .cen(cen), .ldA(ldA), .ldB(ldB), .flagout(flagout),
                    .sclrA(slcrA), .rstc(rstc), .Q_out(Q_out), .dvz(dvz), .ge(ge),
                    .sel3(sel3), .sclr(sclr), .clk(clk), .sel1(sel1), .sel2(sel2), .sel4(sel4), .sel5(sel5), .eq9(eq9), .eq14(eq14) );
    
endmodule
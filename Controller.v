`define idle        4'b0000
`define reseting    4'b0001
`define initing     4'b0010
`define stepfor     4'b0011
`define firstif     4'b0100
`define firstiftwo  4'b0101
`define secondif    4'b0110
`define flagcheck   4'b0111
`define flagon      4'b1000
`define flagoff     4'b1001
`define vflag       4'b1011
`define waitf       4'b1101


module controller(start, clk, sclr, dvz, ge, flagout,
                 eq14, eq9, ldQ, ldQnext, ldACC, ldACCnext,
                 sel1, sel2, sel4, sel5, valid, busy, ldA,
                 ldB, sclrA, sclrB, rstc, cen, ovf, sel3);

    input start, clk, sclr, dvz, ge, flagout, eq14, eq9;

    output reg ldQ, ldQnext, ldACC, ldACCnext, sel1, sel2, sel4, valid, busy, ldA, ldB, sclrA, sclrB, rstc, cen, ovf, sel5;

    output reg [1:0] sel3;



    reg [3:0] pstate;
    reg [3:0] nstate = `idle;

    always @(*) begin
        case (pstate)

            `idle       : nstate   <= (start == 1'b1)      ? `reseting     : `idle;
            
            `reseting   : nstate   <= (start == 1'b0)      ? `initing      : `reseting;

            `initing    : nstate   <= (dvz == 1'b1)        ? `idle         : `stepfor;

            `stepfor    : nstate   <= (ge == 1'b1)         ? `firstif      : `secondif;

            `flagcheck  : nstate   <= (flagout == 1'b1)    ? `flagon       : `flagoff;

            `flagoff    : nstate   <= (eq14 == 1'b1)       ? `vflag         : `waitf;

            `waitf      : nstate   <= (ge == 1'b1)         ? `firstif      : `secondif;



            `firstif : nstate <= `firstiftwo;
            `firstiftwo: nstate <= `flagcheck;

            `secondif : nstate <= `flagcheck;

            `flagon : nstate <= `idle;

            `vflag : nstate <= `idle;


        endcase
    end


    always @(pstate) begin

        {valid, busy, sclrA, sclrB, ldA, ldB, 
                rstc, sel4, sel1, sel2, sel3, ovf, ldACCnext, ldACC, ldQnext, ldQ} <= 17'b0;

        case (pstate)
            
            `idle : begin
                valid     <= 1'b0;
                busy      <= 1'b0;
            end
           
            `reseting: begin
                ldA     <= 1'b1;
                ldB     <= 1'b1;

            end

            `initing: begin 
                rstc    <= 1'b1;
                sel5    <= 1'b0;
            end
          
            `stepfor: begin 
                busy      <= 1'b1;
                sel1      <= 1'b0;
                sel4      <= 1'b1;
                cen       <= 1'b1;
                ldQ       <= 1'b1;
                ldACC     <= 1'b1;
            end

            `waitf: begin 
                busy      <= 1'b1;
            end

            `firstif: begin
                sel3      <= 2'b00;
                busy      <= 1'b1;
                ldACCnext <= 1'b1;
                ldQnext   <= 1'b1;
            end

            `firstiftwo: begin
                sel3      <= 2'b01;
                sel2      <= 1'b1;
                ldACCnext <= 1'b1;
                ldQnext   <= 1'b1;
                busy      <= 1'b1;
            end
            
            `secondif: begin
                sel3      <= 2'b10;
                sel2      <= 1'b0;
                ldACCnext <= 1'b1;
                ldQnext   <= 1'b1;
                busy      <= 1'b1;
            end
            
            `flagcheck: begin
                busy      <= 1'b1;
            end
            
            `flagon: begin
                ovf       <= 1'b1;
                busy      <= 1'b1;
                valid     <= 1'b1;
            end

            
            `flagoff: begin
                sel4      <= 1'b0;
                sel1      <= 1'b1;
                ldACC     <= 1'b1;
                ldQ       <= 1'b1;
            end
            `vflag: begin
                valid     <= 1'b1;
                busy      <= 1'b1;
            end
        endcase
    end

        always @(posedge clk) begin
        if (sclr)
            pstate <= `idle;
        else
            pstate <= nstate;
    end

endmodule
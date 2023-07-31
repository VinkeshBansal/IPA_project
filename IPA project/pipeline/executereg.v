module executereg(clk,E_bubble,d_icode, d_ifun , d_valA,d_valB,d_valC,d_srcA,d_srcB,d_dstE,d_dstM,E_icode, E_ifun, E_valA, E_valB, E_valC, E_srcA, E_srcB, E_dstE, E_dstM);


input clk;

input [4:1] d_icode;
input [4:1] d_ifun;
input [4:1] d_dstE;
input [4:1] d_dstM;
input [4:1] d_srcA;
input [4:1] d_srcB;
input [63:0] d_valA; 
input [63:0] d_valB; 
input [63:0] d_valC; 
input E_bubble;


output reg [3:0] E_icode, E_ifun, E_dstE, E_dstM, E_srcA, E_srcB;
output reg [63:0] E_valA, E_valB, E_valC;

always @(posedge clk)
    begin
        if(E_bubble==0)
        begin
        E_icode <= d_icode;
        E_ifun <= d_ifun;
        E_dstE <= d_dstE;
        E_dstM <= d_dstM;
        E_srcA <= d_srcA;
        E_srcB <= d_srcB;
        E_valA <= d_valA;
        E_valB <= d_valB;
        E_valC <= d_valC;
        end

        else
        begin
      E_icode <= 4'b0001;
      E_ifun <= 4'b0000;
      E_valC <= 4'b0000;
      E_valA <= 4'b0000;
      E_valB <= 4'b0000;
      E_dstE <= 4'hF;
      E_dstM <= 4'hF;
      E_srcA <= 4'hF;
      E_srcB <= 4'hF;
        end

        
        end
endmodule
module decodereg(clk,D_bubble,D_stall,f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP, D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP);
input clk;
input [1:4] f_icode;
input [1:4] f_ifun;
input [1:4] f_rA;
input [1:4] f_rB;
input [1:64] f_valC;
input [1:64] f_valP;
input D_bubble,D_stall;

output reg [1:4] D_icode;
output reg [1:4] D_ifun;
output reg [1:4] D_rA;
output reg [1:4] D_rB;
output reg [1:64] D_valC;
output reg [1:64] D_valP;

always @(posedge clk ) 
    begin
        if(D_stall==0)
        begin
        D_icode <= f_icode;
        D_ifun <= f_ifun;
        D_rA <= f_rA;
        D_rB <= f_rB;
        D_valC <= f_valC;
        D_valP <= f_valP;
        end


        else if(D_bubble==1)
        begin
             D_icode <= 4'b0001;
            D_ifun <= 4'b0000;
            D_rA <= 4'b0000;
            D_rB <= 4'b0000;
            D_valC <= 64'b0;
            D_valP <= 64'b0;
            
        end
    end
endmodule
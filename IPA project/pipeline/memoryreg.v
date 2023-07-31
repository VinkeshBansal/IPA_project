module memoryreg(clk,M_bubble,e_cnd,e_icode,e_valA,e_valE,e_dstE,e_dstM,M_cnd,M_icode,M_valE,M_valA,M_dstE,M_dstM);

input clk;
input e_cnd;

input [4:1] e_icode;
input [4:1] e_dstE;
input [4:1] e_dstM;
input M_bubble;

input [64:1] e_valA,e_valE;


output reg [64:1] M_valE,M_valA;

output reg M_cnd;

output reg [4:1] M_icode;
output reg [4:1] M_dstE;
output reg [4:1] M_dstM;



always @(posedge clk)
begin
  if(M_bubble==0)
  begin
    M_valA <= e_valA;
    M_valE <= e_valE;
    M_dstE <= e_dstE;
    M_dstM <= e_dstM;
    M_cnd <= e_cnd;
    M_icode <= e_icode;
  end
  else
  begin
    M_icode <= 4'b001;
      M_cnd <= 1;
      M_valE <= 0;
      M_valA <= 0;
      M_dstE <= 4'hF;
      M_dstM <= 4'hF;
  end
end


endmodule
`timescale 1ns/10ps

module memory(clk,icode,valA,valB,valC,valE,valP,valM,ram_val);


input clk;
input [4:1]icode;
input[64:1] valA;
input[64:1] valB;
input[64:1] valC;
input[64:1] valE;
input[64:1] valP;

output reg[64:1] valM;
output reg[64:1] ram_val;

reg[64:1] ram[1024:0];

integer i; 

initial begin

 
  for ( i= 0;i<1025 ; i = i+1 ) begin
     ram[i]=64'd0;
  end

  ram[7] = 64'd5;
  ram[5] = 64'd11;
  ram[102] = 64'd6;
 
end



always @(*)
begin
    if(icode == 4'b0101) //mrmovq
    begin
        valM = ram[valE];
        ram_val = valM;
    end
    else if(icode == 4'b0100) //rmmovq
    begin
        ram[valE] = valA;
        ram_val = ram[valE];
        
    end
    else if(icode == 4'b1001) //ret
    begin
        valM = ram[valA];
        ram_val = ram[valM];
    end
    else if(icode == 4'b1000) //call
    begin
        ram[valE] = valP;
        ram_val = ram[valE];

    end
    else if(icode == 4'b1010) //pushq
    begin
        ram[valE] = valA;
        ram_val = ram[valE];
    end
    else if(icode == 4'b0100) //popq
    begin
        valM = ram[valA];
        ram_val = valM;
    end
end









endmodule
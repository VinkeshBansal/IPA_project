`timescale 1ns/10ps

module wb(clk,icode,rA,rB,cnd,valM,valE,reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14,reg_mem15,reg_memf0,reg_memf1,reg_memf2,reg_memf3,reg_memf4,reg_memf5,reg_memf6,reg_memf7,reg_memf8,reg_memf9,reg_memf10,reg_memf11,reg_memf12,reg_memf13,reg_memf14,reg_memf15);

input clk;
input cnd;
input [4:1] icode;
input [64:1] valM;
input [64:1] valE;
input [4:1] rA;
input [4:1] rB;


input  [64:1]reg_mem0;
input  [64:1]reg_mem1;
input  [64:1]reg_mem2;
input  [64:1]reg_mem3;
input  [64:1]reg_mem4;
input  [64:1]reg_mem5;
input  [64:1]reg_mem6;
input  [64:1]reg_mem7;
input  [64:1]reg_mem8;
input  [64:1]reg_mem9;
input  [64:1]reg_mem10;
input  [64:1]reg_mem11;
input  [64:1]reg_mem12;
input  [64:1]reg_mem13;
input  [64:1]reg_mem14;
input  [64:1]reg_mem15;


output reg [64:1]reg_memf0;
output reg [64:1]reg_memf1;
output reg [64:1]reg_memf2;
output reg [64:1]reg_memf3;
output reg [64:1]reg_memf4;
output reg [64:1]reg_memf5;
output reg [64:1]reg_memf6;
output reg [64:1]reg_memf7;
output reg [64:1]reg_memf8;
output reg [64:1]reg_memf9;
output reg [64:1]reg_memf10;
output reg [64:1]reg_memf11;
output reg [64:1]reg_memf12;
output reg [64:1]reg_memf13;
output reg [64:1]reg_memf14;
output reg [64:1]reg_memf15;


reg [64:1] registers[15:0];
 
initial begin

registers[0] = reg_mem0;
registers[1] = reg_mem1;
registers[2] = reg_mem2;
registers[3] = reg_mem3;
registers[4] = reg_mem4;
registers[5] = reg_mem5;
registers[6] = reg_mem6;
registers[7] = reg_mem7;
registers[8] = reg_mem8;
registers[9] = reg_mem9;
registers[10] = reg_mem10;
registers[11] = reg_mem11;
registers[12] = reg_mem12;
registers[13] = reg_mem13;
 registers[14] =reg_mem14;
registers[15] = reg_mem15;

end


always @ (posedge clk)
begin

     if(icode == 4'b0010) //cmovxx
    begin
        if(cnd == 1'b1)
        begin
            registers[rB] = valE;
        end
        else
        begin
            registers[15] = valE;
        end
    end
    else if(icode == 4'b0011)  //irmovq
    begin
        registers[rB] = valE;
    end
    else if(icode == 4'b0101) //mrmovq
    begin
        registers[rA] = valM;
    end
    else if(icode == 4'b0110) //Op
    begin
        registers[rB] = valE;
    end
    else if(icode == 4'b1000) //call
    begin
        registers[7] = valE;
    end
    else if(icode == 4'b1001) //ret
    begin
        registers[7] = valE;
    end
    else if(icode == 4'b1010) //pushq
    begin
        registers[7] = valE;
    end
    else if(icode == 4'b1011) //popq
    begin
        registers[7] = valE;
        registers[rA] = valM;
    end

reg_memf0 = registers[0];
reg_memf1 = registers[1];
reg_memf2 = registers[2];
reg_memf3 = registers[3];
reg_memf4 = registers[4];
reg_memf5 = registers[5];
reg_memf6 = registers[6];
reg_memf7 = registers[7];
reg_memf8 = registers[8];
reg_memf9 = registers[9];
reg_memf10 = registers[10];
reg_memf11 = registers[11];
reg_memf12 = registers[12];
reg_memf13 = registers[13];
reg_memf14 = registers[14];
reg_memf15 = registers[15];


end

endmodule

         
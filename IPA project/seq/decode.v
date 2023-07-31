`timescale 1ns/10ps

module decode(clk,icode,ifun,rA,rB,valA,valB,reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14,reg_mem15);

input clk;

input [4:1] icode;
input [4:1] ifun;
input [4:1] rA;
input [4:1] rB;

output  reg [64:1]valA;
output  reg [64:1]valB;
output reg [64:1]reg_mem0;
output reg [64:1]reg_mem1;
output reg [64:1]reg_mem2;
output reg [64:1]reg_mem3;
output reg [64:1]reg_mem4;
output reg [64:1]reg_mem5;
output reg [64:1]reg_mem6;
output reg [64:1]reg_mem7;
output reg [64:1]reg_mem8;
output reg [64:1]reg_mem9;
output reg [64:1]reg_mem10;
output reg [64:1]reg_mem11;
output reg [64:1]reg_mem12;
output reg [64:1]reg_mem13;
output reg [64:1]reg_mem14;
output reg [64:1]reg_mem15;



// reg rax = 4'd0;
// reg rbx = 4'd1;
// reg rcx = 4'd2;
// reg rdx = 4'd3;
// reg rsi = 4'd4;
// reg rdi = 4'd5;
// reg rbp = 4'd6;
// reg rsp = 4'd7;
// reg r8 = 4'd8;
// reg r9 = 4'd9;
// reg r10 = 4'd10;
// reg r11 = 4'd11;
// reg r12 = 4'd12;
// reg r13 = 4'd13;
// reg r14 = 4'd14;
// reg r15 = 4'd15;

 reg [64:1] registers[15:0];
initial begin

registers[0] = 64'd0;
registers[1] = 64'd1;
registers[2] = 64'd2;
registers[3] = 64'd3;
registers[4] = 64'd4;
registers[5] = 64'd5;
registers[6] = 64'd6;
registers[7] = 64'd10;
registers[8] = 64'd8;
registers[9] = 64'd9;
registers[10] = 64'd10;
registers[11] = 64'd11;
registers[12] = 64'd12;
registers[13] = 64'd13;
 registers[14] = 64'd14;
registers[15] = 64'd15;

         


end


always @ (*)
begin


//    if(icode == 4'b0000)   // halt
//    begin
    
//    end
      

    //   else if(icode == 4'b0001)   // nop
    //   begin
      
    //   end


      if(icode == 4'b0010)     //cmmovxx
     begin
        valA = registers[rA];
        valB = 64'd0;
     end


   //   else if (icode == 4'b0011)   //irmovq
   //   begin
           
   //   end

     else if (icode == 4'b0100)   // rmmovq
     begin
         valB = registers[rB];
        valA = registers[rA];
     end

  else if (icode == 4'b0101)   // mrmovq
     begin
        
        valB = registers[rB];
     end
 
 else if(icode == 4'b0110)   //opq
 begin
    valA = registers[rA];
        valB = registers[rB];
 end

// else if(icode == 4'b0111)   //jxx
// begin
     
// end


else if(icode == 4'b1000) //call
    begin
        valB = registers[7];  //rsp
    end    
    
    else if(icode == 4'b1001) //ret
    begin
       valA = registers[7];
       valB = registers[7];
    end    
    
    else if(icode == 4'b1010) //pushq
    begin
        valA = registers[rA];
       valB = registers[7];
    end    
    
    else if(icode == 4'b1011) //popq    
    begin
       valA = registers[7];
       valB = registers[7];
    end    

reg_mem0 = registers[0];
reg_mem1 = registers[1];
reg_mem2 = registers[2];
reg_mem3 = registers[3];
reg_mem4 = registers[4];
reg_mem5 = registers[5];
reg_mem6 = registers[6];
reg_mem7 = registers[7];
reg_mem8 = registers[8];
reg_mem9 = registers[9];
reg_mem10 = registers[10];
reg_mem11 = registers[11];
reg_mem12 = registers[12];
reg_mem13 = registers[13];
reg_mem14 = registers[14];
reg_mem15 = registers[15];






end

endmodule
`timescale 1ns/10ps

module fetch(clk,PC,icode,ifun,rA,rB,valC,valP);

input clk;
input [64:1]PC;

output reg [4:1] icode;
output reg [4:1] ifun;
output reg [4:1] rA;
output reg [4:1] rB;
output reg [64:1] valC;
output reg [64:1] valP;
reg [8:1]instruction_mem[200:0];


initial begin


//  //Instruction memory

//   //main:
//   //irmovq $0x0, %rax
//   instruction_mem[0]=8'b00110000; //3 0
//   instruction_mem[1]=8'b00000010; //F rB=2
//   instruction_mem[2]=8'b00000000;           
//   instruction_mem[3]=8'b00000000;           
//   instruction_mem[4]=8'b00000000;           
//   instruction_mem[5]=8'b00000000;           
//   instruction_mem[6]=8'b00000000;           
//   instruction_mem[7]=8'b00000000;           
//   instruction_mem[8]=8'b00000000;          
//   instruction_mem[9]=8'b00010000; //V=0
 
//   //jmp
//   instruction_mem[10]=8'b01110001; //7 fn
//   instruction_mem[11]=8'b00000000; //Dest
//   instruction_mem[12]=8'b00000000; //Dest
//   instruction_mem[13]=8'b00000000; //Dest
//   instruction_mem[14]=8'b00000000; //Dest
//   instruction_mem[15]=8'b00000000; //Dest
//   instruction_mem[16]=8'b00000000; //Dest
//   instruction_mem[17]=8'b00000000; //Dest
//   instruction_mem[18]=8'b00011110; //Dest=30
//   //jmp check11110
//   instruction_mem[30]=8'b01110000; //7 fn
//   instruction_mem[31]=8'b00000000; //Dest
//   instruction_mem[32]=8'b00000000; //Dest
//   instruction_mem[33]=8'b00000000; //Dest
//   instruction_mem[34]=8'b00000000; //Dest
//   instruction_mem[35]=8'b00000000; //Dest
//   instruction_mem[36]=8'b00000000; //Dest
//   instruction_mem[37]=8'b00000000; //Dest
//   instruction_mem[38]=8'b00100111; //Dest=39

// // check:
//   // addq %rax, %rbx 
//   instruction_mem[39]=8'b01100000; //5 fn
//   instruction_mem[40]=8'b00010011; //rA=1 rB=3
//   // je rbxres  
//   instruction_mem[41]=8'b01110011; //7 fn=3
//   instruction_mem[42]=8'b00000000; //Dest
//   instruction_mem[43]=8'b00000000; //Dest
//   instruction_mem[44]=8'b00000000; //Dest
//   instruction_mem[45]=8'b00000000; //Dest
//   instruction_mem[46]=8'b00000000; //Dest
//   instruction_mem[47]=8'b00000000; //Dest
//   instruction_mem[48]=8'b00000000; //Dest
//   instruction_mem[49]=8'b01111010; //Dest=122
//   // addq %rax, %rdx
//   instruction_mem[50]=8'b01100001; //5 fn
//   instruction_mem[51]=8'b00010010; //rA=1 rB=2
//   // je rdxres 
//   instruction_mem[52]=8'b01110011; //7 fn=3
//   instruction_mem[53]=8'b00000000; //Dest
//   instruction_mem[54]=8'b00000000; //Dest
//   instruction_mem[55]=8'b00000000; //Dest
//   instruction_mem[56]=8'b00000000; //Dest
//   instruction_mem[57]=8'b00000000; //Dest
//   instruction_mem[58]=8'b00000000; //Dest
//   instruction_mem[59]=8'b00000000; //Dest
//   instruction_mem[60]=8'b11010000; //Dest=80
//   // jmp loop2 
//   instruction_mem[61]=8'b01110000; //7 fn=0
//   instruction_mem[62]=8'b00000000; //Dest
//   instruction_mem[63]=8'b00000000; //Dest
//   instruction_mem[64]=8'b00000000; //Dest
//   instruction_mem[65]=8'b00000000; //Dest
//   instruction_mem[66]=8'b00000000; //Dest
//   instruction_mem[67]=8'b00000000; //Dest
//   instruction_mem[68]=8'b00000000; //Dest
//   instruction_mem[69]=8'b01000110; //Dest = 70

// // loop2:
//   // mrmovq %rdx, %rsi 
//   instruction_mem[70]=8'b01010000; //2 fn=0
//   instruction_mem[71]=8'b00100110;
//   instruction_mem[72]=8'b00000000; //Dest
//   instruction_mem[73]=8'b00000000; //Dest
//   instruction_mem[74]=8'b00000000; //Dest
//   instruction_mem[75]=8'b00000000; //Dest
//   instruction_mem[76]=8'b00000000; //Dest
//   instruction_mem[77]=8'b00000000; //Dest
//   instruction_mem[78]=8'b00000000; //Dest
//   instruction_mem[79]=8'b01100000;  //rA=2 rB=6
// //   // rrmovq %rbx, %rdi
// //   instruction_mem[80]=8'b00100000; //2 fn=0
// //   instruction_mem[81]=8'b00110111;
//   //ret
//   instruction_mem[80]=8'b10010000; 

  
// //   // subq %rbx, %rsi
// //   instruction_mem[74]=8'b01100001; //5 fn=1
// //   instruction_mem[75]=8'b00110110; //rA=3 rB=6
// //   // jge ab1  
// //   instruction_mem[76]=8'b01110001; //7 fn=5
// //   instruction_mem[77]=8'b00000000; //Dest
// //   instruction_mem[78]=8'b00000000; //Dest
// //   instruction_mem[79]=8'b00000000; //Dest
// //   instruction_mem[80]=8'b00000000; //Dest
// //   instruction_mem[81]=8'b00000000; //Dest
// //   instruction_mem[82]=8'b00000000; //Dest
// //   instruction_mem[83]=8'b00000000; //Dest
// //   instruction_mem[84]=8'b01100000; //Dest=96

  //main:
  //irmovq $0x0, %rax
  instruction_mem[0]=8'b00110000; //3 0
  instruction_mem[1]=8'b00000000; //F rB=0
  instruction_mem[2]=8'b00000000;           
  instruction_mem[3]=8'b00000000;           
  instruction_mem[4]=8'b00000000;           
  instruction_mem[5]=8'b00000000;           
  instruction_mem[6]=8'b00000000;           
  instruction_mem[7]=8'b00000000;           
  instruction_mem[8]=8'b00000000;          
  instruction_mem[9]=8'b00000000; //V=0
//   //irmovq $0x10, %rdx
  instruction_mem[10]=8'b00110000; //3 0
  instruction_mem[11]=8'b00000010; //F rB=2
  instruction_mem[12]=8'b00000000;           
  instruction_mem[13]=8'b00000000;           
  instruction_mem[14]=8'b00000000;           
  instruction_mem[15]=8'b00000000;           
  instruction_mem[16]=8'b00000000;           
  instruction_mem[17]=8'b00000000;           
  instruction_mem[18]=8'b00000000;          
  instruction_mem[19]=8'b00010000; //V=16
  //irmovq $0xc, %rbx
  instruction_mem[20]=8'b00110000; //3 0
  instruction_mem[21]=8'b00000011; //F rB=3
  instruction_mem[22]=8'b00000000;           
  instruction_mem[23]=8'b00000000;           
  instruction_mem[24]=8'b00000000;           
  instruction_mem[25]=8'b00000000;           
  instruction_mem[26]=8'b00000000;           
  instruction_mem[27]=8'b00000000;           
  instruction_mem[28]=8'b00000000;          
  instruction_mem[29]=8'b00001100; //V=12
  //jmp check
  instruction_mem[30]=8'b01110000; //7 fn
  instruction_mem[31]=8'b00000000; //Dest
  instruction_mem[32]=8'b00000000; //Dest
  instruction_mem[33]=8'b00000000; //Dest
  instruction_mem[34]=8'b00000000; //Dest
  instruction_mem[35]=8'b00000000; //Dest
  instruction_mem[36]=8'b00000000; //Dest
  instruction_mem[37]=8'b00000000; //Dest
  instruction_mem[38]=8'b00100111; //Dest=39

// check:
  // addq %rax, %rbx 
  instruction_mem[39]=8'b01100000; //5 fn
  instruction_mem[40]=8'b00000011; //rA=0 rB=3
  // je rbxres  
  instruction_mem[41]=8'b01110011; //7 fn=3
  instruction_mem[42]=8'b00000000; //Dest
  instruction_mem[43]=8'b00000000; //Dest
  instruction_mem[44]=8'b00000000; //Dest
  instruction_mem[45]=8'b00000000; //Dest
  instruction_mem[46]=8'b00000000; //Dest
  instruction_mem[47]=8'b00000000; //Dest
  instruction_mem[48]=8'b00000000; //Dest
  instruction_mem[49]=8'b01111010; //Dest=122
  // subqq %rax, %rdx
  instruction_mem[50]=8'b01100001; //5 fn
  instruction_mem[51]=8'b00100010; //rA=2 rB=2
  // je rdxres 
  instruction_mem[52]=8'b01110011; //7 fn=3
  instruction_mem[53]=8'b00000000; //Dest
  instruction_mem[54]=8'b00000000; //Dest
  instruction_mem[55]=8'b00000000; //Dest
  instruction_mem[56]=8'b00000000; //Dest
  instruction_mem[57]=8'b00000000; //Dest
  instruction_mem[58]=8'b00000000; //Dest
  instruction_mem[59]=8'b00000000; //Dest
  instruction_mem[60]=8'b01111101; //Dest=125
  // jmp loop2 
  instruction_mem[61]=8'b01110000; //7 fn=0
  instruction_mem[62]=8'b00000000; //Dest
  instruction_mem[63]=8'b00000000; //Dest
  instruction_mem[64]=8'b00000000; //Dest
  instruction_mem[65]=8'b00000000; //Dest
  instruction_mem[66]=8'b00000000; //Dest
  instruction_mem[67]=8'b00000000; //Dest
  instruction_mem[68]=8'b00000000; //Dest
  instruction_mem[69]=8'b01000110; //Dest

// loop2:
  // rrmovq %rdx, %rsi 
  instruction_mem[70]=8'b00100000; //2 fn=0
  instruction_mem[71]=8'b00100110; //rA=2 rB=6
  // rrmovq %rbx, %rdi
  instruction_mem[72]=8'b00100000; //2 fn=0
  instruction_mem[73]=8'b00110111; //rA=3 rB=7
  // subq %rbx, %rsi
  instruction_mem[74]=8'b01100001; //5 fn=1
  instruction_mem[75]=8'b00110110; //rA=3 rB=6
  // jge ab1  
  instruction_mem[76]=8'b01110001; //7 fn=5
  instruction_mem[77]=8'b00000000; //Dest
  instruction_mem[78]=8'b00000000; //Dest
  instruction_mem[79]=8'b00000000; //Dest
  instruction_mem[80]=8'b00000000; //Dest
  instruction_mem[81]=8'b00000000; //Dest
  instruction_mem[82]=8'b00000000; //Dest
  instruction_mem[83]=8'b00000000; //Dest
  instruction_mem[84]=8'b01100000; //Dest=96
  // subq %rdx, %rdi 
  instruction_mem[85]=8'b01100001; //5 fn
  instruction_mem[86]=8'b00100111; //rA=2 rB=7
  // jge ab2
  instruction_mem[87]=8'b01110001; //7 fn=5
  instruction_mem[88]=8'b00000000; //Dest
  instruction_mem[89]=8'b00000000; //Dest
  instruction_mem[90]=8'b00000000; //Dest
  instruction_mem[91]=8'b00000000; //Dest
  instruction_mem[92]=8'b00000000; //Dest
  instruction_mem[93]=8'b00000000; //Dest
  instruction_mem[94]=8'b00000000; //Dest
  instruction_mem[95]=8'b01101101; //Dest=109

// ab1:
  // rrmovq %rbx, %rdx
  instruction_mem[96]=8'b00100000; //2 fn=0
  instruction_mem[97]=8'b00110010; //rA=3 rB=2
  // rrmovq %rsi, %rbx
  instruction_mem[98]=8'b00100000; //2 fn=0
  instruction_mem[99]=8'b01100011; //rA=6 rB=3
  // jmp check
  instruction_mem[100]=8'b01110000; //7 fn=0
  instruction_mem[101]=8'b00000000; //Dest
  instruction_mem[102]=8'b00000000; //Dest
  instruction_mem[103]=8'b00000000; //Dest
  instruction_mem[104]=8'b00000000; //Dest
  instruction_mem[105]=8'b00000000; //Dest
  instruction_mem[106]=8'b00000000; //Dest
  instruction_mem[107]=8'b00000000; //Dest
  instruction_mem[108]=8'b00100111; //Dest=39

// ab2:
  // rrmovq %rbx, %rdx
  instruction_mem[109]=8'b00100000; //2 fn=0
  instruction_mem[110]=8'b00110010; //rA=3 rB=2
  // rrmovq %rdi, %rbx
  instruction_mem[111]=8'b00100000; //2 fn=0
  instruction_mem[112]=8'b01110011; //rA=7 rB=3
  // jmp check
  instruction_mem[113]=8'b01110000; //7 fn=0
  instruction_mem[114]=8'b00000000; //Dest
  instruction_mem[115]=8'b00000000; //Dest
  instruction_mem[116]=8'b00000000; //Dest
  instruction_mem[117]=8'b00000000; //Dest
  instruction_mem[118]=8'b00000000; //Dest
  instruction_mem[119]=8'b00000000; //Dest
  instruction_mem[120]=8'b00000000; //Dest
  instruction_mem[121]=8'b00100111; //Dest=39

// rbxres:
  // rrmovq %rdx, %rcx
  instruction_mem[122]=8'b00100000; //2 fn=0
  instruction_mem[123]=8'b00100001; //rA=2 rB=1
  // halt
  instruction_mem[124]=8'b00000000;

// rdxres:
  // rrmovq %rbx, %rcx
  instruction_mem[125]=8'b10010000; //2 fn=0
  
  // halt
  


end


always @ (*)
begin

    icode = instruction_mem[PC][8:5];
    ifun = instruction_mem[PC][4:1];


   if(icode == 4'b0000)   // halt
   begin
    valP = PC + 64'd1;
   end
      

      else if(icode == 4'b0001)   // nop
      begin
       valP = PC + 64'd1;
      end


     else if(icode == 4'b0010)     //cmmovxx
     begin
        rA = instruction_mem[PC+1][8:5];
        rB = instruction_mem[PC+1][4:1];
        valP = PC + 64'd2;

     end


     else if (icode == 4'b0011)   //irmovq
     begin
     rA = instruction_mem[PC+1][8:5];
     rB = instruction_mem[PC+1][4:1];
     valC = {
       instruction_mem[PC+2],
        instruction_mem[PC+3],
        instruction_mem[PC+4],
        instruction_mem[PC+5],
        instruction_mem[PC+6],
        instruction_mem[PC+7],
        instruction_mem[PC+8],
        instruction_mem[PC+9]
     };
     valP  = PC + 64'd10;
     end

     else if (icode == 4'b0100)   // rmmovq
     begin
         rA = instruction_mem[PC+1][8:5];
     rB = instruction_mem[PC+1][4:1];
     valC = {
        instruction_mem[PC+2],
        instruction_mem[PC+3],
        instruction_mem[PC+4],
        instruction_mem[PC+5],
        instruction_mem[PC+6],
        instruction_mem[PC+7],
        instruction_mem[PC+8],
        instruction_mem[PC+9]
     };
     valP  = PC + 64'd10;

     end

  else if (icode == 4'b0101)   // mrmovq
     begin
         rA = instruction_mem[PC+1][8:5];
        rB = instruction_mem[PC+1][4:1];
     valC = {
        instruction_mem[PC+2],
        instruction_mem[PC+3],
        instruction_mem[PC+4],
        instruction_mem[PC+5],
        instruction_mem[PC+6],
        instruction_mem[PC+7],
        instruction_mem[PC+8],
        instruction_mem[PC+9]
     };
     valP  = PC + 64'd10;

     end
 
 else if(icode == 4'b0110)   //opq
 begin
    rA = instruction_mem[PC+1][8:5];
    rB = instruction_mem[PC+1][4:1];
    valP = PC + 2;
 end

else if(icode == 4'b0111)   //jxx
begin
    valC = {
        instruction_mem[PC+1],
        instruction_mem[PC+2],
        instruction_mem[PC+3],
        instruction_mem[PC+4],
        instruction_mem[PC+5],
        instruction_mem[PC+6],
        instruction_mem[PC+7],
        instruction_mem[PC+8]
     };
     valP = PC + 64'd9;
end


else if(icode == 4'b1000) //call
    begin
        valC = {instruction_mem[PC+1],
                instruction_mem[PC+2],
                instruction_mem[PC+3],
                instruction_mem[PC+4],
                instruction_mem[PC+5],
                instruction_mem[PC+6],
                instruction_mem[PC+7],
                instruction_mem[PC+8]
                };
        valP = PC + 64'd9;
    end    
    
    else if(icode == 4'b1001) //ret
    begin
        valP = PC + 64'd1;
    end    
    
    else if(icode == 4'b1010) //pushq
    begin
        rA = instruction_mem[PC+1][8:5];
        rB = instruction_mem[PC+1][4:1];
        valP = PC + 64'd2;
    end    
    
    else if(icode == 4'b1011) //popq    
    begin
        rA = instruction_mem[PC+1][8:5];
        rB = instruction_mem[PC+1][4:1];
        valP = PC + 64'd2;
    end    






end

endmodule

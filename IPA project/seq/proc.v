`timescale 1ns / 1ps
`include "decode.v"
`include "fetch.v"
`include "execute.v"
`include "memory.v"
`include "wb.v"
`include "pc.v"

module proc;
  reg clk;
  reg [63:0] PC;
  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire [63:0] valA;
  wire [63:0] valB;
  wire [63:0] valM;
  wire [63:0] ram_val;
  wire signed [63:0] valE;
  wire cnd;
  wire [64:1]reg_mem0;
  wire [64:1]reg_mem1;
  wire [64:1]reg_mem2;
  wire [64:1]reg_mem3;
  wire [64:1]reg_mem4;
  wire [64:1]reg_mem5;
  wire [64:1]reg_mem6;
  wire [64:1]reg_mem7;
  wire [64:1]reg_mem8;
  wire [64:1]reg_mem9;
  wire [64:1]reg_mem10;
  wire [64:1]reg_mem11;
  wire [64:1]reg_mem12;
  wire [64:1]reg_mem13;
  wire [64:1]reg_mem14;
  wire [64:1]reg_mem15;
  wire [64:1]reg_memf0;
  wire [64:1]reg_memf1;
  wire [64:1]reg_memf2;
  wire [64:1]reg_memf3;
  wire [64:1]reg_memf4;
  wire [64:1]reg_memf5;
  wire [64:1]reg_memf6;
  wire [64:1]reg_memf7;
  wire [64:1]reg_memf8;
  wire [64:1]reg_memf9;
  wire [64:1]reg_memf10;
  wire [64:1]reg_memf11;
  wire [64:1]reg_memf12;
  wire [64:1]reg_memf13;
  wire [64:1]reg_memf14;
  wire [64:1]reg_memf15;

 wire [64:1] new_pc;

  fetch fetch(clk,PC,icode,ifun,rA,rB,valC,valP);
  decode decode(clk,icode,ifun,rA,rB,valA,valB,reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14,reg_mem15);

  execute execute(icode,ifun,clk,valA,valB,valC,valE,zf,sf,of,cnd);

  memory memory(clk,icode,valA,valB,valC,valE,valP,valM,ram_val);


  wb wb(clk,icode,rA,rB,cnd,valM,valE,reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14,reg_mem15,reg_memf0,reg_memf1,reg_memf2,reg_memf3,reg_memf4,reg_memf5,reg_memf6,reg_memf7,reg_memf8,reg_memf9,reg_memf10,reg_memf11,reg_memf12,reg_memf13,reg_memf14,reg_memf15);
   
   pc_update pc(clk,icode,cnd,valC,valM,valP,new_pc);

  initial
   begin
    $dumpfile("proc_out.vcd");
        $dumpvars(0,proc);
    
 
    clk=0;
    PC=64'd0;

    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;

    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  
    #10 clk=~clk;PC=new_pc;
  end 
  
  initial 
        $monitor("clk=%d  PC=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC =%d valE=%d zf=%d sf=%d of=%d cnd=%d valM=%d ram_val=%d reg= %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valC,valE,zf,sf,of,cnd,valM,ram_val,reg_memf0,reg_memf1,reg_memf2,reg_memf3,reg_memf4,reg_memf5,reg_memf6,reg_memf7,reg_memf8,reg_memf9,reg_memf10,reg_memf11,reg_memf12,reg_memf13,reg_memf14,reg_memf15);
        
endmodule
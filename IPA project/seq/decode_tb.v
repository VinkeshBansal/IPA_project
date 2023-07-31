`timescale 1ns / 1ps
`include "fetch.v"

module fetchdecodetb;
  reg clk;
  reg [64:1] PC;
  

  wire [4:1] icode;
  wire [4:1] ifun;
  wire [4:1] rA;
  wire [4:1] rB; 
  wire [64:1] valC;
  wire [64:1] valP;
  wire [64:1] valA;
  wire [64:1] valB;
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

  fetch fetch(clk,PC,icode,ifun,rA,rB,valC,valP);

  decode decode(clk,icode,ifun,rA,rB,valA,valB,reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14,reg_mem15);

  initial begin
    clk=0;
    PC=64'd0;

    #10 clk=~clk;PC=64'd0;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;
  end 
  
  initial 
		$monitor("clk=%d PC =%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC=%d \n",clk,PC,icode,ifun,rA,rB,valA,valB,valC);
endmodule 
`timescale 1ns/1ps
`include "ALU.v"
`include "Full_Adder.v"
`include "Half_Adder.v"

module execute (icode,ifun,clk,valA,valB,valC,valE,zf,sf,of,cnd);

input [4:1]icode,ifun;
//input [4:1]ifun;
input clk;
input [64:1] valA,valB,valC;
output reg signed [64:1] valE;
output reg zf,sf,of,cnd;

wire signed [63:0] result;

reg [1:0]control;
wire overflow;
reg signed [63:0]a;
reg signed [63:0]b; 

// ALU operate(.controlcontrol),.a(a),.b(b),.ans(ans),.overflow(overflow));
ALU oper(result,overflow,a,b,control);
initial
  begin
    control=2'b00;
		a = 64'b0;
		b = 64'b0;
  end

always@(negedge clk)
begin //FLags zf,sf,of
    if(icode==4'b0110 || clk==1)
    begin
      zf=(result==1'b0);
      sf=(result[63]==1'b1);
      of=(a<64'b0==b<64'b0)&&(result<64'b0 != a<64'b0);
    end
end

always@(*)
begin
    if(icode == 4'b0010) //cmov
    begin
        a = valA;
        b = 0;
        control = 2'b00; 
        if(ifun == 4'b0000) //rrmovq
        begin
           cnd=1'b1;
        end

        if(ifun == 4'b0001) //cmovle
        begin
            if((sf^of)|zf)
            begin
                cnd=1'b1;
            end 
        end
        
        if(ifun == 4'b0010) //cmovl
        begin
            if(sf^of)
            begin
                cnd=1'b1;
            end
        end
        
        if(ifun == 4'b0011) //cmove
        begin
            if(zf)
            begin
                cnd=1'b1;
            end 
        end
        
        if(ifun == 4'b0100) //cmone
        begin
            if(~zf)
            begin
                cnd=1'b1;
            end
        end
        
        if(ifun == 4'b0101) //cmovge
        begin
            if(~(sf^of))
            begin
                cnd=1'b1;
            end
        end
        
        if(ifun == 4'b0110) //cmovg
        begin
            if((~(sf^of)&(~zf)))  //note here
            begin
                cnd=1'b1;
            end
        end
        valE = 64'd0 + valA;
    end

    else if(icode==4'b0011) //irmovq
      begin
        valE=64'd0+valC;
      end
      else if(icode==4'b0100) //rmmovq
      begin
        valE=valB+valC;
      end
      else if(icode==4'b0101) //mrmovq
      begin
        valE=valB+valC;
      end
    
    else if(icode==4'b1000) //call
      begin
        valE=-64'd8+valB;
      end
    else if(icode==4'b1001) //ret
      begin
        valE=64'd8+valB;
      end
    else if(icode==4'b1010) //pushq
      begin
        valE=-64'd8+valB;
      end
    else if(icode==4'b1011) //popq
      begin
        valE=64'd8+valB;
      end
    else if (icode == 4'b0111) //jxx
    begin
        cnd =1'b0;
        if(ifun == 4'b0000) //jmp
        begin
            cnd=1'b1;
        end
        
        if(ifun == 4'b0001) //jle
        begin
            if((sf^of)|zf)
            begin
                cnd=1'b1;
            end 
        end
        
        if(ifun == 4'b0010) //jl
        begin
            if(sf^of)
            begin
                cnd=1'b1;
            end
        end
        if(ifun == 4'b0011) //je
          begin
            if(zf)
            begin
                cnd=1'b1;
            end 
        end
        if(ifun == 4'b0100) //jne
        begin
            if(~zf)
            begin
                cnd=1'b1;
            end
        end
        if(ifun == 4'b0101) //jge
        begin
            if(~(sf^of))
            begin
                cnd=1'b1;
            end
        end
        if(ifun == 4'b0110) //jg
        begin
            if((~(sf^of)&(~zf)))
            begin
                cnd=1'b1;
            end
        end
    end
    else if(icode == 4'b0110) // ALU
    begin
        if(ifun==4'b0000) //add
        begin
          
          //result=valA+valB;
          control=2'b00;
          a = valA;
          b = valB;
        end
        else if(ifun==4'b0001) //sub
        begin
         //sign  result=valA-valB;
          control=2'b01;
          a = valA;
          b = valB;
        end
        else if(ifun==4'b0010) //and
        begin
          //assign result=valA.valB;
          control=2'b10;
          a = valA;
          b = valB;
        end
        else if(ifun==4'b0011) //xor
        begin
          //ssign result=valA^valB;
          control=2'b11;
          a = valA;
          b = valB;
        end
        valE=result;
    end
end

endmodule
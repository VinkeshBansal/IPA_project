`include "ALU.v"


module execute(clk, E_icode, E_ifun, E_valA, E_valB, E_valC, e_valE, e_dstE,e_dstM, E_dstE,E_dstM, e_cnd, ZF, SF, OF, e_icode, e_valA, e_dstM);

input clk;
input [4:1] E_icode;
input [4:1] E_ifun;
input [4:1] E_dstE;
input [4:1] E_dstM;

input [64:1] E_valA;
input [64:1] E_valB;
input [64:1] E_valC;


output reg [64:1] e_valE;
output reg [4:1] e_dstE;
output reg [4:1] e_icode;
output reg [4:1] e_dstM;
output reg [64:1] e_valA;

output reg e_cnd;
output reg ZF,SF,OF;

reg[1:0] control;


reg signed [64:1] aluA,aluB,ans;
wire overflow;

wire signed [64:1] res;

ALU alu(res,overflow,aluA,aluB,control);

always @(res or aluA or aluB)
    begin
        ZF = (res == 64'b0); // output of ALU is zero
        SF = (res[63] ==1'b1); // output of ALU is negative
        OF = (aluA < 1'b0 == aluB < 1'b0) && (res < 64'b0 != aluA < 1'b0); // signed overflow flag
    end

always@(*)
    begin
       e_icode = E_icode;
       e_dstM = E_dstM;
       e_valA = E_valA; 
       
    end


always @(*)
begin
 
     e_cnd = 0;   


     if (E_icode == 4'b0010 ) // cmovXX 
     begin
      if(E_ifun==4'b0000)    //rrmovq
      begin
        e_cnd = 1;
      end
      if(E_ifun==4'b0001)    //cmovle
      begin
       if((SF^OF)|ZF)
            begin
                e_cnd=1'b1;
            end 
      end
     if(E_ifun == 4'b0010)   //cmovl
        begin
            if(SF^OF)
            begin
                e_cnd=1'b1;
            end
        end
          if(E_ifun == 4'b0011) //cmove
        begin
            if(ZF)
            begin
                e_cnd=1'b1;
            end 
        end
        
        if(E_ifun == 4'b0100) //cmone
        begin
            if(~ZF)
            begin
                e_cnd=1'b1;
            end
        end
        
        if(E_ifun == 4'b0101) //cmovge
        begin
            if(~(SF^OF))
            begin
                e_cnd=1'b1;
            end
        end
        
        if(E_ifun == 4'b0110) //cmovg
        begin
            if((~(SF^OF)&(~ZF)))  
            begin
                e_cnd=1'b1;
            end
        end
             
             aluA = E_valA;    // valE = 0 + valA
           aluB = 64'd0;
           control = 2'b00;
       
     end

      if (E_icode == 4'b0011)    //irmovq  valE = 0 +valC
       begin
        aluA = E_valC;
        aluB = 64'd0;
    // instruction_memory[40] = 8'b00110101; // f_rA = 3, 
        control = 2'b00;
        
      end
    

    if (E_icode == 4'b0100)
     begin                     //rmmovq   valE = valB + valC
        aluA = E_valC;  
        aluB = E_valB;
        control = 2'b00;
    end


        if (E_icode == 4'b0101)
     begin                     //mrmovq   valE = valB + valC
        aluA = E_valC;  
        aluB = E_valB;
        control = 2'b00;
    end

    


      if(E_icode == 4'b0110)      //OPq
      begin

        if(E_ifun==4'b0000)  // add
        begin
         aluA =E_valA;
         aluB = E_valB;
         control = 2'b00;        
        end
        if(E_ifun==4'b0001)  // sub
        begin
         aluA =E_valA;
         aluB = E_valB;
         control = 2'b01; 
        end
         if(E_ifun==4'b0010)  // and
        begin
         aluA =E_valA;
         aluB = E_valB;
         control = 2'b10; 
        end
         if(E_ifun==4'b0011)  // xor
        begin
         aluA =E_valA;
         aluB = E_valB;
         control = 2'b11; 
         end

        end


    if (E_icode== 4'b0111)          //jXX
     begin

        if(E_ifun == 4'b0000) //jofmp
        begin
            e_cnd=1'b1;
        end
        
        if(E_ifun == 4'b0001) //jle
        begin
            if((SF^OF)|ZF)
            begin
                e_cnd=1'b1;
            end 
        end
        
        if(E_ifun == 4'b0010) //jl
        begin
            if(SF^OF)
            begin
                e_cnd=1'b1;
            end
        end
        if(E_ifun == 4'b0011) //je
          begin
            if(ZF)
            begin
                e_cnd=1'b1;
            end 
        end
        if(E_ifun == 4'b0100) //jne
        begin
            if(~ZF)
            begin
                e_cnd=1'b1;
            end
        end
        if(E_ifun == 4'b0101) //jge
        begin
            if(~(SF^OF))
            begin
                e_cnd=1'b1;
            end
        end
        if(E_ifun == 4'b0110) //jg
        begin
            if((~(SF^OF)&(~ZF)))
            begin
                e_cnd=1'b1;
            end
        end
        
    end


  if (E_icode == 4'b1000) begin  //call
    aluA = -64'd8;
    aluB = E_valB;
    control = 2'b00;
  end

    if (E_icode == 4'b1001) begin  //ret
    aluA = 64'd8;
    aluB = E_valB;
    control = 2'b00;
  end
  

    if (E_icode == 4'b1010) begin  //push
    aluA = -64'd8;
    aluB = E_valB;
    control = 2'b00;
  end


    if (E_icode == 4'b1011) begin  //pop
    aluA = 64'd8;
    aluB = E_valB;
    control = 2'b00;
  end


  ans = res;
  e_valE = ans;
     end

always@(*)
    begin
        if((E_icode == 4'b0010) && (!e_cnd))
            e_dstE = 4'b1111;
        else
            e_dstE = E_dstE;
    end



endmodule





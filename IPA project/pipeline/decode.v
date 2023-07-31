module decode(clk, D_icode, D_ifun, D_rA, D_rB, D_valC, D_valP, e_dstE, e_dstM, e_valE, M_dstE, M_valE, M_dstM, m_valM, W_dstM, W_valM, W_dstE, W_valE,
        reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14,
        d_dstE, d_dstM, d_srcA, d_srcB, d_valA, d_valB, d_valC, d_icode, d_ifun);

input clk;
input [4:1] D_icode,D_ifun,D_rA,D_rB;
input [64:1] D_valC,D_valP;
input [4:1] e_dstE,e_dstM,M_dstE,M_dstM,W_dstM,W_dstE;
input [64:1] e_valE,M_valE,m_valM,W_valM,W_valE;

output reg [64:1] d_valA,d_valB,d_valC;
output reg [4:1] d_dstE,d_dstM,d_srcA,d_srcB,d_icode, d_ifun;
input [64:1] reg_mem0;
input [64:1] reg_mem1;
input [64:1] reg_mem2;
input [64:1] reg_mem3;
input [64:1] reg_mem4;
input [64:1] reg_mem5;
input [64:1] reg_mem6;
input [64:1] reg_mem7;
input [64:1] reg_mem8;
input [64:1] reg_mem9;
input [64:1] reg_mem10;
input [64:1] reg_mem11;
input [64:1] reg_mem12;
input [64:1] reg_mem13;
input [64:1] reg_mem14;


reg [64:1] rvalA,rvalB;
reg [64:1] register_mem[0:14];



always @(*)
    begin
         register_mem[0] = reg_mem0;
        register_mem[1] = reg_mem1;
        register_mem[2] = reg_mem2;
        register_mem[3] = reg_mem3;
        register_mem[4] = reg_mem4;
        register_mem[5] = reg_mem5;
        register_mem[6] = reg_mem6;
        register_mem[7] = reg_mem7;
        register_mem[8] = reg_mem8;
        register_mem[9] = reg_mem9;
        register_mem[10] = reg_mem10;
        register_mem[11] = reg_mem11;
        register_mem[12] = reg_mem12;
        register_mem[13] = reg_mem13;
        register_mem[14] = reg_mem14;
       
        
        
       
        d_valC = D_valC;
        d_icode = D_icode;
        d_ifun = D_ifun;

        if(d_icode == 4'b0010) //cmovxx
        begin
            rvalA = register_mem[D_rA];
            d_srcA = D_rA;
            d_srcB = D_rB;
        end
        else if(d_icode == 4'b0100) //rmmovq
        begin
            rvalA = register_mem[D_rA];
            rvalB = register_mem[D_rB];
            d_srcA = D_rA;
            d_srcB = D_rB;
        end
        else if(d_icode == 4'b0101) //mrmovq
        begin
            rvalB = register_mem[D_rB];
            d_srcA = D_rA;
            d_srcB = D_rB;
        end
        else if(d_icode == 4'b0110) //Op
        begin
            rvalA = register_mem[D_rA];
            rvalB = register_mem[D_rB];
            d_srcA = D_rA;
            d_srcB = D_rB;
        end
        else if(d_icode == 4'b1000) //call
        begin
            rvalB = register_mem[4]; //rsp register
            d_srcB = 4;
        end
        else if(d_icode == 4'b1001) //ret
        begin
            rvalA = register_mem[4];
            rvalB = register_mem[4];
            d_srcA = 4;
            d_srcB = 4;
        end
        else if(d_icode == 4'b1010) //pushq
        begin
            rvalA = register_mem[D_rA];
            rvalB = register_mem[4];
            d_srcA = D_rA;
            d_srcB = 4;
        end
        else if(d_icode == 4'b1011) //popq
        begin
            rvalA = register_mem[4];
            rvalB = register_mem[4];
            d_srcA = 4;
            d_srcB = 4;
        end 
    end

//determinng destM and destE

always@(*)  //check for edge
begin
    if(d_icode == 4'b0110 || d_icode == 4'b0011 ||  d_icode == 4'b0010) //opq // // //irmovq //cmov
    begin
        d_dstE = D_rB;
    end
    else if(d_icode == 4'b0101)
    begin
        d_dstM = D_rA;
    end
    else if(d_icode == 4'b1010 || d_icode == 4'b1000)
    begin
        d_dstE = 5;
    end
    else if(d_icode == 4'b1011)
    begin
        d_dstE = 5;
        d_dstM = D_rA;
    end
    else if(d_icode == 4'b1000)
    begin
        d_dstE = 5;;
    end

end



//d_valA and d_valB


always@(*)
    begin
        if(D_icode == 4'b0111 || D_icode == 4'b1000)
            d_valA = D_valP;
        else if(d_srcA == e_dstM)
            d_valA = e_valE;
        else if(d_srcA == M_dstM)
            d_valA = m_valM;
        else if(d_srcA == M_dstE)
            d_valA = M_valE;
        else if(d_srcA == W_dstM)
            d_valA = W_valM;
        else if(d_srcA == W_dstE)
            d_valA = W_valE;
        else
            d_valA = rvalA;
        
        if(d_srcB == e_dstE)
            d_valB = e_valE;
        else if(d_srcB == M_dstM)
            d_valB = m_valM;
        else if(d_srcB == M_dstE)
            d_valB = M_valE;
        else if(d_srcB == W_dstM)
            d_valB = W_valM;
        else if(d_srcB == W_dstE)
            d_valB = W_valE;
        else
            d_valB = rvalB;
    end


    endmodule
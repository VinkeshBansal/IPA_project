module writeback (clk, W_icode, W_valE, W_valM, W_dstE, W_dstM,reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14);

input clk;
input [4:1] W_icode;
input [4:1] W_dstE;
input [4:1] W_dstM;
input [64:1] W_valE;
input [64:1] W_valM;
output reg [64:1] reg_mem0;
output reg [64:1] reg_mem1;
output reg [64:1] reg_mem2;
output reg [64:1] reg_mem3;
output reg [64:1] reg_mem4;
output reg [64:1] reg_mem5;
output reg [64:1] reg_mem6;
output reg [64:1] reg_mem7;
output reg [64:1] reg_mem8;
output reg [64:1] reg_mem9;
output reg [64:1] reg_mem10;
output reg [64:1] reg_mem11;
output reg [64:1] reg_mem12;
output reg [64:1] reg_mem13;
output reg [64:1] reg_mem14;


reg [64:1] register_mem[0:14];

initial begin

    register_mem[0] = 64'd0;
    register_mem[1] = 64'd0;
    register_mem[2] = 64'd0;
    register_mem[3] = 64'd0;
    register_mem[4] = 64'd0;
    register_mem[5] = 64'd0;
    register_mem[6] = 64'd0;
    register_mem[7] = 64'd0;
    register_mem[8] = 64'd0;
    register_mem[9] = 64'd0;
    register_mem[10] = 64'd0;
    register_mem[11] = 64'd0;
    register_mem[12] = 64'd0;
    register_mem[13] = 64'd0;
    register_mem[14] = 64'd0;
    
end

always @(posedge clk)
    begin
        //cmovxx irmovq opq
        if(W_icode == 4'b0010 || W_icode == 4'b0011 || W_icode == 4'b0110) 
            begin
                register_mem[W_dstE] = W_valE;
            end

        //mrmovq
        else if(W_icode == 4'b0101) 
            begin
                register_mem[W_dstM] = W_valM;
            end

        // call, ret, pushq
        else if(W_icode == 4'b1000 || W_icode == 4'b1001 || W_icode == 4'b1010) 
            begin
                register_mem[4] = W_valE;
            end 
        
        //popq
        else if(W_icode == 4'b1011)
            begin
                register_mem[4] = W_valE;
                register_mem[W_dstM] = W_valM;
            end
    end

always @(*)
begin
     reg_mem0 = register_mem[0]; 
    reg_mem1 = register_mem[1];
    reg_mem2 = register_mem[2];
    reg_mem3 = register_mem[3];
    reg_mem4 = register_mem[4];
    reg_mem5 = register_mem[5];
    reg_mem6 = register_mem[6];
    reg_mem7 = register_mem[7];
    reg_mem8 = register_mem[8];
    reg_mem9 = register_mem[9];
    reg_mem10 = register_mem[10];
    reg_mem11 = register_mem[11];
    reg_mem12 = register_mem[12];
    reg_mem13 = register_mem[13];
    reg_mem14 = register_mem[14]; 
   
end
endmodule
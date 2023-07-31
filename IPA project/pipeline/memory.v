module memory(clk, M_icode, M_valA, M_valE, M_dstE, M_dstM, m_icode, m_dstE, m_dstM, m_valM, m_valE);

input clk;
input  [3:0] M_icode, M_dstE, M_dstM;
input  [63:0] M_valA, M_valE;

output reg [63:0] m_valM;
output reg [63:0] m_valE;
output reg [3:0] m_icode, m_dstE, m_dstM;
reg [64:1] mem [0:100];


always@(*)
    begin
        m_dstM = M_dstM;
        m_valE = M_valE;
        m_icode = M_icode;
        m_dstE = M_dstE;
        
    end



always @(*)

begin

    if (M_icode == 4'b0101) begin       // mrmovq
        
        m_valM = mem[M_valE];
    end

      if (M_icode == 4'b1001) begin       // ret
        
        m_valM = mem[M_valA];
    end

      if (M_icode == 4'b1011) begin       // popq
        
        m_valM = mem[M_valA];
    end

end



always @(posedge clk)

begin


    if (M_icode == 4'b0100 || M_icode == 4'b1000 || M_icode==4'b1010) begin   //rmmovq
         mem[M_valE] = M_valA;
    end

end


endmodule
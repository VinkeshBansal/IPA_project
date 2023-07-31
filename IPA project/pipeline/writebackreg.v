module writebackreg(clk, W_stall,m_icode, m_valE, m_valM, m_dstE, m_dstM, W_icode, W_valE, W_valM, W_dstE, W_dstM);

input clk;
input [4:1] m_icode; 
input [4:1] m_dstE; 
input [4:1] m_dstM;
input [64:1] m_valE, m_valM;
input W_stall;

output reg m_cnd;

output reg [4:1] W_icode;
output reg [4:1] W_dstE;
output reg [4:1] W_dstM;
output reg [64:1] W_valE;
output reg [64:1] W_valM;

always @(posedge clk)
    begin
        if(W_stall==0)
        begin
        W_icode <= m_icode;
        W_valE <= m_valE;
        W_dstM <= m_dstM;
        W_dstE <= m_dstE;
        W_valM <= m_valM;
        end
    end
endmodule
module select_PC(clk,F_predicted_PC , M_valA , M_icode, W_valM ,W_icode, M_cnd , next_PC);

input clk;
input [64:1] F_predicted_PC;
input [64:1] W_valM;
input [64:1] M_valA;
input M_cnd;
input [4:1] M_icode,W_icode;

output reg [64:1] next_PC;

always @(*)
begin
 
    //now we will code how to recover from pc misprediction

    if(W_icode==4'b1001)
    begin
        next_PC <= W_valM;
    end

    else if(M_icode == 4'b0111 && !M_cnd)
    begin
        next_PC <= M_valA;
    end
 // if it is not return or a mispredicted jump our prediction is right
    else
    begin
        next_PC <= F_predicted_PC;
    end
end

endmodule








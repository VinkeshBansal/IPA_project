module fetchreg(clk, predicted_PC, F_predicted_PC,F_stall);


//inputs
input clk;
input [64:1] predicted_PC;
input F_stall;

// outputs
output reg [64:1] F_predicted_PC;

always @(posedge clk)
  begin
    if(F_stall==0)
    begin
    F_predicted_PC <= predicted_PC;
    end
  end

endmodule
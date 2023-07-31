`timescale 1ns/10ps



module bit64_and (ans,A,B);

input signed  [63:0] A;
input signed [63:0] B;
output signed [63:0] ans;





genvar i;

   generate for(i = 0; i < 64; i = i + 1)
    begin
        and inst1(ans[i],A[i],B[i]);
    end
    
   endgenerate 




endmodule

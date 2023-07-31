`timescale 1ns/10ps
// `include "Full_Adder.v"




module bit64_adder (sum,overflow,A,B);

input signed  [63:0] A;
input signed [63:0] B;
output signed [63:0] sum;
wire [63:0] carry;
wire carry_init = 0;
output overflow;

 Full_Adder inst1(sum[0],carry[0],A[0],B[0],carry_init);


genvar i;

   generate for(i = 1; i < 64; i = i + 1)
    begin
        Full_Adder hf1(sum[i],carry[i],A[i],B[i],carry[i-1]);
    end
    
   endgenerate 


xor inst2(overflow,carry[62],carry[63]);

endmodule

`timescale 1ns/10ps
// `include "Full_Adder.v"



module bit64_sub (diff,overflow,A,B);

input signed  [63:0] A;
input signed [63:0] B;
input signed [63:0] B1;
output signed [63:0] diff;
wire [63:0] carry;
wire carry_init = 1;
output overflow;

 


genvar i;


   generate for(i = 0; i < 64; i = i + 1)
    begin
         
         not g1(B1[i],B[i]);
    end
    
   endgenerate 

Full_Adder inst1(diff[0],carry[0],A[0],B1[0],carry_init);


// genvar i;

   generate for(i = 1; i < 64; i = i + 1)
    begin
        Full_Adder hf1(diff[i],carry[i],A[i],B1[i],carry[i-1]);
    end
    
   endgenerate 


xor inst2(overflow,carry[62],carry[63]);

endmodule

`timescale 1ns/10ps
`include "../add/bit64_adder.v"
`include "../and/bit64_and.v"
`include "../sub/bit64_sub.v"
`include "../xor/bit64_xor.v"



module ALU (ans,overflow,A,B,control);

input signed  [63:0] A;
input [1:0] control;
input signed [63:0] B;
output signed [63:0] ans;
output overflow;

reg signed  [63:0] ansfinal; 

 
wire signed  [63:0] ansadd;
wire signed  [63:0] anssub;
wire signed  [63:0] ansand;
wire signed  [63:0] ansxor;


bit64_adder inst7(ansadd,overflow1,A,B); 
bit64_and inst2(ansand,A,B);
bit64_sub inst3(anssub,overflow2,A,B);
bit64_xor inst4(ansxor,A,B);
reg OF;
 
always @(*) 
     begin
    if(control[1]==0 & control[0]==0)
    begin
         ansfinal = ansadd;
         OF=overflow1;
    end
    if(control[1]==0 & control[0]==1)
    begin
        ansfinal = anssub;
        OF=overflow2;
    end
    if(control[1]==1 & control[0]==0)
    begin
        ansfinal = ansand;
        OF=0;
    end
    if(control[1]==1 & control[0]==1)
    begin
        ansfinal = ansxor;
        OF=0;
    end
    
end

assign ans = ansfinal;
assign overflow = OF;
endmodule

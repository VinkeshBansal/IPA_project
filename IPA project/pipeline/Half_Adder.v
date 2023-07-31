module Half_Adder (Sum,Carry,A,B);

input A,B;
output Sum,Carry;

xor inst1(Sum,A,B);
and inst2(Carry,A,B);

endmodule

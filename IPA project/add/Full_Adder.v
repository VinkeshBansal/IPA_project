// `include "Half_Adder.v"
module Full_Adder (Sum,Carry,A,B,CI);

input A,B,CI;
output Sum,Carry;
wire x1,x2,x3;

Half_Adder inst1(x1,x2,A,B);
Half_Adder inst2(Sum,x3,CI,x1);
or inst3(Carry,x2,x3);

endmodule

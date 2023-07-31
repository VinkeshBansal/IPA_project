`timescale 1ns/10ps

module bit64_sub_tb;

 reg signed [63:0]A;
  reg signed [63:0]B;

  wire signed [63:0]diff;
  wire overflow;


  bit64_sub UUT(diff,overflow,A,B);

  initial 
    begin
		$dumpfile("bit64_sub_tb.vcd");
        $dumpvars(0,bit64_sub_tb);
		A = 64'b0;
		B = 64'b0;

    end
    
    initial
    begin

      #100
      B = 64'd33333333333;
      A = 64'd22222222222;
      #100
      B = 64'd22222222222;
      A = 64'd22222222222;
      #100
      B = 64'd9999;
      A = 64'd9999999999999;
      #100
      B=64'b1;
    end

	
  initial 
		$monitor("a=%d b=%d diff=%d overflow=%d\n",A,B,diff,overflow);
endmodule


    


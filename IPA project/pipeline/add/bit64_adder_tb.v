`timescale 1ns/10ps

module bit64_adder_tb;

 reg signed [63:0]A;
  reg signed [63:0]B;

  wire signed [63:0]sum;
  wire overflow;


  bit64_adder UUT(sum,overflow,A,B);

  initial 
    begin
		$dumpfile("bit64_adder_tb.vcd");
        $dumpvars(0,bit64_adder_tb);
		A = 64'b0;
		B = 64'b0;

    end
    
    initial
    begin

      #100
      B = 64'd11111111111;
      A = 64'd222222;
      #100
      B=64'b1;
    end

	
  initial 
		$monitor("a=%d b=%d sum=%d overflow=%d\n",A,B,sum,overflow);
endmodule


    


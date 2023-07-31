`timescale 1ns/10ps

module bit64_and_tb;

 reg signed [63:0]A;
  reg signed [63:0]B;

  wire signed [63:0]ans;
  


  bit64_and UUT(ans,A,B);

  initial 
    begin
		$dumpfile("bit64_and_tb.vcd");
        $dumpvars(0,bit64_and_tb);
		A = 64'b0;
		B = 64'b0;

    end
    
    initial
    begin

      #100
      B = 64'b1010101010101010;;
      A = 64'b0101010101010101;
      #100
      B=64'b1;
    end

	
  initial 
		$monitor("a=%d b=%d ans=%d \n",A,B,ans);
endmodule


    


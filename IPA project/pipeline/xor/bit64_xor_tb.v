`timescale 1ns/10ps

module bit64_xor_tb;

 reg signed [63:0]A;
  reg signed [63:0]B;

  wire signed [63:0]ans;
  


  bit64_xor UUT(ans,A,B);

  initial 
    begin
		$dumpfile("bit64_xor_tb.vcd");
        $dumpvars(0,bit64_xor_tb);
		A = 64'b0;
		B = 64'b0;

    end
    
    initial
    begin

      #100
      B = 64'd11;
      A = 64'd4;
      #100
      B = 64'd11;
      A = 64'd12;
      #100
      B = -64'd11;
      A = 64'd12;
      #100
      B = 64'd9;
      A = 64'd9;
      #100
      B = -64'd2;
      A = 64'd13;
      #100
      B = -64'd2;
      A = -64'd13;
      #100
      B = -64'd2;
      A = -64'd13;
      
    end

	
  initial 
		$monitor("a=%d b=%d ans=%d \n",A,B,ans);
endmodule


    




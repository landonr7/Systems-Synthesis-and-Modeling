module alu(
	input [15:0]  a, b,
	input [3:0]   sel,	
	output [15:0]  out
	);			

	reg [15:0] result;
	
	assign	out = result;
    
always @(posedge a, b, sel)
  begin
		case (sel)
		  4'b0000: result = a + b ;
      4'b0001: result = a - b ;
      4'b0010: result = ~a;	
      4'b0011: result = ~b;	
      4'b0100: result = a & b;
      4'b0101: result = a | b;
      4'b0110: result = a ^ b;
      4'b0111: result = ~(a ^ b);
		  4'b1000: result = a + b ; 
		  4'b1001: result = a - b ;
      default: result = 0;
		endcase
  end

endmodule

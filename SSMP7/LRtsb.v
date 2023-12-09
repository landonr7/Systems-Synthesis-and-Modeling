module tsb(
	input [15:0]	in,
	input tsb_en,
	output reg [15:0]	out

);
	always @(in or tsb_en)
	begin if(tsb_en)
		out = in;
	else out = 16'bZ;
	end
endmodule

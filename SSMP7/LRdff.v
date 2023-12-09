module dff(
	input wire [15:0] d,
	input en, reset, clk,
	output reg [15:0]	q
);
always @(posedge clk)
	if (!reset)
		q <= 16'bZ;
	else if (en)
		q <= d;
endmodule

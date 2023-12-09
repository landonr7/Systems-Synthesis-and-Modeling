module pc (
	input clk, reset, inc,
	output reg [15:0] 	pc_out
);

always @(posedge clk)
  if (!reset)
		pc_out = 16'd0;
	else if (inc)
			pc_out = pc_out + 1;
endmodule

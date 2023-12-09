module alu_module(
	input	reset,
	input	clk,
	input	[15:0]	bus_in,
	input	alu_a, //input 1
	input	alu_b, //input 2
	input	[3:0]	sel, //select input
	input	alu_in_en, //result dff enable
	input	alu_out_en, //tsb enable
	output wire [15:0] bus_out
);

//input 1 register
wire [15:0] a_to_alu;
dff a (
	.clk	(clk),
	.reset	(reset),
	.d		(bus_in),
	.en	(alu_a),
	.q		(a_to_alu)
);

//input 2 register
wire [15:0] b_to_alu;
dff b (
	.clk	(clk),
	.reset	(reset),
	.d		(bus_in),
	.en	(alu_b),
	.q		(b_to_alu)
);

//alu
wire [15:0]	alu_out;
alu alu (
	.a		(a_to_alu),
	.b		(b_to_alu),
	.sel	(sel),
	.out		(alu_out)
);

//result register
wire [15:0] result_to_tsb;
dff reg_result (
	.clk	(clk),
	.reset	(reset),
	.d		(alu_out),
	.en	(alu_in_en),
	.q		(result_to_tsb)
);

//tristate buffer
tsb tsb (
	.in		(result_to_tsb),
	.tsb_en	(alu_out_en),
	.out	(bus_out)
);

endmodule


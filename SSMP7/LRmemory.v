`timescale 10ns / 10ps

module memory(
	input clk, rw, enable,
	input	[15:0]	addr, data_in,
	output reg [15:0]	data_out,
	output	reg	mfc
);

reg	[15:0]	memory_cell; 

always @(posedge clk) begin
	if(enable) begin
		if (rw) begin
			case(addr)
			 16'd0:	data_out = 16'b1011000000011001;
			 16'd1:	data_out = 16'b1010000011000000;
			 16'd2:	data_out = 16'b1000000011000011;
			 16'd3:	data_out = 16'b1001000000000010;
			 16'd4:	data_out = 16'b0110000000000011;
			 16'd5:	data_out = 16'b0010000011000000;
			 16'd6:	data_out = 16'b1101000000000011;
			 16'd7:	data_out = 16'b1100000011000100;
			 default:	data_out = memory_cell;
			endcase
		 end
		else begin
			memory_cell = data_in;
		end
		#10 mfc = 1;
	end
end

always @(negedge enable) begin
 mfc = 0;
end
endmodule

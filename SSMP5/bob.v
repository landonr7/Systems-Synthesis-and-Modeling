module bus(
  input wire clk,
  input wire rst,
  output [3:0] bus,
  input [3:0] R0oe,
  input [3:0] R1ie,
  input [3:0] R0ie,
  input [3:0] R1oe
  );

  dff4bit R0 (
    .clk(clk),
    .rst(rst),
    .d_in(R0ie),
    .q(R0oe)
  );
  
  tsb4bit T0 (
    .b_in(R0oe),
    .b_out(bus)
    );

  dff4bit R1 (
    .clk(clk),
    .rst(rst),
    .d_in(R1ie),
    .q(R1oe)
  );
  
  tsb4bit T1 (
    .b_in(R1oe),
    .b_out(bus)
    );

endmodule

module dff4bit(
  input wire clk,
  input wire rst,
  input [3:0] d_in,
  output reg [3:0] q
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      q <= 4'bzzzz;
    end
    else if (d_in) begin
      q <= 4'b1111;
    end
  end

endmodule

module tsb4bit(

  input [3:0] b_in,
  output reg [3:0] b_out
);

  always @(b_in) begin
    if (b_in) begin
      b_out = 4'b0000;
    end
    else begin
      b_out = 4'bzzzz;
    end   
  end

endmodule

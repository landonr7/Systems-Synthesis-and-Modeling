`timescale 1ns / 10ps

module counter1stb;
  reg [7:0] in;
  
  wire [3:0] y;
  
  counter1s uut (.in(in), .y(y));
  
  initial begin
  
    for (in = 0; in < 256; in = in + 1)
    begin
    #30;
    end
  end
endmodule
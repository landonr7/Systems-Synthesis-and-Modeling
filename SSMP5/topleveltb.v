`timescale 1ns / 10ps

module topleveltb;

  reg clk;
  reg rst;
  wire [3:0] bus;  
  reg [3:0] R0oe;
  reg [3:0] R1ie;
  reg [3:0] R0ie;
  reg [3:0] R1oe;

  bus dut(
    .clk(clk),
    .rst(rst),
    .R0oe(R0oe),
    .R1ie(R1ie),
    .R0ie(R0ie),
    .R1oe(R1oe),
    .bus(bus)
  );

  always begin
    #5 clk = ~clk;
  end
  
  initial begin
    clk = 0;
    rst = 1;
    R0oe = 0;
    R1oe = 0;
    R0ie = 0;
    R1ie = 0;
    
    #5 rst = 0;
    #10;
    
    R0oe = 1;
    #20 R1ie = 1;
    #30 R1ie = 0;
    #20 R0oe = 0;
    
    #50;
    
    R1oe = 1;
    #20 R0ie = 1;
    #30 R0ie = 0;
    #20 R1oe = 0;
    
    #10;
  end

endmodule

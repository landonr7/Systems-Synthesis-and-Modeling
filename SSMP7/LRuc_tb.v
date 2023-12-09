`timescale 10ns / 1ns

module uc_tb;
   reg clk, reset, mfc;
   reg [15:0] data_to_mbr;
   reg [15:0] p1_from_tb;
   reg p1_in_en;

   wire rw, enable;
   wire [15:0] addr;
   wire [15:0] p0_to_tb;
   wire [15:0] mbr_to_tb;
   wire [15:0] bus_val;

   wire mfc_mem_to_controller;
   wire [15:0] mem_data_to_mbr;

memory memory (
  .clk(clk),
  .data_out(mem_data_to_mbr),
  .mfc(mfc_mem_to_controller),
  .rw(rw),
  .enable(enable),
  .addr(addr),
  .data_in(mbr_to_tb)
);

uc_top uc_top (
  .clk(clk),
  .reset(reset),
  .mfc(mfc_mem_to_controller),
  .data_to_mbr(mem_data_to_mbr),
  .p1_from_tb(p1_from_tb),
  .p1_in_en(p1_in_en),
  .enable(enable),
  .rw(rw),
  .addr(addr),
  .p0_to_tb(p0_to_tb),
  .mbr_to_tb(mbr_to_tb),
  .bus_val(bus_val)
);

always #2 clk = ~clk;

initial begin
  clk       <= 0;
  reset     <= 0;
  p1_in_en  <= 1;

  #10 reset  <= 1;
  p1_from_tb <= 16'b1111000011110000; // #F0F0
end
endmodule

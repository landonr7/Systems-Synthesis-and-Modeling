`timescale 1ns / 10ps

module mux7to1tb;
  reg in0;
  reg in1;
  reg in2;
  reg in3;
  reg in4;
  reg in5;
  reg in6;
  reg [2:0] sel;
  
  wire z;
  
  reg [2:0] count = 3'd0;
  
  mux7to1 uut (.in0(in0), .in1(in1), .in2(in2), .in3(in3), .in4(in4), .in5(in5), .in6(in6), .sel(sel), .z(z));

  initial begin
    in0 = 0;
    in1 = 0;
    in2 = 0;
    in3 = 0;
    in4 = 0;
    in5 = 0;
    in6 = 0;
    sel = 0;
  
    #100
  
    in0 = 2'b00;
    in1 = 2'b01;
    in2 = 2'b11;
    in3 = 2'b11;
    in4 = 2'b10;
    in5 = 2'b01;
    in6 = 2'b10;
  
    for (count = 0; count < 7; count = count + 1'b1)
    begin
      sel = count;
    
      #20;
    end
  end
endmodule
`timescale 1ns / 10ps

module BCDcountertb;
  reg clk;
  reg reset;
  
  wire [3:0] count;
  
  BCDcounter uut (.clk(clk), .reset(reset), .count(count));
    
    always
    begin
    #5 clk = ~clk;
    end
     
    initial
    begin
      clk = 0;
      reset = 1;
      
      #10;
      
      reset = 0;
      
      #20;
    end
endmodule    
module BCDcounter(clk, reset, count);
  input clk;
  input reset;
  output reg [3:0] count;

  always @(posedge(clk) or posedge(reset))
    begin
    if (reset == 1)
      count <= 5;
      if (count == 9)
        count <= 0;
      else
        count = count + 1;
      
    end
endmodule 
  

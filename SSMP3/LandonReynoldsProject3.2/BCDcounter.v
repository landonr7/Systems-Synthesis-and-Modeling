module BCDcounter(clk, reset, count);
  input clk;
  input reset;
  output reg [3:0] count;

  always @(posedge(clk) or posedge(reset))
    begin
    if (reset)
    begin
      count <= 5;
    end
    else
    begin
      count <= count + 1;
      if (count == 9)
      begin
        count <= 0;
      end
    end
    end
endmodule 
  

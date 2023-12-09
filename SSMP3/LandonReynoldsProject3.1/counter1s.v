module counter1s (in, y);

input [7:0] in;

integer count;

output reg[3:0] y;


  always @(in)
  begin
      y = 0;
      for (count = 0; count < 8; count = count + 1)
      begin
        if(in[count] == 1'b1)
        begin
          y = y + 1;
        end  
      end
  end
endmodule
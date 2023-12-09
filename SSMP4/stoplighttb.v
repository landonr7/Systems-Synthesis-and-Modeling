`timescale 1 ns / 10 ps

module stoplighttb;

  reg clk;      
  reg rst;      
  reg st0;      
  reg st1;      
  reg st2;      
  reg st3;      

  wire r;       
  wire y;       
  wire g;       


  stoplight dut (
    .clk(clk),
    .rst(rst),
    .start(1'b0), 
    .r(r),
    .y(y),
    .g(g)
  );


  always begin
    #5 clk = ~clk;
  end

 
  initial begin
    clk = 0;
    rst = 0;
    st0 = 1;
    st1 = 0;
    st2 = 0;
    st3 = 0;


    rst = 1;
    #5 rst = 0;

 
    #20 rst = 0;
    #10 st0 = 0; 

 
    #10 st1 = 1;
    #30 st1 = 0;
     
    #10 st2 = 1;
    #30 st2 = 0;
    
    #10 st3 = 1;
    #30 st3 = 0;

    #10 $finish;
  end
endmodule



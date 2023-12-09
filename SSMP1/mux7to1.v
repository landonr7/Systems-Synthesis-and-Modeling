module mux7to1 (in0, in1, in2, in3, in4, in5, in6, sel, z);

  input in0, in1, in2, in3, in4, in5, in6;
  input [2:0] sel;
  
  output z;
  
  reg z;
                
  always @ (in0 or in1 or in2 or in3 or in4 or in5 or in6 or sel) 
    begin
      case(sel)
        3'b000 : z <= in0;
        3'b001 : z <= in1;
        3'b010 : z <= in2;
        3'b011 : z <= in3;
        3'b100 : z <= in4;
        3'b101 : z <= in5;
        3'b110 : z <= in6;
        default : z <= 1'bx;
      endcase
    end
endmodule

      
      
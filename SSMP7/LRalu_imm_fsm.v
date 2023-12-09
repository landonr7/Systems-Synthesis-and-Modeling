module alu_imm_fsm(
  input reset, clk, start,
  output reg alu_a, reg_out, alu_b, reg_dest, pc_inc, done, alu_in_en, alu_out_en
  
);

reg [3:0] pres_state, next_state;

parameter	st0 = 4'b0000;
parameter	st1 = 4'b0001;
parameter	st2 = 4'b0010;
parameter	st3 = 4'b0011;
parameter	st4 = 4'b0100;
parameter	st5 = 4'b0101;
parameter	st6 = 4'b0110;
parameter	st7 = 4'b0111;
parameter st8 = 4'b1000;

always @(posedge clk) begin
  if (!reset) 
    pres_state <= st0;
  else 
    pres_state <= next_state;
end

always @(posedge clk) begin
  case (pres_state)
    st0: begin 
      if (start) 
        next_state <= st1;
      else 
        next_state <= st0; 
             end
    st1: next_state <= st2;
    st2: next_state <= st3;
    st3: next_state <= st4;
    st4: next_state <= st5;
    st5: next_state <= st6;
    st6: next_state <= st7;
    st7: next_state <= st8;
    st8: next_state <= st0;
  endcase
end

always @(pres_state) begin
  alu_a      <= 1'b0;
  reg_out    <= 1'b0;
  alu_b      <= 1'b0;
  reg_dest   <= 1'b0;
  pc_inc     <= 1'b0;
  done       <= 1'b0;
  alu_in_en  <= 1'b0;
  alu_out_en <= 1'b0;
    
    case (pres_state)
      st0: ;
      st1: begin 
        alu_a <= 1'b1; 
      end
      st2: begin 
        alu_a <= 1'b0; 
      end
      st3: begin 
        reg_out <= 1'b1;
        alu_b   <= 1'b1;
      end
      st4: begin 
        reg_out <= 1'b0;
        alu_b   <= 1'b0;
      end
      st5: begin 
        alu_in_en  <= 1'b1;
        alu_out_en <= 1'b1;
      end
      st6: begin 
        reg_dest <= 1'b1;
        pc_inc   <= 1'b1;
      end
      st7: begin 
        alu_in_en   <= 1'b0;
        alu_out_en  <= 1'b0;
        reg_dest    <= 1'b0;
        pc_inc      <= 1'b0;
        done        <= 1'b1;
      end
      st8: begin 
        done <= 1'b0;
      end
    endcase
end
endmodule

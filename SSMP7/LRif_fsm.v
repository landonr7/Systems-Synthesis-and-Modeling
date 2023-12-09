module if_fsm(
  input reset, clk, done, mfc,
  output reg pc_out, mar_en, rw, enable, mbr_in_en, mbr_out_en, ir_en
  
);

reg [3:0] pres_state, next_state;

//states
parameter	st0 = 4'b0000;
parameter	st1 = 4'b0001;
parameter	st2 = 4'b0010;
parameter	st3 = 4'b0011;
parameter	st4 = 4'b0100;
parameter	st5 = 4'b0101;
parameter	st6 = 4'b0110;
parameter	st7 = 4'b0111;

//finite state machine behavior
always @(posedge clk) begin
  if (!reset) 
    pres_state <= st0;
  else 
    pres_state <= next_state;
end

always @(posedge clk) begin
  case (pres_state)
    st0: begin 
      if (reset) 
        next_state  <= st1;
      else 
        next_state  <= st0; 
    end
    st1: next_state <= st2;
    st2: next_state <= st3;
    st3: begin 
      if (mfc) 
        next_state  <= st4;
      else 
        next_state  <= st3; 
    end
    st4: next_state <= st5;
    st5: next_state <= st6;
    st6: next_state <= st7;
    st7: if (done) 
           next_state <= st0;
         else 
           next_state <= st7;
    endcase
end

always@(pres_state) begin
  pc_out     <= 1'b0; 
  mar_en     <= 1'b0;
  rw         <= 1'b0;
  enable     <= 1'b0;
  mbr_in_en  <= 1'b0;
  mbr_out_en <= 1'b0;
  ir_en      <= 1'b0;

  case (pres_state)
    st0: ;    
    st1: begin
      pc_out <= 1'b1;
      mar_en <= 1'b1;
    end
    st2: begin
      pc_out <= 1'b0;
      mar_en <= 1'b0;
      rw     <= 1'b1;
      enable <= 1'b1;
    end    
    st3:  begin
      rw     <= 1'b1;
      enable <= 1'b1;
    end
    st4:  begin
      rw         <= 1'b0;
      enable     <= 1'b0;
      mbr_in_en  <= 1'b1;
      mbr_out_en <= 1'b1;
      ir_en      <= 1'b1;
    end
    st5: begin
      mbr_in_en  <= 1'b1;
      mbr_out_en <= 1'b1;
      ir_en      <= 1'b1;
    end
    st6: begin
      mbr_in_en  <= 1'b1;
      mbr_out_en <= 1'b1;
      ir_en      <= 1'b1;
    end
    st7:  begin
      mbr_in_en  <= 1'b0;
      mbr_out_en <= 1'b0;
      ir_en      <= 1'b0;
    end
  endcase
end
endmodule

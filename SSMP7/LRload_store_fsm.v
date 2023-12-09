module load_store_fsm(
  input reset, clk, start, mfc, load,
  output reg reg_out, mbr_en, mar_en, enable, rw, mbr_in_en, mbr_out_en, reg_in, pc_inc, done  
  
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
parameter	st8 = 4'b1000;
parameter	st9 = 4'b1001;
parameter	st10 = 4'b1010;
parameter	st11 = 4'b1011;
parameter	st12 = 4'b1100;

always @(posedge clk,  negedge clk) begin
  if (!reset) 
    pres_state <= st0;
  else 
    pres_state <= next_state;
end

always @(posedge clk, negedge clk) begin
  case (pres_state)
    st0:  
      if (start) 
        next_state <= st1;
      else 
        next_state <= st0;
    st1:  
      if (load) 
        next_state <= st2;
      else 
        next_state <= st7;
    st2:  next_state <= st3;
    st3:  next_state <= st4;
    st4:  next_state <= st5;
    st5:  next_state <= st6;
    st6:  
      if (mfc) 
        next_state <= st9;
      else 
        next_state <= st6;
    st7:  next_state <= st8;
    st8:  
      if (mfc) 
        next_state <= st9;
      else 
        next_state <= st8;
    st9:  next_state <= st10;
    st10: next_state <= st11;
    st11: next_state <= st12;
    st12: next_state <= st0;
  endcase
end

always @(pres_state)
begin
    reg_out    <= 1'b0;
    mbr_en     <= 1'b0;
    mar_en     <= 1'b0;
    enable     <= 1'b0;
    rw         <= 1'b0;
    mbr_in_en  <= 1'b0;
    mbr_out_en <= 1'b0;
    reg_in     <= 1'b0;
    pc_inc     <= 1'b0;
    done       <= 1'b0;

    case (pres_state)
        st0: ;
        st1: begin
                reg_out <= 1'b1;
            end
        st2:   begin
                reg_out    <= 1'b1;
                mar_en     <= 1'b1;
                rw         <= 1'b1;
                enable     <= 1'b1;
            end
        st3:   begin
                reg_out    <= 1'b1;
                mar_en     <= 1'b1;
                rw         <= 1'b1;
                enable     <= 1'b1;
            end
        st4:   begin
                reg_out    <= 1'b0;
                mar_en     <= 1'b0;
                mbr_out_en <= 1'b1;
                mbr_in_en  <= 1'b1;
                rw         <= 1'b1;
                enable     <= 1'b1;
            end
        st5:   begin
                mbr_in_en  <= 1'b1;
                mbr_out_en <= 1'b1;
                reg_in     <= 1'b1;
                rw         <= 1'b1;
                enable     <= 1'b1;
            end
        st6:   begin
                mbr_in_en  <= 1'b1;
                mbr_out_en <= 1'b1;
                reg_in     <= 1'b1;
                rw         <= 1'b1;
                enable     <= 1'b1;
            end
        st7:  begin
                reg_out    <= 1'b1;
                mbr_en     <= 1'b1;
                enable     <= 1'b1;
                reg_in     <= 1'b1;
            end
        st8:  begin
                reg_out    <= 1'b1;
                mbr_en     <= 1'b1;
                enable     <= 1'b1;
                reg_in     <= 1'b1;
            end
        st9:  begin
                reg_out    <= 1'b0;
                mbr_en     <= 1'b0;
                enable     <= 1'b1;
                reg_in     <= 1'b0;
                mbr_in_en  <= 1'b0;
                mbr_out_en <= 1'b0;
                rw         <= 1'b0;
            end
        st10 :  begin
                enable     <= 1'b0;
                pc_inc     <= 1'b1;
            end
        st11: begin
                pc_inc     <= 1'b0;
                done       <= 1'b1;
            end
        st12: begin
                done       <= 1'b0;
            end
    endcase
end
endmodule


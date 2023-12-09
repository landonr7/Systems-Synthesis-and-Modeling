module movi_fsm(
  input reset, clk, start,
  output reg reg_dest_en, pc_inc, done, movi_out 
  
);

reg [2:0] pres_state, next_state;

parameter	st0 = 3'b000;
parameter	st1 = 3'b001;
parameter	st2 = 3'b010;
parameter	st3 = 3'b011;
parameter	st4 = 3'b100;
parameter	st5 = 3'b101;
parameter	st6 = 3'b110;

always @(posedge clk) begin
  if (!reset)
    pres_state <= st0;
  else
    pres_state <= next_state;
end

always @(posedge clk) begin
  case (pres_state)
    st0: 
    if (start) 
      next_state <= st1;
    else 
      next_state <= st0;
    st1: next_state <= st2;
    st2: next_state <= st3;
    st3: next_state <= st4;
    st4: next_state <= st5;
    st5: next_state <= st6;
    st6: next_state <= st0;
  endcase
end

always @(pres_state)
begin
    reg_dest_en <= 1'b0;
    pc_inc      <= 1'b0;
    done        <= 1'b0;
    movi_out    <= 1'b0;

    case (pres_state)
      st0: ;
      st1: ;
      st2: begin
        movi_out    <= 1'b1;
        reg_dest_en <= 1'b1;
      end
      st3: begin
        movi_out    <= 1'b1;
        reg_dest_en <= 1'b1;
      end
      st4: begin
        movi_out    <= 1'b1;
        reg_dest_en <= 1'b1;
        pc_inc      <= 1'b1;
      end
      st5: begin
        pc_inc      <= 1'b0;
        movi_out    <= 1'b0;
        reg_dest_en <= 1'b0;
        done        <= 1'b1;
      end
      st6: begin
        done        <= 1'b0;
      end
    endcase
end
endmodule

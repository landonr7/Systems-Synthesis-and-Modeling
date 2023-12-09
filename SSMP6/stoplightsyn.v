
module stoplight ( clk, rst, start, r, y, g );
  input clk, rst, start;
  output r, y, g;
  wire   N4, N7, N16, N17, n12, n13, n23, n24, n25, n26, n28, n29;
  wire   [1:0] pres_state;
  wire   [1:0] next_state;
  assign r = N4;
  assign g = N7;

  AO21X2 U20 ( .IN1(n29), .IN2(n25), .IN3(y), .Q(n26) );
  NOR2X4 U21 ( .IN1(n25), .IN2(n29), .QN(y) );
  DFFX1 \next_state_reg[1]  ( .D(N17), .CLK(clk), .Q(next_state[1]) );
  DFFX1 \next_state_reg[0]  ( .D(N16), .CLK(clk), .Q(next_state[0]) );
  DFFARX1 \pres_state_reg[0]  ( .D(n13), .CLK(clk), .RSTB(n23), .Q(
        pres_state[0]) );
  DFFARX2 \pres_state_reg[1]  ( .D(n12), .CLK(clk), .RSTB(n23), .Q(
        pres_state[1]), .QN(n25) );
  ISOLANDX1 U26 ( .D(n29), .ISO(n28), .Q(N7) );
  NOR2X2 U27 ( .IN1(rst), .IN2(n29), .QN(N16) );
  NBUFFX2 U28 ( .IN(n26), .Q(n28) );
  NOR2X2 U29 ( .IN1(n29), .IN2(n28), .QN(N4) );
  NBUFFX8 U30 ( .IN(pres_state[0]), .Q(n29) );
  ISOLANDX1 U31 ( .D(n26), .ISO(rst), .Q(N17) );
  AO22X1 U32 ( .IN1(n29), .IN2(n24), .IN3(start), .IN4(next_state[0]), .Q(n13)
         );
  AO22X1 U33 ( .IN1(pres_state[1]), .IN2(n24), .IN3(next_state[1]), .IN4(start), .Q(n12) );
  INVX2 U34 ( .IN(start), .QN(n24) );
  INVX2 U35 ( .IN(rst), .QN(n23) );
endmodule


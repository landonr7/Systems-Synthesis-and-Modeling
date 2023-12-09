
module BCDcounter ( clk, reset, count );
  output [3:0] count;
  input clk, reset;
  wire   N8, N9, N10, n9, n16, n17, n18, n49, n51, n52, n53, n54, n55, n56;

  DFFARX1 \count_reg[3]  ( .D(N10), .CLK(clk), .RSTB(n49), .Q(count[3]), .QN(
        n16) );
  DFFARX1 \count_reg[1]  ( .D(N8), .CLK(clk), .RSTB(n49), .Q(count[1]), .QN(
        n18) );
  DFFASX1 \count_reg[2]  ( .D(N9), .CLK(clk), .SETB(n49), .Q(count[2]), .QN(
        n17) );
  DFFASX1 \count_reg[0]  ( .D(n9), .CLK(clk), .SETB(n49), .Q(count[0]), .QN(n9) );
  AND3X1 U38 ( .IN1(n52), .IN2(n51), .IN3(n53), .Q(N8) );
  NAND2X0 U39 ( .IN1(n9), .IN2(n18), .QN(n53) );
  OR2X1 U40 ( .IN1(n18), .IN2(n9), .Q(n51) );
  NAND3X0 U41 ( .IN1(n17), .IN2(count[3]), .IN3(n18), .QN(n52) );
  XOR2X1 U42 ( .IN1(n17), .IN2(n51), .Q(N9) );
  NAND2X0 U43 ( .IN1(n54), .IN2(n55), .QN(N10) );
  OR3X1 U44 ( .IN1(n51), .IN2(n17), .IN3(count[3]), .Q(n55) );
  OAI21X1 U45 ( .IN1(n56), .IN2(n9), .IN3(count[3]), .QN(n54) );
  OA21X1 U46 ( .IN1(n17), .IN2(n18), .IN3(n52), .Q(n56) );
  INVX0 U47 ( .IN(reset), .QN(n49) );
endmodule



module dff4bit_0 ( clk, rst, d_in, q );
  input [3:0] d_in;
  output [3:0] q;
  input clk, rst;
  wire   N6, N9, N12, N15, n15, n16, n17, n18, n19, n20, n21, n22, n23, n1;
  tri   [3:0] q;

  DFFASX1 \q_tri_enable_reg[3]  ( .D(n23), .CLK(clk), .SETB(n22), .Q(N6), .QN(
        n15) );
  DFFASX1 \q_tri_enable_reg[2]  ( .D(n21), .CLK(clk), .SETB(n22), .Q(N9), .QN(
        n16) );
  DFFASX1 \q_tri_enable_reg[1]  ( .D(n20), .CLK(clk), .SETB(n22), .Q(N12), 
        .QN(n17) );
  DFFASX1 \q_tri_enable_reg[0]  ( .D(n19), .CLK(clk), .SETB(n22), .Q(N15), 
        .QN(n18) );
  TNBUFFHX1 \q_tri[0]  ( .IN(1'b1), .ENB(n18), .Q(q[0]) );
  TNBUFFHX1 \q_tri[1]  ( .IN(1'b1), .ENB(n17), .Q(q[1]) );
  TNBUFFHX1 \q_tri[2]  ( .IN(1'b1), .ENB(n16), .Q(q[2]) );
  TNBUFFHX1 \q_tri[3]  ( .IN(1'b1), .ENB(n15), .Q(q[3]) );
  NOR2X0 U4 ( .IN1(n15), .IN2(n1), .QN(n23) );
  INVX0 U5 ( .IN(rst), .QN(n22) );
  NOR2X0 U6 ( .IN1(n16), .IN2(n1), .QN(n21) );
  NOR2X0 U7 ( .IN1(n17), .IN2(n1), .QN(n20) );
  NOR2X0 U8 ( .IN1(n18), .IN2(n1), .QN(n19) );
  OR4X1 U9 ( .IN1(d_in[1]), .IN2(d_in[0]), .IN3(d_in[3]), .IN4(d_in[2]), .Q(n1) );
endmodule


module tsb4bit_0 ( b_in, b_out );
  input [3:0] b_in;
  output [3:0] b_out;
  wire   n13;
  tri   [3:0] b_in;
  tri   [3:0] b_out;

  TNBUFFHX1 \b_out_tri[0]  ( .IN(1'b0), .ENB(n13), .Q(b_out[0]) );
  TNBUFFHX1 \b_out_tri[1]  ( .IN(1'b0), .ENB(n13), .Q(b_out[1]) );
  TNBUFFHX1 \b_out_tri[2]  ( .IN(1'b0), .ENB(n13), .Q(b_out[2]) );
  TNBUFFHX1 \b_out_tri[3]  ( .IN(1'b0), .ENB(n13), .Q(b_out[3]) );
  OR4X1 U3 ( .IN1(b_in[1]), .IN2(b_in[0]), .IN3(b_in[3]), .IN4(b_in[2]), .Q(
        n13) );
endmodule


module dff4bit_1 ( clk, rst, d_in, q );
  input [3:0] d_in;
  output [3:0] q;
  input clk, rst;
  wire   N6, N9, N12, N15, n1, n3, n4, n5, n6, n7, n8, n9, n10, n11;
  tri   [3:0] q;

  DFFASX1 \q_tri_enable_reg[3]  ( .D(n3), .CLK(clk), .SETB(n4), .Q(N6), .QN(
        n11) );
  DFFASX1 \q_tri_enable_reg[2]  ( .D(n5), .CLK(clk), .SETB(n4), .Q(N9), .QN(
        n10) );
  DFFASX1 \q_tri_enable_reg[1]  ( .D(n6), .CLK(clk), .SETB(n4), .Q(N12), .QN(
        n9) );
  DFFASX1 \q_tri_enable_reg[0]  ( .D(n7), .CLK(clk), .SETB(n4), .Q(N15), .QN(
        n8) );
  TNBUFFHX1 \q_tri[0]  ( .IN(1'b1), .ENB(n8), .Q(q[0]) );
  TNBUFFHX1 \q_tri[1]  ( .IN(1'b1), .ENB(n9), .Q(q[1]) );
  TNBUFFHX1 \q_tri[2]  ( .IN(1'b1), .ENB(n10), .Q(q[2]) );
  TNBUFFHX1 \q_tri[3]  ( .IN(1'b1), .ENB(n11), .Q(q[3]) );
  NOR2X0 U4 ( .IN1(n11), .IN2(n1), .QN(n3) );
  INVX0 U5 ( .IN(rst), .QN(n4) );
  NOR2X0 U6 ( .IN1(n10), .IN2(n1), .QN(n5) );
  NOR2X0 U7 ( .IN1(n9), .IN2(n1), .QN(n6) );
  NOR2X0 U8 ( .IN1(n8), .IN2(n1), .QN(n7) );
  OR4X1 U9 ( .IN1(d_in[1]), .IN2(d_in[0]), .IN3(d_in[3]), .IN4(d_in[2]), .Q(n1) );
endmodule


module tsb4bit_1 ( b_in, b_out );
  input [3:0] b_in;
  output [3:0] b_out;
  wire   n2;
  tri   [3:0] b_in;
  tri   [3:0] b_out;

  TNBUFFHX1 \b_out_tri[0]  ( .IN(1'b0), .ENB(n2), .Q(b_out[0]) );
  TNBUFFHX1 \b_out_tri[1]  ( .IN(1'b0), .ENB(n2), .Q(b_out[1]) );
  TNBUFFHX1 \b_out_tri[2]  ( .IN(1'b0), .ENB(n2), .Q(b_out[2]) );
  TNBUFFHX1 \b_out_tri[3]  ( .IN(1'b0), .ENB(n2), .Q(b_out[3]) );
  OR4X1 U3 ( .IN1(b_in[1]), .IN2(b_in[0]), .IN3(b_in[3]), .IN4(b_in[2]), .Q(n2) );
endmodule


module bus ( clk, rst, bus, R0oe, R1ie, R0ie, R1oe );
  output [3:0] bus;
  input [3:0] R0oe;
  input [3:0] R1ie;
  input [3:0] R0ie;
  input [3:0] R1oe;
  input clk, rst;

  tri   [3:0] bus;
  tri   [3:0] R0oe;
  tri   [3:0] R1oe;

  dff4bit_0 R0 ( .clk(clk), .rst(rst), .d_in(R0ie), .q(R0oe) );
  tsb4bit_0 T0 ( .b_in(R0oe), .b_out(bus) );
  dff4bit_1 R1 ( .clk(clk), .rst(rst), .d_in(R1ie), .q(R1oe) );
  tsb4bit_1 T1 ( .b_in(R1oe), .b_out(bus) );
endmodule


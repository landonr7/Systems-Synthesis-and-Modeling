
module counter1s ( in, y );
  input [7:0] in;
  output [3:0] y;
  wire   N9, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51;
  assign N9 = in[0];

  NAND2X0 U40 ( .IN1(n42), .IN2(n43), .QN(n38) );
  XOR2X1 U41 ( .IN1(n42), .IN2(n43), .Q(y[1]) );
  XOR2X1 U42 ( .IN1(n38), .IN2(n37), .Q(y[2]) );
  NOR2X0 U43 ( .IN1(n37), .IN2(n38), .QN(y[3]) );
  XNOR2X1 U44 ( .IN1(n50), .IN2(n51), .Q(n45) );
  NOR2X0 U45 ( .IN1(n44), .IN2(n45), .QN(n43) );
  XNOR2X1 U46 ( .IN1(n40), .IN2(n39), .Q(n47) );
  AOI21X1 U47 ( .IN1(n46), .IN2(n47), .IN3(n41), .QN(n42) );
  AOI21X1 U48 ( .IN1(n39), .IN2(n40), .IN3(n41), .QN(n37) );
  NOR2X0 U49 ( .IN1(n47), .IN2(n46), .QN(n41) );
  XOR2X1 U50 ( .IN1(n45), .IN2(n44), .Q(y[0]) );
  AO22X1 U51 ( .IN1(N9), .IN2(in[1]), .IN3(in[2]), .IN4(n48), .Q(n39) );
  AO22X1 U52 ( .IN1(in[3]), .IN2(in[4]), .IN3(in[5]), .IN4(n49), .Q(n40) );
  XNOR2X1 U53 ( .IN1(in[5]), .IN2(n49), .Q(n44) );
  AOI22X1 U54 ( .IN1(in[6]), .IN2(in[7]), .IN3(n50), .IN4(n51), .QN(n46) );
  XOR2X1 U55 ( .IN1(N9), .IN2(in[1]), .Q(n48) );
  XOR2X1 U56 ( .IN1(in[3]), .IN2(in[4]), .Q(n49) );
  XOR2X1 U57 ( .IN1(in[6]), .IN2(in[7]), .Q(n51) );
  XOR2X1 U58 ( .IN1(in[2]), .IN2(n48), .Q(n50) );
endmodule


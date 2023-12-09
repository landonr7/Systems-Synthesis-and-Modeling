module uc_top(
  input clk, reset, mfc,
  input [15:0] data_to_mbr,
  input [15:0] p1_from_tb,
  input p1_in_en,
    
  output wire enable, rw,
  output [15:0] addr,
  output reg [15:0] p0_to_tb,  
  output [15:0] mbr_to_tb,
  output wire [15:0] bus_val
 );    

  wire [15:0] bus;            
  wire [15:0] ir_to_decoder;  
  wire ir_en;          
  wire pc_inc;         
  wire mbr_in_en;      
  wire mbr_out_en;     
  wire alu_a;          
  wire alu_b;          
  wire gpr0_out_en;    
  wire gpr1_out_en;    
  wire gpr2_out_en;    
  wire gpr3_out_en;    
  wire p0_in_en;       
  wire p0_out_en;      
  wire p1_out_en;      
  wire pc_out;         
  wire mar_en;         
  wire mbr_en;         
  wire gpr0_in_en;     
  wire gpr1_in_en;     
  wire gpr2_in_en;     
  wire gpr3_in_en;     
  wire [3:0] opcode;         
  wire alu_in_en;      
  wire alu_out_en;     

  assign bus_val = bus;

dff ir (
  .clk(clk),
  .reset(reset),
  .d(bus),
  .en(ir_en),
  .q(ir_to_decoder)
);

decoder decoder (
  .clk(clk),
  .reset(reset),
  .mfc(mfc),
  .input_data(ir_to_decoder),
  .pc_inc(pc_inc),
  .rw(rw),
  .enable(enable),
  .mbr_in_en(mbr_in_en),
  .mbr_out_en(mbr_out_en),
  .alu_a(alu_a),
  .alu_b(alu_b),
  .gpr0_out_en(gpr0_out_en),
  .gpr1_out_en(gpr1_out_en),
  .gpr2_out_en(gpr2_out_en),
  .gpr3_out_en(gpr3_out_en),
  .p0_in_en(p0_in_en),
  .p0_out_en(p0_out_en),
  .p1_out_en(p1_out_en),
  .pc_out(pc_out),
  .ir_en(ir_en),
  .mar_en(mar_en),
  .mbr_en(mbr_en),
  .gpr0_in_en(gpr0_in_en),
  .gpr1_in_en(gpr1_in_en),
  .gpr2_in_en(gpr2_in_en),
  .gpr3_in_en(gpr3_in_en),
  .alu_in_en(alu_in_en),
  .alu_out_en(alu_out_en),
  .opcode(opcode),
  .movi_to_bus(bus)
);

wire [15:0] pc_to_tsb; 
pc pc (
  .clk(clk),
  .reset(reset),
  .inc(pc_inc),
  .pc_out(pc_to_tsb)
);

tsb tsb_pc (
  .in(pc_to_tsb),
  .tsb_en(pc_out),
  .out(bus)
);

wire [15:0] mar_addr;
dff mar (
  .clk(clk),
  .reset(reset),
  .d(bus),
  .en(mar_en),
  .q(mar_addr)
);

assign addr = mar_addr;

wire [15:0] mbr_in_to_tsb;
dff mbr_in (
  .clk(clk),
  .reset(reset),
  .d(bus),
  .en(mbr_en),
  .q(mbr_in_to_tsb)
);

assign mbr_to_tb = mbr_in_to_tsb;

wire [15:0] mbr_to_tsb;
dff mbr_out (
  .clk(clk),
  .reset(reset),
  .d(data_to_mbr),
  .en(mbr_in_en),
  .q(mbr_to_tsb)
);

tsb tsb_mdr (
  .in(mbr_to_tsb),
  .tsb_en(mbr_out_en),
  .out(bus)
);

alu_module alu_module (
  .clk(clk),
  .reset(reset),
  .bus_in(bus),
  .alu_a(alu_a),
  .alu_b(alu_b),
  .sel(opcode),
  .alu_in_en(alu_in_en),
  .alu_out_en(alu_out_en),
  .bus_out(bus)
);

wire [15:0] p0_out;

always @(p0_out)
begin
    p0_to_tb = p0_out;
end

dff p0 (
  .clk(clk),
  .reset(reset),
  .d(bus),
  .en(p0_in_en),
  .q(p0_out)
);

tsb p0_tsb (
  .in(p0_out),
  .tsb_en(p0_out_en),
  .out(bus)
);

wire [15:0] p1_out;
dff p1 (
  .clk(clk),
  .reset(reset),
  .d(p1_from_tb),
  .en(p1_in_en),
  .q(p1_out)
);

tsb p1_tsb (
  .in(p1_out),
  .tsb_en(p1_out_en),
  .out(bus)
);

wire [15:0] gpr0_to_tsb;
dff gpr0 (
  .clk(clk),
  .reset(reset),
  .d(bus),
  .en(gpr0_in_en),
  .q(gpr0_to_tsb)
);

tsb gpr0_tsb (
  .in(gpr0_to_tsb),
  .tsb_en(gpr0_out_en),
  .out(bus)
);

wire [15:0] gpr1_to_tsb;
dff gpr1 (
  .clk(clk),
  .reset(reset),
  .d(bus),
  .en(gpr1_in_en),
  .q(gpr1_to_tsb)
);

tsb gpr1_tsb (
  .in(gpr1_to_tsb),
  .tsb_en(gpr1_out_en),
  .out(bus)
);

wire [15:0] gpr2_to_tsb;
dff gpr2 (
  .clk(clk),
  .reset(reset),
  .d(bus),
  .en(gpr2_in_en),
  .q(gpr2_to_tsb)
);

tsb gpr2_tsb (
  .in(gpr2_to_tsb),
  .tsb_en(gpr2_out_en),
  .out(bus)
);

wire [15:0] gpr3_to_tsb;
dff gpr3 (
  .clk(clk),
  .reset(reset),
  .d(bus),
  .en(gpr3_in_en),
  .q(gpr3_to_tsb)
);

tsb gpr3_tsb (
  .in(gpr3_to_tsb),
  .tsb_en(gpr3_out_en),
  .out(bus)
);

endmodule
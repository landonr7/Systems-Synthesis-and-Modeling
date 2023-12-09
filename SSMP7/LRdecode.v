module decoder(
	input			reset, clk, mfc,
	input	[15:0]	input_data, //16-bit decoded data
	
	//control signals for alu, mar, mbr, i/o ports, and general purpose registers
	output reg	pc_inc, rw, enable, mbr_in_en, mbr_out_en, alu_a, alu_b, 
	gpr0_in_en, gpr1_in_en, gpr2_in_en, gpr3_in_en, 
	gpr0_out_en, gpr1_out_en, gpr2_out_en, gpr3_out_en, 
	p0_out_en, p1_out_en, p0_in_en, alu_in_en, alu_out_en, mar_en, 	
		
	output wire		pc_out, ir_en, mbr_en,
	output reg [3:0] opcode,
	output reg [15:0] movi_to_bus
);

	wire movi_out; //control signals to put data to bus
	reg [15:0] movi;
	
always @(posedge clk) begin
  if (movi_out) 	
		movi_to_bus = movi;
	else 					
	 movi_to_bus = 16'bz;			
end

//done control signal
reg  done;
wire done_alu_reg, done_alu_imm, done_mov, done_movi, done_load_store;
always @(posedge (done_alu_reg || done_alu_imm || done_mov || done_movi || done_load_store), 
		     negedge (done_alu_reg || done_alu_imm || done_mov || done_movi || done_load_store)) 
begin
  done = (done_alu_reg || done_alu_imm || done_mov || done_movi || done_load_store);
end

//program counter control signal
wire pc_inc_alu_reg, pc_inc_alu_imm, pc_inc_mov, pc_inc_movi, pc_inc_load_store;
always @(posedge (pc_inc_alu_reg || pc_inc_alu_imm || pc_inc_mov || pc_inc_movi || pc_inc_load_store), 
		     negedge (pc_inc_alu_reg || pc_inc_alu_imm || pc_inc_mov || pc_inc_movi || pc_inc_load_store)) 
begin
	pc_inc = (pc_inc_alu_reg || pc_inc_alu_imm || pc_inc_mov || pc_inc_movi || pc_inc_load_store);
end

//arithmetic logic unit control signals
wire alu_a_alu_reg, alu_b_alu_reg, alu_a_data, alu_b_data, alu_in_en_alu_reg, alu_in_en_data, alu_out_en_data, alu_out_en_alu_reg;
always @(posedge (alu_a_alu_reg || alu_a_data),
		     negedge (alu_a_alu_reg || alu_a_data))
begin
		alu_a = (alu_a_alu_reg || alu_a_data);
end
	
always @(posedge (alu_b_alu_reg || alu_b_data),
		     negedge (alu_b_alu_reg || alu_b_data))
begin
		alu_b = (alu_b_alu_reg || alu_b_data);
end

always @(posedge (alu_in_en_alu_reg || alu_in_en_data), 
		     negedge (alu_in_en_alu_reg || alu_in_en_data))
begin
		alu_in_en = (alu_in_en_alu_reg || alu_in_en_data);
end

always @(posedge (alu_out_en_alu_reg || alu_out_en_data), 
		     negedge (alu_out_en_alu_reg || alu_out_en_data))
begin
		alu_out_en = (alu_out_en_alu_reg || alu_out_en_data);
end

//read and write signal 
wire rw_if, rw_load_store;
always @(posedge (rw_if || rw_load_store), 
		     negedge (rw_if || rw_load_store))
begin
	rw = (rw_if || rw_load_store);
end

//enable control signal
wire enable_if, enable_load_store;
always @(posedge (enable_if || enable_load_store), 
		     negedge (enable_if || enable_load_store))
begin
	enable = (enable_if || enable_load_store);
end

//memory buffer register control signals
wire mbr_in_en_if, mbr_in_en_load_store;
always @(posedge (mbr_in_en_if || mbr_in_en_load_store),
         negedge (mbr_in_en_if || mbr_in_en_load_store))
begin
  mbr_in_en = (mbr_in_en_if || mbr_in_en_load_store);
end

wire mbr_out_en_if, mbr_out_en_load_store;
always @(posedge (mbr_out_en_if || mbr_out_en_load_store), 
		     negedge (mbr_out_en_if || mbr_out_en_load_store))
begin
	mbr_out_en = (mbr_out_en_if || mbr_out_en_load_store);
end

//memory address buffer control signal
wire mar_en_if, mar_en_load_store;
always @(posedge (mar_en_if || mar_en_load_store),
         negedge (mar_en_if || mar_en_load_store))
begin
  mar_en = (mar_en_if || mar_en_load_store);
end

//output register control signals
reg [2:0] reg1_sel, reg2_sel;

wire reg1_out_alu_reg, reg2_out_alu_reg, reg_out_data, reg_out_mov, reg_out_load_store;
always @(posedge (reg1_out_alu_reg || reg2_out_alu_reg || reg_out_data || reg_out_mov || reg_out_load_store),
         negedge (reg1_out_alu_reg || reg2_out_alu_reg || reg_out_data || reg_out_mov || reg_out_load_store))
begin
  case(reg1_sel)
    3'b000: begin //general purpose register 0
      if(reg1_out_alu_reg || reg_out_data || reg_out_load_store) 
        gpr0_out_en = 1;
      else 
        gpr0_out_en = 0;
    end
    3'b001: begin //general purpose register 1
      if(reg1_out_alu_reg || reg_out_data || reg_out_load_store) 
        gpr1_out_en = 1;
      else 
        gpr1_out_en = 0;
    end
    3'b010: begin //general purpose register 2
      if(reg1_out_alu_reg || reg_out_data || reg_out_load_store) 
        gpr2_out_en = 1;
      else 
        gpr2_out_en = 0;
    end
    3'b011: begin //general purpose register 1
      if(reg1_out_alu_reg || reg_out_data || reg_out_load_store) 
        gpr3_out_en = 1;
      else 
        gpr3_out_en = 0;
    end
    3'b100: begin //i/o port 0
      if(reg1_out_alu_reg || reg_out_data || reg_out_load_store) 
        p0_out_en = 1;
      else 
        p0_out_en = 0;
    end
    3'b101: begin //i/o port 1
      if(reg1_out_alu_reg || reg_out_data || reg_out_load_store) 
        p1_out_en = 1;
      else 
        p1_out_en = 0;
    end
  endcase
  case(reg2_sel)
    3'b000: begin //general purpose register 0
      if(reg2_out_alu_reg || reg_out_mov) 
        gpr0_out_en = 1;
      else 
        gpr0_out_en = 0;
    end
    3'b001: begin //general purpose register 1
      if(reg2_out_alu_reg || reg_out_mov) 
        gpr1_out_en = 1;
      else 
        gpr1_out_en = 0;
    end
    3'b010: begin //general purpose register 2
      if(reg2_out_alu_reg || reg_out_mov) 
        gpr2_out_en = 1;
      else 
        gpr2_out_en = 0;
    end
    3'b011: begin //general purpose register 3
      if(reg2_out_alu_reg || reg_out_mov) 
        gpr3_out_en = 1;
      else 
        gpr3_out_en = 0;
    end
    3'b100: begin //i/o port 0
      if(reg2_out_alu_reg || reg_out_mov) 
        p0_out_en = 1;
      else 
        p0_out_en = 0;
    end
    3'b101: begin //i/o port 1
      if(reg2_out_alu_reg || reg_out_mov) 
        p1_out_en = 1;
      else 
        p1_out_en = 0;
    end
  endcase
end

//input register control signals
wire reg_in_alu_reg, reg_in_alu_data, reg_in_mov, reg_in_movi, reg_in_load_store;
always @(posedge (reg_in_alu_reg || reg_in_alu_data || reg_in_mov || reg_in_movi), 
		 negedge (reg_in_alu_reg || reg_in_alu_data || reg_in_mov || reg_in_movi))
	begin
		case(reg1_sel)
			3'b000: 	begin
			 if(reg_in_alu_reg || reg_in_alu_data || reg_in_mov || reg_in_movi || reg_in_load_store) 
			   gpr0_in_en = 1;
			 else 
			   gpr0_in_en = 0;
			end
			3'b001: begin
				if(reg_in_alu_reg || reg_in_alu_data || reg_in_mov || reg_in_movi || reg_in_load_store) 
				  gpr1_in_en = 1;
				else 
				  gpr1_in_en = 0;
			end
			3'b010: begin
				if(reg_in_alu_reg || reg_in_alu_data || reg_in_mov || reg_in_movi || reg_in_load_store) 
				  gpr2_in_en = 1;
				else 
				  gpr2_in_en = 0;
			end
			3'b011: begin
			  if(reg_in_alu_reg || reg_in_alu_data || reg_in_mov || reg_in_movi || reg_in_load_store) 
			    gpr3_in_en = 1;
				else 
				  gpr3_in_en = 0;
			end
			3'b100: begin
				if(reg_in_alu_reg || reg_in_alu_data || reg_in_mov || reg_in_movi || reg_in_load_store) 
				  p0_in_en = 1;
				else 
				  p0_in_en = 0;
			end					
		endcase
end
	
always @(posedge reg_in_load_store, negedge reg_in_load_store)
	begin
		case(reg2_sel)
			3'b000: 	begin
			 if(reg_in_load_store) 
			   gpr0_in_en = 1;
			 else 
				 gpr0_in_en = 0;
			end
			3'b001: begin
			 if(reg_in_load_store) 
				  gpr1_in_en = 1;
			  else 
					gpr1_in_en = 0;
			end
			3'b010: begin
				if(reg_in_load_store) 
					gpr2_in_en = 1;
				else 
					gpr2_in_en = 0;
			end
			3'b011: begin
				if(reg_in_load_store) 
					gpr3_in_en = 1;
				else 
					gpr3_in_en = 0;
			end
			3'b100: begin
				if(reg_in_load_store) 
					p0_in_en = 1;
				else
					p0_in_en = 0;
			end					
		endcase
end

//decoder
reg start_alu_reg, start_alu_data, start_mov, start_movi, start_load_store;

reg [5:0] para1;
reg [5:0] para2;

wire [9:0]  fill;
assign fill = 10'b0000000000;
reg load;
always @(input_data)
	begin
		opcode	= input_data[15:12];
		para1	= input_data[11:6];
		para2	= input_data[5:0];
		
		case (opcode)
			4'b0000: start_alu_reg  = 1; //add
			4'b0001: start_alu_reg  = 1; //subtract
			4'b0010: start_alu_reg  = 1; //not
			4'b0011: start_alu_reg  = 1; //not
			4'b0100: start_alu_reg  = 1; //and
			4'b0101: start_alu_reg  = 1; //or
			4'b0110: start_alu_reg  = 1; //xor
			4'b0111: start_alu_reg  = 1;	//xnor
			4'b1000: start_alu_data = 1;	//addi
			4'b1001: start_alu_data = 1; //subi
			4'b1010: start_mov	= 1; //mov
			4'b1011: begin
				start_movi = 1; //movi
				movi	= { fill, para2 };
			end
			4'b1100: begin 				//Load
				start_load_store = 1;   
				load	= 1;
			end
			4'b1101: begin				//Store
			  start_load_store = 1; 
			  load	= 0;
			end
			default: begin
				start_alu_reg	= 0;
				start_alu_data	= 0;
				start_mov	= 0;
				start_movi	= 0;
				start_load_store	= 0;
				load	= 0;
			end
		endcase

		case (para1)
			6'b000000: reg1_sel = 3'b000; //register 0
			6'b000001: reg1_sel = 3'b001; //register 1
			6'b000010: reg1_sel = 3'b010; //register 2
			6'b000011: reg1_sel = 3'b011; //register 3
			6'b000100: reg1_sel = 3'b100; //port 0
			6'b000101: reg1_sel = 3'b101; //port 1
		endcase
		case (para2)
			6'b000000: reg2_sel = 3'b000; //register 0
			6'b000001: reg2_sel = 3'b001; //register 1
			6'b000010: reg2_sel = 3'b010; //register 2
			6'b000011: reg2_sel = 3'b011; //register 3			
			6'b000100: reg2_sel = 3'b100; //port 0
			6'b000101: reg2_sel = 3'b101; //port 1
		endcase
	end	
	
always@(done)
	begin
		start_alu_reg	= 0;
		start_alu_data	= 0;
		start_mov	= 0;
		start_movi	= 0;
		start_load_store	= 0;
		load	= 0;
	end
	
//finite state machines
//instruction fetch
if_fsm if_fsm(
  .clk(clk),
  .reset(reset),
  .done(done),
  .mfc(mfc),
  .pc_out(pc_out),
  .mar_en(mar_en_if),
  .rw(rw_if),
  .enable(enable_if),
  .mbr_in_en(mbr_in_en_if),
  .mbr_out_en(mbr_out_en_if),
  .ir_en(ir_en)
);

//register based alu
alu_reg_fsm alu_reg_fsm(
  .clk(clk),					
	.reset(reset),				
	.start(start_alu_reg),			
	.alu_in_en(alu_in_en_alu_reg),		
	.alu_out_en(alu_out_en_alu_reg),		
	.reg1_out(reg1_out_alu_reg),		
	.alu_a(alu_a_alu_reg),			
  .reg2_out(reg2_out_alu_reg),	
	.alu_b(alu_b_alu_reg),			
	.reg_dest(reg_in_alu_reg),		
	.pc_inc(pc_inc_alu_reg),	
	.done(done_alu_reg)
);

//immediate data based alu
alu_imm_fsm alu_imm_fsm(
  .clk(clk),					
	.reset(reset),				
	.start(start_alu_data),		
	.alu_in_en(alu_in_en_data),		
	.alu_out_en(alu_out_en_data),		
  .alu_a(alu_a_data),			
	.reg_out(reg_out_data),		
	.alu_b(alu_b_data),			
	.reg_dest(reg_in_alu_data),		
	.pc_inc(pc_inc_alu_imm),	
	.done(done_alu_imm)
);

//move
mov_fsm mov_fsm(
  .clk(clk),					
	.reset(reset),				
	.start(start_mov),		
	.reg_out_en(reg_out_mov),			
	.reg_dest_en(reg_in_mov),			
	.pc_inc(pc_inc_mov),		
	.done(done_mov)
);

//move immediate
movi_fsm movi_fsm(
  .clk(clk),				
	.reset(reset),			
	.start(start_movi),			
	.reg_dest_en(reg_in_movi),			
	.pc_inc(pc_inc_movi),	
	.done(done_movi),
	.movi_out(movi_out)
);	

//load and store
load_store_fsm load_store_fsm(
  .clk(clk),						
	.reset(reset),					
	.start(start_load_store),					
	.mfc(mfc),						
	.load(load),						
	.reg_out(reg_out_load_store),		
	.mbr_en(mbr_en),					
	.mar_en(mar_en_load_store),				
  .enable(enable_load_store),			
	.rw(rw_load_store),				
	.mbr_in_en(mbr_in_en_load_store),	
	.mbr_out_en(mbr_out_en_load_store),
	.reg_in(reg_in_load_store),			
	.pc_inc(pc_inc_load_store),	
	.done(done_load_store)	
);

endmodule









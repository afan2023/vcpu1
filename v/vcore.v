/**
 * the core definition
 */

module vcore (
	input 				clk,
	input					rst_n,
	
	// instruction mem interface
	input		[31:0]	instr,	
	output	[31:0]	instr_addr,
	output				imem_en,
	
	// data memory interface
	input		[31:0]	mem_rdata,
	output	[31:0]	mem_addr,
	output	[31:0]	mem_wdata,
	output				mem_en,
	output				mem_wr
);

	wire [31:0] new_pc;
	wire change_pc;
	wire halt;
	assign change_pc = 1'b0;	// not used before branch instr implementation
	assign new_pc = 32'h0; 		// not used before branch instr implementation

	pc u_pc(
		.clk				(clk),
		.rst_n			(rst_n),
		
		.new_pc			(new_pc),
		.change_pc		(change_pc),
		.halt				(halt),
		
		.instr_addr		(instr_addr),
		.instr_fetch_en(imem_en)
	);


	wire [5:0] opcode;

	wire [3:0] reg_w_i;
	wire [3:0] reg_a_i;
	wire [3:0] reg_b_i;
	wire [15:0] imm_data;

	wire reg_a_re;
	wire reg_b_re;
	wire imm_valid;
	wire sign;

	wire [1:0] reg_wr_scope;
	wire reg_we;
	instr_dec u_instr_dec(
		.rst_n(rst_n),
		.instr(instr),
		
		.op1_ri(reg_a_i),
		.re1(reg_a_re),
		.op2_ri(reg_b_i),
		.re2(reg_b_re),
		.imm_data(imm_data),
		.imm_valid(imm_valid),
		.sign(sign),
		
		.exe_opcode(opcode),
		.wr_ri(reg_w_i),
		.wr_scope(reg_wr_scope),
		.wre(reg_we),
		.pc_halt(halt)
		);


	wire [31:0] reg_a;
	wire [31:0] reg_b;
	wire [31:0] reg_w;

	reg_file u_reg_file(
		.clk(clk),
		.rst_n(rst_n),
		
		.reg_w_index(reg_w_i),
		.wr_data(reg_w),
		.we(reg_we),
		.wr_scope(reg_wr_scope),
		.reg_a_index(reg_a_i),
		.rea(reg_a_re),
		.reg_b_index(reg_b_i),
		.reb(reg_b_re),
		
		.rd_value_a(reg_a),
		.rd_value_b(reg_b)
		);

	wire [31:0] oprana;
	wire [31:0] opranb;

	gen_oprands u_gen_oprands(
		.re1(reg_a_re),
		.re2(reg_b_re),
		.imm_data(imm_data),
		.imm_valid(imm_valid),
		.sign(sign),
		
		.op1_rdata(reg_a),
		.op2_rdata(reg_b),
		
		.op1(oprana),
		.op2(opranb)
	);

	wire [31:0] alu_out;
	wire [2:0] alu_flags;

	alu u_alu(	
		.opcode(opcode),
		.in_a(oprana),
		.in_b(opranb),
		.out(alu_out), 
		.flags(alu_flags)
		);
		
	mem_cmd u_mem_cmd(
		.opcode(opcode),	
		.in_a(oprana),	
		.in_b(opranb),
		
		.mem_addr(mem_addr),
		.mem_wdata(mem_wdata),
		.mem_en(mem_en),
		.mem_wr(mem_wr)
		);

	wr_data_sel u_wr_data_sel(
		.rst_n(rst_n),
		.alu_out(alu_out),
		.mem_out(mem_rdata),
		.oprand2(opranb),
		.opcode(opcode),
		
		.wdata(reg_w)
	);
	

endmodule
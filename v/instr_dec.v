
`include "instr_syntax.v"
/**
 * instruction decode
 */
module instr_dec(
	input rst_n,	// reset
	
	input [31:0] instr, // instruction fetched
	
	// interface to reg file module
	output [3:0] op1_ri,// operand 1 reg index
	output re1,	// read enable signal to read operand 1 reg
	output [3:0] op2_ri,	// operand 2 reg index
	output re2,	// read enable for operand 2 reg
	
	// immediate number if present
	output [15:0] imm_data,
	output imm_valid,
	output sign,
	
	// interface to control execution & write back
	output [5:0] exe_opcode,	// operation code also output to the execution module
	output [3:0] wr_ri, // reg index to write
	output [1:0] wr_scope, // 2'b10: high half; 2'b01: low half; 2'b11: whole word
	output wre,	// will write back to reg
	
	// interface to PC
	output pc_halt
);

reg [3:0] op1_ri_r, op2_ri_r, wr_ri_r;
reg re1_r, re2_r, imm_valid_r, sign_r, wre_r, pc_halt_r;
reg [15:0] imm_data_r;
reg [5:0] exe_opcode_r;

wire [5:0] field_opcode; // opcode field in the instruction
assign field_opcode = instr[31:26];

always@(rst_n, instr)
if (!rst_n) begin
	exe_opcode_r <= `OPCODE_NOP;
	op1_ri_r <= 4'h0;
	re1_r <= 1'b0;
	op2_ri_r <= 4'h0;
	re2_r <= 1'b0;
	imm_data_r <= 16'h0;
	imm_valid_r <= 1'b0;
	sign_r <= 1'b0;
	wr_ri_r <= 4'h0;
	wre_r <= 1'b0;	
	pc_halt_r <= 1'b0;
end else case(field_opcode)
	`OPCODE_NOP: begin
		exe_opcode_r <= `OPCODE_NOP;
		op1_ri_r <= 4'h0;
		re1_r <= 1'b0;
		op2_ri_r <= 4'h0;
		re2_r <= 1'b0;
		imm_data_r <= 16'h0;
		imm_valid_r <= 1'b0;
		sign_r <= 1'b0;
		wr_ri_r <= 4'h0;
		wre_r <= 1'b0;	
		pc_halt_r <= 1'b0;
	end
	`OPCODE_HALT: begin
		exe_opcode_r <= `OPCODE_HALT;
		op1_ri_r <= 4'h0;
		re1_r <= 1'b0;
		op2_ri_r <= 4'h0;
		re2_r <= 1'b0;
		imm_data_r <= 16'h0;
		imm_valid_r <= 1'b0;
		sign_r <= 1'b0;
		wr_ri_r <= 4'h0;
		wre_r <= 1'b0;
		pc_halt_r <= 1'b1;
	end	
	`OPCODE_ADDU: begin
		exe_opcode_r <= field_opcode; // to think twice: maybe ALU need a different code?
		op1_ri_r <= instr[`FIELD_RI_1_ADDU];
		re1_r <= 1'b1;
		op2_ri_r <= instr[`FIELD_RI_2_ADDU];
		re2_r <= 1'b1;
		imm_valid_r <= 1'b0;
		sign_r <= 1'b0;
		wr_ri_r <= instr[`FIELD_RI_D_ADDU];
		wre_r <= 1'b1;
		pc_halt_r <= 1'b0;
	end
	`OPCODE_ADDUI: begin
		exe_opcode_r <= field_opcode; // to think twice: maybe ALU need a different code?
		op1_ri_r <= instr[`FIELD_RI_1_ADDUI];
		re1_r <= 1'b1;
		op2_ri_r <= 4'h0;
		re2_r <= 1'b0;
		imm_data_r <= instr[`FIELD_IMM_2_ADDUI];
		imm_valid_r <= 1'b1;
		sign_r <= 1'b0;
		wr_ri_r <= instr[`FIELD_RI_D_ADDUI];
		wre_r <= 1'b1;
		pc_halt_r <= 1'b0;
	end
	`OPCODE_LD: begin
		exe_opcode_r <= field_opcode;
		op1_ri_r <= 4'h0;
		re1_r <= 1'b0;
		op2_ri_r <= instr[`FIELD_RI_A_LD];
		re2_r <= 1'b1;
		wr_ri_r <= instr[`FIELD_RI_D_LD];
		imm_data_r <= 16'h0;
		imm_valid_r <= 1'b0;
		sign_r <= 1'b0;
		wre_r <= 1'b1;
		pc_halt_r <= 1'b0;
	end
	`OPCODE_ST: begin
		exe_opcode_r <= field_opcode;
		op1_ri_r <= instr[`FIELD_RI_S_ST];
		re1_r <= 1'b1;
		op2_ri_r <= instr[`FIELD_RI_A_ST];
		re2_r <= 1'b1;
		wr_ri_r <= 4'h0;
		imm_data_r <= 16'h0;
		imm_valid_r <= 1'b0;
		sign_r <= 1'b0;
		wre_r <= 1'b0;
		pc_halt_r <= 1'b0;
	end
	`OPCODE_MOV: begin
		exe_opcode_r <= field_opcode;
		op1_ri_r <= 4'h0;
		re1_r <= 1'b0;
		op2_ri_r <= instr[`FIELD_RI_S_MOV];
		re2_r <= 1'b1;
		wr_ri_r <= instr[`FIELD_RI_D_MOV];
		imm_data_r <= 16'h0;
		imm_valid_r <= 1'b0;
		sign_r <= 1'b0;
		wre_r <= 1'b1;
		pc_halt_r <= 1'b0;
	end	
	`OPCODE_MOVIL: begin
		exe_opcode_r <= field_opcode;
		op1_ri_r <= 4'h0;
		re1_r <= 1'b0;
		op2_ri_r <= 4'h0;
		re2_r <= 1'b0;
		wr_ri_r <= instr[`FIELD_RI_D_MOVIL];
		imm_data_r <= instr[`FIELD_IMM_MOVIL];
		imm_valid_r <= 1'b1;
		sign_r <= 1'b0;
		wre_r <= 1'b1;
		pc_halt_r <= 1'b0;
	end
	`OPCODE_MOVIH: begin
		exe_opcode_r <= field_opcode;
		op1_ri_r <= 4'h0;
		re1_r <= 1'b0;
		op2_ri_r <= 4'h0;
		re2_r <= 1'b0;
		wr_ri_r <= instr[`FIELD_RI_D_MOVIL];
		imm_data_r <= instr[`FIELD_IMM_MOVIL];
		imm_valid_r <= 1'b1;
		sign_r <= 1'b0;
		wre_r <= 1'b1;
		pc_halt_r <= 1'b0;
	end
endcase

assign wr_scope = (!wre_r)? 
						2'h0 
						: ((exe_opcode_r == `OPCODE_MOVIL)? 
							2'h1 
							: ((exe_opcode_r == `OPCODE_MOVIH)? 
								2'h2 
								: 2'h3
							)
						);

assign op1_ri = op1_ri_r;
assign op2_ri = op2_ri_r;
assign wr_ri = wr_ri_r;
assign re1 = re1_r;
assign re2 = re2_r;
assign imm_valid = imm_valid_r;
assign sign = sign_r;
assign wre = wre_r;
assign imm_data = imm_data_r;
assign exe_opcode = exe_opcode_r;
assign pc_halt = pc_halt_r;

endmodule
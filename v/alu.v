`include "instr_syntax.v"

module alu(
	input [5:0] opcode,	// operation code
	input [31:0] in_a,	// input a
	input [31:0] in_b,	// input b
	output [31:0] out,	// 
	output [2:0] flags	// flag[0] overflow, flag[1] zero, flag[2] negative
);

	reg [31:0] out_r;
	reg flag_overflow_r;
	reg flag_zero_r;
	reg flag_neg_r;

	reg [31:0] adder_in_b;
	wire [31:0] adder_out;
	wire adder_c;

	adder32 u_adder32(
		.a(in_a),
		.b(adder_in_b),
		.s(adder_out),
		.overflow(adder_c)
	);

	always@(*) begin
		case(opcode)
			`OPCODE_ADDU,`OPCODE_ADDUI: begin
				adder_in_b <= in_b;
				out_r <= adder_out;
				flag_overflow_r <= adder_c;
				flag_zero_r <= !(|adder_out);
				flag_neg_r <= 1'b0;
			end
			// tbc
			default: begin
				out_r <= 0;
				flag_overflow_r <= 1'b0;
				flag_zero_r <= 1'b0;
				flag_neg_r <= 1'b0;
			end			
		endcase
	end

	assign out = out_r;
	assign flags[0] = flag_overflow_r;
	assign flags[1] = flag_zero_r;
	assign flags[2] = flag_neg_r;

endmodule
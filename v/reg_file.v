
module reg_file(
	input clk,	// clock
	input rst_n,	// reset, low level valid

	input [3:0] reg_w_index, 	// index of reg to write
	input [31:0] wr_data,	// data to write into reg a
	input we,			// write enable
	input [1:0] wr_scope,	// scope of write (bit 1: high half, bit 0: low half)
	input [3:0] reg_a_index, // reg a index to read
	input rea,	// read enable reg n
	input [3:0] reg_b_index, // optional reg b index
	input reb,	// read enable optional reg b
	
	output [31:0] rd_value_a,	// data value of reg a read
	output [31:0] rd_value_b	// data value of reg b read
);

	reg [31:0] regs[15:0];

	integer i;
	always@(posedge clk or negedge rst_n)
	if (!rst_n) begin
		for (i = 0; i < 16; i = i+1)
			regs[i] <= 0;
	end
	else if (we) begin
		case (wr_scope)
			2'h1: regs[reg_w_index] <= (regs[reg_w_index] & 32'hffff0000) | (wr_data & 32'h0000ffff);
			2'h2: regs[reg_w_index] <= (regs[reg_w_index] & 32'h0000ffff) | (wr_data << 16);
			2'h3: regs[reg_w_index] <= wr_data;
			default: ;//should not happen
		endcase
	end

	reg [31:0] rd_value_a_r;
	reg [31:0] rd_value_b_r;

	// always@(posedge clk or negedge rst_n)
	always@(rst_n, rea, reg_a_index, regs)
	if (!rst_n) begin
		rd_value_a_r <= 0;
	end
	else if (rea)
		rd_value_a_r <= regs[reg_a_index];
	else
		rd_value_a_r <= 0;

	assign rd_value_a = rd_value_a_r;

	always@(rst_n, reb, reg_b_index, regs)
	if (!rst_n) begin
		rd_value_b_r <= 0;
	end
	else if (reb)
		rd_value_b_r <= regs[reg_b_index];
	else
		rd_value_b_r <= 0;

	assign rd_value_b = rd_value_b_r;

endmodule
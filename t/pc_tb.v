`timescale 1ns/100ps

module pc_tb;

	reg clk;
	reg rst_n;
		
	reg [31:0] new_pc;
	reg change_pc;
	reg halt;
		
	wire [31:0] instr_addr;
	wire instr_fetch_en;

	pc ut_pc(
		.clk					(clk),
		.rst_n				(rst_n),
		
		.new_pc				(new_pc),
		.change_pc			(change_pc),
		.halt					(halt),
		
		.instr_addr			(instr_addr),
		.instr_fetch_en	(instr_fetch_en)
	);

	initial clk = 1'b1;
	always #10 clk = ~clk;

	initial begin
		rst_n = 1'b1;
		new_pc = 32'h0;
		change_pc = 1'b0;
		halt = 1'b0;
		
		#10;
		rst_n = 1'b0;
		#21;
		rst_n = 1'b1;
		
		#100;
		
		new_pc = 32'h12580;
		change_pc = 1'b1;
		#20;
		change_pc = 1'b0;
		#100;
		
		halt = 1'b1;
		#100;
		
		$stop;
		
	end

endmodule
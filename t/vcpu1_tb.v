`timescale 1ns/100ps

module vcpu1_tb;

	reg clk;
	reg rst_n;
	wire [31:0] instr;
	wire [31:0]	instr_addr;
	wire imem_en;

	wire [31:0]	mem_rdata;
	wire [31:0] mem_addr;
	wire [31:0] mem_wdata;
	wire mem_en;
	wire mem_wr;

	vcore u_vcore (
		.clk			(clk),
		.rst_n		(rst_n),
		
		.instr		(instr),
		
		.instr_addr	(instr_addr),
		.imem_en		(imem_en),
		
		.mem_rdata	(mem_rdata),
		
		.mem_addr	(mem_addr),
		.mem_wdata	(mem_wdata),
		.mem_en		(mem_en),
		.mem_wr		(mem_wr)
	);

	instr_rom_t u_rom(
		.en				(imem_en),
		.addr				(instr_addr),
		
		.instruction	(instr)
	);

	data_mem u_data_mem(
		.clk(clk),
		.en(mem_en),
		.addr(mem_addr),		// address
		.wr(mem_wr),
		.wdata(mem_wdata),
		
		.rdata(mem_rdata)
		
	);


	initial clk = 1'b1;
	always #10 clk = ~clk;

	initial begin
		rst_n = 1'b1;
		#1;
		rst_n = 1'b0;
		#51;
		rst_n = 1'b1;
		#5000;
		$stop;
	end

endmodule
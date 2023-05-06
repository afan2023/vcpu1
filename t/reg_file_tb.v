`timescale 1ns/100ps

module reg_file_tb;

	reg clk;	// clock
	reg rst_n;	// reset, low level valid

	reg [4:0] reg_w_index; 	// index of reg to write
	reg [31:0] wr_data;	// data to write into reg a
	reg we;	// write enable reg a
	reg [1:0] wr_scope; // write scope
	reg [4:0] reg_a_index; // reg a index to read
	reg rea;	// read enable reg n
	reg [4:0] reg_b_index; // optional reg b index
	reg reb;	// read enable optional reg b
	
	wire [31:0] rd_value_a;	// data value of reg a read
	wire [31:0] rd_value_b;	// data value of reg b read

	reg_file ut_reg_file(
		.clk(clk),
		.rst_n(rst_n),
		
		.reg_w_index(reg_w_index),
		.wr_data(wr_data),
		.we(we),
		.wr_scope(wr_scope),
		.reg_a_index(reg_a_index),
		.rea(rea),
		.reg_b_index(reg_b_index),
		.reb(reb),
		
		.rd_value_a(rd_value_a),
		.rd_value_b(rd_value_b)
	);
	
	initial clk = 1'b1;
	always #10 clk = ~clk;
	
	initial begin		
		reg_w_index = 0;
		wr_data = 'h1230312;
		we = 1;
		wr_scope = 2'h1;
		#20;
		we = 0;
		#100;
		we = 1;
		
		repeat (15) begin
			#20;
			reg_w_index = reg_w_index + 1;
			wr_data = wr_data + 1;
			if (wr_scope < 2'h3)
				wr_scope = wr_scope + 1;
			else
				wr_scope = 2'h1;
		end
		
	end

	
	initial begin
		reg_a_index = 1;
		rea = 1;
		reg_b_index = 2;
		reb = 1;
		#200;
		
		rea = 0;
		reb = 0;
		reg_a_index = 0;
		reg_b_index = 15;
		#232;
		
		rea = 1;
		reb = 1;
		
		repeat (15) begin
			#20;
			reg_a_index = reg_a_index + 1;
			reg_b_index = reg_b_index - 1;
		end
		
	end

	initial begin
		rst_n = 1'b1;
		#30;
		rst_n = 1'b0;
		#51;
		rst_n = 1'b1;
		
		#700;
		
		$stop;
		
	end
	
endmodule
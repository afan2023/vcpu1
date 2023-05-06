`timescale 1ns/100ps

module alu_adder_tb;

	reg [31:0] a, b;
	wire [31:0] s;
	wire o;
	
	reg err_flag;

	adder32 u0_adder32(
		.a(a),
		.b(b),
		
		.s(s),
		.overflow(o)
	);
	
	initial begin
		err_flag = 1'b0;
		a = 0;
		b = 0;
		#10;
		if (s != a + b) begin
			$display("error! %x + %x != %x", a, b, s);
			err_flag = 1'b1;
		end
		#10;
	
		a = 'h123;
		b = 'h789;
		#10;
		
		if (s != a + b) begin
			$display("error! %x + %x != %x", a, b, s);
			err_flag = 1'b1;
		end
		#10;
		
		repeat (10) begin
			a = a + 100;
			b = b + 100;
			#10;
			if (s != a + b) begin
				$display("error! %x + %x != %x", a, b, s);
				err_flag = 1'b1;
			end
			#10;
		end
		
//		// it's not practical to run such a big test
//		for (a=0; a<=32'hffffffff; a=a+1) begin
//			for (b=0; b<=32'hffffffff; b=b+1) begin
//				#1;
//				if (s != a + b)
//					err_flag = 1'b1;
//			end
//		end

		a = 'hffff0000;
		b = 'hf996;
		#10;
		repeat (5) begin
			a = a + 'h100;
			b = b + 'h100;
			#10;
			if (s != a + b) begin
				$display("error! %x + %x != %x", a, b, s);
				err_flag = 1'b1;
			end
			#10;
		end
		
		if (!err_flag)
			$display("no error happened");
		
		$stop;
	
	end

endmodule
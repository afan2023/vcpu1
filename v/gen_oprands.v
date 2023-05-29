/*
 * generate oprands
 */

module gen_oprands (
   // input from the instr_dec module
   input re1,
   input re2,
   input [15:0] imm_data,
   input imm_valid,
   input sign,
   
   // from reg file
   input [31:0] op1_rdata,
   input [31:0] op2_rdata,
   
   // oprands
   output [31:0] op1,
   output [31:0] op2
);

   reg [31:0] op1_r, op2_r;
   reg imm_high;
   always@(*) begin
      if (re1)
         op1_r = op1_rdata;
      else if (imm_valid)
         op1_r = sign ? {{16{imm_data[15]}}, imm_data} : {16'h0, imm_data};
      else
         op1_r = 32'h0;
   end

   always@(*) begin
      if (re2)
         op2_r = op2_rdata;
      else if (imm_valid)
         op2_r = sign ? {{16{imm_data[15]}}, imm_data} : {16'h0, imm_data};
      else
         op2_r = 32'h0;
   end

   assign op1 = op1_r;
   assign op2 = op2_r;

endmodule
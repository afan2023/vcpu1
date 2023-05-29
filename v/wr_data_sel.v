`include "instr_syntax.v"

module wr_data_sel(
   input             rst_n,
   input    [31:0]   alu_out,
   input    [31:0]   mem_out,
   input    [31:0]   oprand2, // for mov operations
   input    [31:0]   jra, // jump return address
//   input    [1:0]    op_mod_sel,   // depends on operation, select execution module
   input    [5:0]    opcode, // tbm later, use opcode now
   
   output   [31:0]   wdata
   );
   
   reg   [31:0]   wdata_r;

   always @(*)
   if (!rst_n) begin
      wdata_r = 32'h0;
   end else case (opcode)
      `OPCODE_ADDU,`OPCODE_ADDUI,`OPCODE_ADD,`OPCODE_ADDI,`OPCODE_SUB: begin
         wdata_r = alu_out;
      end
      `OPCODE_LD: begin
         wdata_r = mem_out;
      end
      `OPCODE_MOV, `OPCODE_MOVIL, `OPCODE_MOVIH: begin
         wdata_r = oprand2;
      end
      `OPCODE_AND,`OPCODE_OR,`OPCODE_NOT,`OPCODE_XOR: begin
         wdata_r = alu_out;
      end
      `OPCODE_SL,`OPCODE_SR,`OPCODE_SRA: begin
         wdata_r = alu_out;
      end
      `OPCODE_JL, `OPCODE_JLR: begin
         wdata_r = jra;
      end
      default: begin
         wdata_r = 'h0;
      end
   endcase

   assign wdata = wdata_r;
   
endmodule
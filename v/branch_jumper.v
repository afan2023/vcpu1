`include "instr_syntax.v"

module branch_jumper(
   input rst_n,
   input [5:0] opcode,
   input [2:0] flags,
   input [31:0] pc,
   input [31:0] reg_value,
   input [31:0] imm_offset,
   
   output change_pc,
   output [31:0] new_pc,
   output [31:0] ra_wdata
   );
   
   reg change_pc_r;
   reg [31:0] new_pc_r, ra_wdata_r;
   
   always@(*)
   if (! rst_n) begin
      change_pc_r = 1'b0;
      new_pc_r = 32'h0;
   end else case(opcode)
      `OPCODE_BEQ: begin
         change_pc_r = flags[1]; // zero flag
         new_pc_r = pc + imm_offset;
      end
      `OPCODE_BNE: begin
         change_pc_r = ~flags[1]; // zero flag
         new_pc_r = pc + imm_offset;
      end
      `OPCODE_BGE: begin
         change_pc_r = flags[1] | (~flags[2]); // zero or positive
         new_pc_r = pc + imm_offset;
      end
      `OPCODE_BLT: begin
         change_pc_r = flags[2]; // negative flag
         new_pc_r = pc + imm_offset;
      end
      
      `OPCODE_J: begin
         change_pc_r = 1'b1;
         new_pc_r = pc + imm_offset;
      end
      `OPCODE_JR: begin
         change_pc_r = 1'b1;
         new_pc_r = pc + reg_value;
      end
      `OPCODE_JL: begin
         change_pc_r = 1'b1;
         new_pc_r = pc + imm_offset;
      end
      `OPCODE_JLR: begin
         change_pc_r = 1'b1;
         new_pc_r = reg_value + imm_offset;
      end
      
      
      default: begin
         change_pc_r = 1'b0;
         new_pc_r = 32'h0;
      end
   endcase
   
   always@(*)
   if (! rst_n) begin
      ra_wdata_r = 32'h0;
   end else case(opcode)
      `OPCODE_JL, `OPCODE_JLR:
         ra_wdata_r = pc + 4;
      default:
         ra_wdata_r = 32'h0;
   endcase
   
   assign change_pc = change_pc_r;
   assign new_pc = new_pc_r;
   assign ra_wdata = ra_wdata_r;

endmodule
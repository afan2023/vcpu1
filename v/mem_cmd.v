`include "instr_syntax.v"
/**
 * generate access command to data memory
 */
module mem_cmd(
   input    [5:0]    opcode,     // operation code
   input    [31:0]   in_a,       // input a
   input    [31:0]   in_b,       // input b
      
   output   [31:0]   mem_addr,   // address
   output   [31:0]   mem_wdata,  // data to write
   output            mem_en,
   output            mem_wr
);

   reg   [31:0]   mem_addr_r;    // address
   reg   [31:0]   mem_wdata_r;   // data to write
   reg            mem_en_r;
   reg            mem_wr_r;

   always @(*) begin
      case (opcode) 
         `OPCODE_LD: begin
            mem_addr_r = in_b;
            mem_wdata_r = 32'h0;
            mem_en_r = 1'b1;
            mem_wr_r = 1'b0;
         end
         `OPCODE_ST: begin
            mem_addr_r = in_b;
            mem_wdata_r = in_a;
            mem_en_r = 1'b1;
            mem_wr_r = 1'b1;
         end
         default: begin
            mem_addr_r = 32'h0;
            mem_wdata_r = 32'h0;
            mem_en_r = 1'b0;
            mem_wr_r = 1'b0;
         end
      endcase
   end

   assign mem_addr = mem_addr_r;
   assign mem_wdata = mem_wdata_r;
   assign mem_en = mem_en_r;
   assign mem_wr = mem_wr_r; 

endmodule
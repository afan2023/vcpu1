/**
 * program counter
 */
module pc (
   input clk,
   input rst_n,
   
   input [31:0] new_pc,
   input change_pc,
   input halt,
   
   output [31:0] instr_addr,
   output instr_fetch_en
);

   reg [31:0] pc_r;
   reg en_r;

   always @(posedge clk or negedge rst_n) begin
      if (!rst_n)
         en_r <= 1'b0; // don't fetch
      else
         en_r <= 1'b1;
   end

   always @(posedge clk or negedge rst_n) begin
      if (!rst_n)
         pc_r <= 0; // start from address 'h0;
      else if(!en_r) 
         pc_r <= 0;
      else if(change_pc)
         pc_r <= new_pc;
      else if(!halt)
         pc_r <= pc_r + 32'h4;
   end

   assign instr_addr = pc_r;
   assign instr_fetch_en = en_r;

endmodule

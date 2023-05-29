module instr_rom_t(
   input en,
   input [31:0] addr,
   
   output [31:0] instruction
);
   
// 1k bytes mem
reg [7:0] instr_mem [1023:0];

// simulation, load instruction mem content from file
initial $readmemh ("instr_rom_t.txt", instr_mem);

// output instruction register
reg [31:0] instr_r;

always@(*)
if (en)
   // big endian
   // force alignment by taking only the higher 30 bits of input address
   instr_r = {instr_mem[{addr[31:2],2'h0}],instr_mem[{addr[31:2],2'h1}],instr_mem[{addr[31:2],2'h2}],instr_mem[{addr[31:2],2'h3}]};
else
   instr_r = 32'h0; // NOP
   
assign instruction = instr_r;
   
endmodule

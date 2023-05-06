# vcpu1
This is a simple processor prototype, starting from scratch.
The main purpose is to help better understand the hardware architecture, the microarchitecture and instruction set.
Also it may help me to practice Verilog, I hope.

### How organized?

The `v` folder contains core modules:

- vcore.v : the core module, it make use of the other composition modules.
- pc.v : program counter module.
- reg_file.v : register file module.
- instr_dec.v : instruction decoding module.
- gen_oprands.v : module responsible to generate operands (from raw data/fields from instruction & registers).
- alu.v : the ALU module.
- mem_cmd.v : to work with data memory.
- wr_data_sel.v : the module selects data to write back into register.

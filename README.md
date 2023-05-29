# vcpu1
This is a simple processor prototype, starting from scratch.
The main purpose is to help better understand the hardware architecture. Also it may help me to learn Verilog, I hope.

### `v` folder

The `v` folder contains core modules:

- vcore.v : the core module, it make use of the other composition modules.
- pc.v : program counter module.
- reg_file.v : register file module.
- instr_dec.v : instruction decoding module.
- gen_oprands.v : the module responsible for generating operands (according to raw data/fields from instruction & registers).
- alu.v : the ALU module.
- mem_cmd.v : to work with data memory.
- wr_data_sel.v : the module selects data to write back into register.
- branch_jumper.v : for branch & jump operations.

and the `instr_syntax.v` defines instructions formats.

### `t` folder

The `t` folder contains some trial files for simulation tests. In particular, it contains following files:

- data_mem.v : data memory.
- instr_rom_t.v : instruction memory emulated with instructions as in the file `instr_rom_t.txt` .
- instr_rom_t***.txt : instructions to run.
- vcpu1_tb.v : put together the core and all above memory components, and run the simulation.

Import the Verilog files into EDA project, and try to have fun. There're several instr_rom_t***.txt files, just rename it or change the text file in instr_rom_t.v to run. 

Briefly putting, 3 rounds of tests were run on the core. The first test initializes memory @ address 0x00000008 with data 0x007b0315,  initializes memory @ 0x0000000c with data 0x0315007b, then adds them together, and then stores the sum back to memory @ address 0x00000008. The result is 0x03900390.

![](D:\Workspace\quartus\vcpu1\doc\vcpu1_t1.PNG)

The 2nd (...t2...) simply has some more tests on arithmetic, logical, and shift operations.

The 3rd round, ...t3_bj... is a simple trial of some branch and jump instructions; while ...t3_bjl... simulates kinds of function calls. Briefly putting, the instr_rom_t3_bjl.txt initializes two arrays, takes pairs of the two arrays to add up, thus generate a 3rd array, finally it sums up the 3rd array. The result shall be 0x2d.



### Note

This repo is stopped. A new repo will work on a more practical core.

In reflection, in this repo some instructions were created casually, and this obviously can be improved, in the new work the instruction set will be designed. 

I've started working on that.

This repo is about an one instruction per cycle core (the new core will have a pipeline, that can better serve to study the computer architecture). The following instructions are implemented up to now:
- ADD: addition
- ADDI: addition with immediate number
- SUB: subtraction
- ADDU: unsigned addition
- ADDUI: addition operation, unsigned, with immediate number
- LD: load data (from memory to register)
- ST: store (from register to data memory)
- MOV: move (from register to register)
- MOVIH/MOVIL: move immediate to register (high / low half word)
- AND: logical operation and
- OR: logical operation or
- NOT: logical operation not
- XOR: logical operation exclusive or
- SL: shift left
- SR: shift right (zero moved in)
- SRA: shift right (sign bit moved)
- Branch (conditional): BEQ (branch if equal), BNE(branch if not equal), BGE(branch if greater than or equal), BLT(branch if less than)
- Jump (unconditional): J (jump to offset = immediate number), JR(offset designated by register), JL(jump to offset = immediate, and record the original instruction address), JLR (jump to an address designated by register, and record the original address.


# vcpu1
This is a simple processor prototype, starting from scratch.
The main purpose is to help better understand the hardware architecture, the microarchitecture and instruction set.
Also it may help me to practice Verilog, I hope.

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

and the `instr_syntax.v` defines instructions formats.

### `t` folder

The `t` folder contains some trial files for simulation tests. In particular, it contains a simulation of the CPU that do an addition, this test includes following files:

- data_mem.v : data memory.
- instr_rom_t.v : instruction memory emulated with instructions as in the file `instr_rom_t.txt` .
- instr_rom_t.txt : instructions to run.
- vcpu1_tb.v : put together the core and all above memory components, and run the simulation.

Briefly putting, the test first initializes memory @ address 0x00000008 with data 0x007b0315,  initializes memory @ 0x0000000c with data 0x0315007b, then adds them together, and then stores the sum back to memory @ address 0x00000008. The result is 0x03900390.

![](D:\Workspace\quartus\vcpu1\doc\vcpu1_t1.PNG)



The `t` folder contains yet some other files, those are some module tests just named after the module with a `_tb` suffix. 



Import the Verilog files into EDA project, and try to have fun.



### up to date

a microarchitecture supporting one instruction per cycle, and following instructions implemented:
- ADDU: unsigned addition
- ADDUI: addition operation, unsigned, with immediate number
- LD: load data (from memory to register)
- ST: store (from register to data memory)
- MOV: move (from register to register)
- MOVIH/MOVIL: move immediate to register (high / low half word)



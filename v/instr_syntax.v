///**
// * instruction syntax
// */
 
// operation code field is the bits 31:26 in the instruction
`define	FIELD_OPCODE	31:26
 
// NOP
`define	OPCODE_NOP		6'b000000

// HALT
`define	OPCODE_HALT		6'b000011

// Load register
`define OPCODE_LD 6'b000100 
`define FIELD_RI_D_LD 25:22
`define FIELD_RI_A_LD 21:18

// Store
`define OPCODE_ST 6'b000101 // store register data to memory at address
`define FIELD_RI_A_ST 25:22 // index to the register that have the data
`define FIELD_RI_S_ST 21:18 // index to the register that have the address

// Move
`define OPCODE_MOV 6'b001000 // move from source register to destination register
`define FIELD_RI_D_MOV 25:22
`define FIELD_RI_S_MOV 21:18

`define OPCODE_MOVIL 6'b001001 // move immediate number to low half of register
`define FIELD_RI_D_MOVIL 25:22
`define FIELD_IMM_MOVIL 15:0

`define OPCODE_MOVIH	6'b001010 // move immediate number to high half of register
`define FIELD_RI_D_MOVIH 25:22
`define FIELD_IMM_MOVIH 15:0

// Addition 
`define OPCODE_ADDU 6'b001100	// unsigned, two registers
`define FIELD_RI_1_ADDU 21:18	// index of the register that holds the value of 1st operand
`define FIELD_RI_2_ADDU 17:14	// index of second operand register
`define FIELD_RI_D_ADDU 25:22	// index of the register that will hold the addition result

`define OPCODE_ADDUI 6'b001101	// unsigned addition, a register and an immediate number
`define FIELD_RI_1_ADDUI 21:18	
`define FIELD_IMM_2_ADDUI 15:0
`define FIELD_RI_D_ADDUI 25:22
// other arithmetic operations to be added

// Logical operations
`define OPCODE_AND 6'b010000
`define FIELD_RI_1_AND 21:18
`define FIELD_RI_2_AND 17:14
`define FIELD_RI_D_AND 25:22

`define OPCODE_OR 6'b010010
`define FIELD_RI_1_OR 21:18
`define FIELD_RI_2_OR 17:14
`define FIELD_RI_D_OR 25:22

`define OPCODE_NOT 6'b010100
`define FIELD_RI_1_NOT 21:18
`define FIELD_RI_D_NOT 25:22

`define OPCODE_XOR 6'b010110
`define FIELD_RI_1_XOR 21:18
`define FIELD_RI_2_XOR 17:14
`define FIELD_RI_D_XOR 25:22
 
 // Shifts
`define OPCODE_SL 6'b011000
`define FIELD_RI_1_SL 21:18
`define FIELD_RI_2_SL 17:14
`define FIELD_RI_D_SL 25:22

`define OPCODE_SR 6'b011010
`define FIELD_RI_1_SR 21:18
`define FIELD_RI_2_SR 17:14
`define FIELD_RI_D_SR 25:22

`define OPCODE_SRA 6'b011100
`define FIELD_RI_1_SRA 21:18
`define FIELD_RI_2_SRA 17:14
`define FIELD_RI_D_SRA 25:22


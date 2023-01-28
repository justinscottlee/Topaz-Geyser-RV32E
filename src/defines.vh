// ALU OPERATIONS
// ALU_OP[3] is funct7[5]. ALU_OP[2:0] is funct3.
`define ALU_ADD 4'b0000
`define ALU_SUB 4'b1000
`define ALU_SLL 4'b0001
`define ALU_LT  4'b0010
`define ALU_LTU 4'b0011
`define ALU_XOR 4'b0100
`define ALU_SRL 4'b0101
`define ALU_SRA 4'b1101
`define ALU_OR  4'b0110
`define ALU_AND 4'b0111

// BRANCH CONDITIONS
`define BRANCH_ALU_ZERO     2'b00
`define BRANCH_ALU_NONZERO  2'b01
`define BRANCH_FORCE_FALSE  2'b10
`define BRANCH_FORCE_TRUE   2'b11

// IMMEDIATE SELECT
`define IMM_SEL_I 3'b000
`define IMM_SEL_S 3'b001
`define IMM_SEL_B 3'b010
`define IMM_SEL_U 3'b011
`define IMM_SEL_J 3'b100
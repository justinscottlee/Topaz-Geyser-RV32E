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

`define ALU_A_SEL_RS1   1'b0
`define ALU_A_SEL_PC    1'b1
`define ALU_B_SEL_IMM   1'b0
`define ALU_B_SEL_RS2   1'b1

`define RD_DATA_SEL_ALU 2'b00
`define RD_DATA_SEL_PC4 2'b01
`define RD_DATA_SEL_LSU 2'b10
`define RD_DATA_SEL_IMM 2'b11

// BRANCH CONDITIONS
`define BRANCH_ALU_ZERO     2'b00
`define BRANCH_ALU_NONZERO  2'b01
`define BRANCH_FORCE_FALSE  2'b10
`define BRANCH_FORCE_TRUE   2'b11

`define BRANCH_BASE_PC0     1'b0
`define BRANCH_BASE_RS1     1'b1

// RISC-V OPCODES/FUNCT3s/FUNCT7s
`define OPCODE_LUI          7'b0110111
`define OPCODE_AUIPC        7'b0010111
`define OPCODE_JAL          7'b1101111
`define OPCODE_JALR         7'b1100111
`define OPCODE_BRANCH       7'b1100011
    `define FUNCT3_BEQ          3'b000
    `define FUNCT3_BNE          3'b001
    `define FUNCT3_BLT          3'b100
    `define FUNCT3_BGE          3'b101
    `define FUNCT3_BLTU         3'b110
    `define FUNCT3_BGEU         3'b111
`define OPCODE_LOAD         7'b0000011
    `define FUNCT3_LB           3'b000
    `define FUNCT3_LH           3'b001
    `define FUNCT3_LW           3'b010
    `define FUNCT3_LBU          3'b100
    `define FUNCT3_LHU          3'b101
`define OPCODE_STORE        7'b0100011
    `define FUNCT3_SB           3'b000
    `define FUNCT3_SH           3'b001
    `define FUNCT3_SW           3'b010
`define OPCODE_OP_IMM       7'b0010011
    `define FUNCT3_ADDI         3'b000
    `define FUNCT3_SLTI         3'b010
    `define FUNCT3_SLTIU        3'b011
    `define FUNCT3_XORI         3'b100
    `define FUNCT3_ORI          3'b110
    `define FUNCT3_ANDI         3'b111
    `define FUNCT3_SLLI         3'b001
    `define FUNCT3_SRLI_SRAI    3'b101
        `define FUNCT7_SRLI         7'b0000000
        `define FUNCT7_SRAI         7'b0100000
`define OPCODE_OP           7'b0110011
    `define FUNCT3_ADD_SUB      3'b000
        `define FUNCT7_ADD          7'b0000000
        `define FUNCT7_SUB          7'b0100000
    `define FUNCT3_SLL          3'b001
    `define FUNCT3_SLT          3'b010
    `define FUNCT3_SLTU         3'b011
    `define FUNCT3_XOR          3'b100
    `define FUNCT3_SRL_SRA      3'b101
        `define FUNCT7_SRL          7'b0000000
        `define FUNCT7_SRA          7'b0100000
    `define FUNCT3_OR           3'b110
    `define FUNCT3_AND          3'b111
`define OPCODE_FENCE        7'b0001111
`define OPCODE_ECALL        7'b1110011

`define DATAWIDTH_BYTE  2'b00
`define DATAWIDTH_SHORT 2'b01
`define DATAWIDTH_WORD  2'b10
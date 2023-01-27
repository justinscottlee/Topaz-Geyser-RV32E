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
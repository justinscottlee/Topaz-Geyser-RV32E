`timescale 1ns / 1ps

`include "defines.vh"

module decoder(
    input integer instruction,
    input logic [2:0] imm_sel,
    output logic [6:0] funct7,
    output logic [4:0] rs2, rs1, rd,
    output logic [2:0] funct3,
    output logic [6:0] opcode,
    output integer immediate
    );
    
    integer imm_I, imm_S, imm_B, imm_U, imm_J;
    
    assign imm_I = {{20{instruction[31]}}, instruction[31:20]};
    assign imm_S = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
    assign imm_B = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};
    assign imm_U = {instruction[31:12], 12'b0};
    assign imm_J = {{12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0};
    
    assign funct7 = instruction[31:25];
    assign funct3 = instruction[14:12];
    assign opcode = instruction[6:0];
    
    assign rs2 = instruction[24:20];
    assign rs1 = instruction[19:15];
    assign rd = instruction[11:7];
    
    always_comb begin
        case (imm_sel)
        `IMM_SEL_I: immediate = imm_I;
        `IMM_SEL_S: immediate = imm_S;
        `IMM_SEL_B: immediate = imm_B;
        `IMM_SEL_U: immediate = imm_U;
        `IMM_SEL_J: immediate = imm_J;
        endcase
    end
endmodule
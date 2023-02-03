`timescale 1ns / 1ps

`include "defines.vh"

module control_unit(
    input logic [6:0] funct7,
    input logic [2:0] funct3,
    input logic [6:0] opcode,
    
    output logic [2:0] imm_sel,
    output logic [3:0] alu_operation,
    output logic regfile_we, alu_a_sel, alu_b_sel
    );
    
    always_comb begin
    case (opcode)
    `OPCODE_LUI: begin
        
    end
    `OPCODE_AUIPC: begin
        
    end
    `OPCODE_JAL: begin
        
    end
    `OPCODE_JALR: begin
        
    end
    `OPCODE_BRANCH: begin
        case (funct3)
        `FUNCT3_BEQ: begin
            
        end
        `FUNCT3_BNE: begin
            
        end
        `FUNCT3_BLT: begin
            
        end
        `FUNCT3_BGE: begin
            
        end
        `FUNCT3_BLTU: begin
            
        end
        `FUNCT3_BGEU: begin
            
        end
        endcase
    end
    `OPCODE_LOAD: begin
        case (funct3)
        `FUNCT3_LB: begin
            
        end
        `FUNCT3_LH: begin
            
        end
        `FUNCT3_LW: begin
            
        end
        `FUNCT3_LBU: begin
            
        end
        `FUNCT3_LHU: begin
            
        end
        endcase
    end
    `OPCODE_STORE: begin
        case (funct3)
        `FUNCT3_SB: begin
            
        end
        `FUNCT3_SH: begin
            
        end
        `FUNCT3_SW: begin
            
        end
        endcase
    end
    `OPCODE_OP_IMM: begin
        imm_sel = `IMM_SEL_I;
        alu_operation = {funct7[5], funct3};
        alu_a_sel = `ALU_A_SEL_RS1;
        alu_b_sel = `ALU_B_SEL_IMM;
        regfile_we = 1'b1;
        case (funct3)
        `FUNCT3_ADDI: begin
            
        end
        `FUNCT3_SLTI: begin
            
        end
        `FUNCT3_SLTIU: begin
            
        end
        `FUNCT3_XORI: begin
            
        end
        `FUNCT3_ORI: begin
            
        end
        `FUNCT3_ANDI: begin
            
        end
        `FUNCT3_SLLI: begin
            
        end
        `FUNCT3_SRLI, `FUNCT3_SRAI: begin
            case (funct7)
            `FUNCT7_SRLI: begin
                
            end
            `FUNCT7_SRAI: begin
                
            end
            endcase
        end
        endcase
    end
    `OPCODE_OP: begin
        alu_operation = {funct7[5], funct3};
        alu_a_sel = `ALU_A_SEL_RS1;
        alu_b_sel = `ALU_B_SEL_RS2;
        regfile_we = 1'b1;
        case (funct3)
        `FUNCT3_ADD, `FUNCT3_SUB: begin
            case (funct7)
            `FUNCT7_ADD: begin
                
            end
            `FUNCT7_SUB: begin
                
            end
            endcase
        end
        `FUNCT3_SLL: begin
            
        end
        `FUNCT3_SLT: begin
            
        end
        `FUNCT3_SLTU: begin
            
        end
        `FUNCT3_XOR: begin
            
        end
        `FUNCT3_SRL, `FUNCT3_SRA: begin
            case (funct7)
            `FUNCT7_SRL: begin
                
            end
            `FUNCT7_SRA: begin
                
            end
            endcase
        end
        `FUNCT3_OR: begin
            
        end
        `FUNCT3_AND: begin
            
        end
        endcase
    end
    `OPCODE_FENCE: begin
        
        // unimplemented
    end
    `OPCODE_ECALL: begin
        
        // unimplemented
    end
    endcase
    end
endmodule
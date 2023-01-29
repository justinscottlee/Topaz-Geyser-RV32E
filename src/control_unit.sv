`timescale 1ns / 1ps

module control_unit(
    input logic [6:0] funct7,
    input logic [2:0] funct3,
    input logic [6:0] opcode,
    output logic valid_instruction
    );
    
    always_comb begin
    valid_instruction = 1'b0; // default valid_instruction to invalid state
    case (opcode)
    `OPCODE_LUI: begin
        valid_instruction = 1'b1;
    end
    `OPCODE_AUIPC: begin
        valid_instruction = 1'b1;
    end
    `OPCODE_JAL: begin
        valid_instruction = 1'b1;
    end
    `OPCODE_JALR: begin
        valid_instruction = 1'b1;
    end
    `OPCODE_BRANCH: begin
        case (funct3)
        `FUNCT3_BEQ: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_BNE: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_BLT: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_BGE: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_BLTU: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_BGEU: begin
            valid_instruction = 1'b1;
        end
        endcase
    end
    `OPCODE_LOAD: begin
        case (funct3)
        `FUNCT3_LB: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_LH: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_LW: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_LBU: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_LHU: begin
            valid_instruction = 1'b1;
        end
        endcase
    end
    `OPCODE_STORE: begin
        case (funct3)
        `FUNCT3_SB: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_SH: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_SW: begin
            valid_instruction = 1'b1;
        end
        endcase
    end
    `OPCODE_OP_IMM: begin
        case (funct3)
        `FUNCT3_ADDI: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_SLTI: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_SLTIU: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_XORI: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_ORI: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_ANDI: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_SLLI: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_SRLI, `FUNCT3_SRAI: begin
            case (funct7)
            `FUNCT7_SRLI: begin
                valid_instruction = 1'b1;
            end
            `FUNCT7_SRAI: begin
                valid_instruction = 1'b1;
            end
            endcase
        end
        endcase
    end
    `OPCODE_OP: begin
        case (funct3)
        `FUNCT3_ADD, `FUNCT3_SUB: begin
            case (funct7)
            `FUNCT7_ADD: begin
                valid_instruction = 1'b1;
            end
            `FUNCT7_SUB: begin
                valid_instruction = 1'b1;
            end
            endcase
        end
        `FUNCT3_SLL: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_SLT: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_SLTU: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_XOR: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_SRL, `FUNCT3_SRA: begin
            case (funct7)
            `FUNCT7_SRL: begin
                valid_instruction = 1'b1;
            end
            `FUNCT7_SRA: begin
                valid_instruction = 1'b1;
            end
            endcase
        end
        `FUNCT3_OR: begin
            valid_instruction = 1'b1;
        end
        `FUNCT3_AND: begin
            valid_instruction = 1'b1;
        end
        endcase
    end
    `OPCODE_FENCE: begin
        valid_instruction = 1'b1;
        // unimplemented
    end
    `OPCODE_ECALL: begin
        valid_instruction = 1'b1;
        // unimplemented
    end
    endcase
    end
endmodule
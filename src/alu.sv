`timescale 1ns / 1ps

`include "defines.vh"

module alu(
    input logic [3:0] operation,
    input logic [31:0] a, b,
    output logic [31:0] result
    );
    
    always_comb begin
        case (operation)
        `ALU_ADD:   result = a + b;
        `ALU_SUB:   result = a - b;
        `ALU_SLL:   result = a << b[4:0];
        `ALU_LT:    result = $signed(a) < $signed(b);
        `ALU_LTU:   result = a < b;
        `ALU_XOR:   result = a ^ b;
        `ALU_SRL:   result = a >> b[4:0];
        `ALU_SRA:   result = $signed(a) >>> b[4:0];
        `ALU_OR:    result = a | b;
        `ALU_AND:   result = a & b;
        default:    result = 32'b0;
        endcase
    end
endmodule
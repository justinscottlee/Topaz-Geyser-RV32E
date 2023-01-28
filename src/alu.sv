`timescale 1ns / 1ps

`include "defines.vh"

module alu(
    input logic [3:0] operation,
    input integer a, b,
    output integer result
    );
    
    always_comb begin
        case (operation)
        `ALU_ADD:   result = a + b;
        `ALU_SUB:   result = a - b;
        `ALU_SLL:   result = a << b[4:0];
        `ALU_LT:    result = a < b;
        `ALU_LTU:   result = $unsigned(a) < $unsigned(b);
        `ALU_XOR:   result = a ^ b;
        `ALU_SRL:   result = a >> b[4:0];
        `ALU_SRA:   result = a >>> b[4:0];
        `ALU_OR:    result = a | b;
        `ALU_AND:   result = a & b;
        default:    result = 32'd0;
        endcase
    end
endmodule
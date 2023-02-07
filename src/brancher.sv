`timescale 1ns / 1ps

`include "defines.vh"

module brancher(
    input logic clk, invalid,
    input logic [1:0] branch_condition,
    input integer alu_result,
    output logic branch_taken,
    
    input integer branch_base, immediate,
    output integer branch_addr
    );
    
    always_ff @ (posedge clk) begin
        if (!invalid) begin
            branch_addr <= branch_base + immediate;
            case (branch_condition)
            `BRANCH_ALU_ZERO:       branch_taken <= alu_result == 0;
            `BRANCH_ALU_NONZERO:    branch_taken <= alu_result != 0;
            `BRANCH_FORCE_FALSE:    branch_taken <= 1'b0;
            `BRANCH_FORCE_TRUE:     branch_taken <= 1'b1;
            endcase
        end
        else branch_taken <= 1'b0;
    end
endmodule
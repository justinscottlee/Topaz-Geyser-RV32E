`timescale 1ns / 1ps

`include "defines.vh"

module brancher(
    input logic clk,
    input logic [1:0] branch_condition,
    input integer alu_result,
    output logic branch_taken,
    
    input integer pc, immediate,
    output integer branch_addr
    );
    
    assign branch_addr = pc + immediate;
    
    always_ff @ (posedge clk) begin
        case (branch_condition)
        `BRANCH_ALU_ZERO:       branch_taken <= alu_result == 0;
        `BRANCH_ALU_NONZERO:    branch_taken <= alu_result != 0;
        `BRANCH_FORCE_FALSE:    branch_taken <= 1'b0;
        `BRANCH_FORCE_TRUE:     branch_taken <= 1'b1;
        endcase
    end
    
    always_ff @ (posedge clk) begin
        branch_addr <= pc + immediate;
    end
endmodule
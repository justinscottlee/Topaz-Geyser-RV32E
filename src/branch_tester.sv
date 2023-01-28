`timescale 1ns / 1ps

`include "defines.vh"

module branch_tester(
    input logic [1:0] branch_condition,
    input integer alu_result,
    output logic branch_taken
    );

    always_comb begin
        case (branch_condition)
        `BRANCH_ALU_ZERO:       branch_taken = alu_result == 0;
        `BRANCH_ALU_NONZERO:    branch_taken = alu_result != 0;
        `BRANCH_FORCE_FALSE:    branch_taken = 1'b0;
        `BRANCH_FORCE_TRUE:     branch_taken = 1'b1;
        endcase
    end
endmodule
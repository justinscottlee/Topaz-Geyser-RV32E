`timescale 1ns / 1ps

`include "defines.vh"

module tb_alu;

reg [3:0] operation;
integer a, b;
integer result;

alu dut(operation, a, b, result);

initial begin
    operation = `ALU_ADD;
    a = 100;
    b = 100;
    #1;
    b = -100;
    #1;
    a = -100;
    #1;
    b = 100;
    #1;
    
    operation = `ALU_SUB;
    a = 100;
    b = 100;
    #1;
    b = -100;
    #1;
    a = -100;
    #1;
    b = 100;
    #1;
    
    operation = `ALU_SLL;
    a = 100;
    b = 4;
    #1;
    b = 16;
    #1;
    b = 31;
    #1;
    
    operation = `ALU_LT;
    a = 100;
    b = 110;
    #1;
    b = 100;
    #1;
    b = 90;
    #1;
    b = -100;
    #1;
    a = -100;
    b = 100;
    #1;
    b = -90;
    #1;
    b = -110;
    #1;
    
    operation = `ALU_LTU;
    a = 100;
    b = 110;
    #1;
    b = 100;
    #1;
    b = 90;
    #1;
    a = -1;
    b = -100;
    #1;
    b = 0;
    #1;
    a = -100;
    b = -1;
    #1;
    
    operation = `ALU_XOR;
    a = 3;
    b = 7;
    #1;
    a = -1;
    b = -1;
    #1;
    
    operation = `ALU_SRL;
    a = 100;
    b = 1;
    #1;
    a = -1;
    b = 15;
    #1;
    b = 31;
    #1;
    
    operation = `ALU_SRA;
    a = 100;
    b = 1;
    #1;
    a = -100;
    b = 1;
    #1;
    
    operation = `ALU_OR;
    a = 64;
    b = 7;
    #1;
    
    operation = `ALU_AND;
    a = 7;
    b = 15;
    #1;
    $finish;
end

endmodule

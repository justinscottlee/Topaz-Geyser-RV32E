`timescale 1ns / 1ps

module spi_controller(
    input logic clk, rst,
    input logic miso,
    output logic mosi,
    output logic slave_clk,
    output logic slave_select,
    input logic [63:0] command,
    output logic [63:0] response,
    inout logic [7:0] csr // [NA, NA, NA, RDY, CL2, CL1, CL0, BSY]
    // RDY = COMMAND READY TO EXECUTE.
    // CL2, CL1, CL0 = COMMAND_LENGTH. CL + 1 = NUM BYTES
    // BSY = BUSY. ACTIVE-HIGH WHILE EXECUTING.
    );
    
    always_ff @ (negedge clk or posedge clk) slave_clk = (state == IDLE) ? 1'b0 : ~slave_clk;
    
    logic [2:0] command_length;
    assign command_length = csr[3:1];
    
    logic [6:0] command_index;
    assign mosi = command[command_index];
    
    always_ff @ (posedge slave_clk) begin
        response[command_index] <= miso;
    end
    
    localparam IDLE = 1'b1, BUSY = 1'b0;
    logic state = IDLE;
    assign csr[0] = state;
    assign slave_select = state;
    
    always_ff @ (posedge clk) begin
        if (csr[4] & state == IDLE) begin
            command_index <= 63;
            state <= BUSY;
        end
        else if (command_index == (56 - 8 * command_length)) begin
            state <= IDLE;
        end
        else begin
            command_index <= command_index - 1;
        end
    end
endmodule
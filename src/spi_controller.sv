`timescale 1ns / 1ps

module spi_controller(
    input logic clk, rst,
    
    output logic slave_clk,
    input logic miso,
    output logic mosi,
    
    input logic start,
    input byte command,
    output byte response,
    inout logic [7:0] csr // [NC, NC, NC, NC, NC, CPOL, CPHA, BSY]
    );
    
    always_ff @ (negedge clk or posedge clk) slave_clk = (state == IDLE) ? 1'b0 : ~slave_clk;
    
    bit [2:0] command_index;
    assign mosi = command[command_index];
    
    localparam IDLE = 1'b0, BUSY = 1'b1;
    bit state;
    assign csr[0] = state;
    
    always_ff @ (posedge slave_clk) begin
        response[command_index] <= miso;
    end
    
    always_ff @ (posedge clk) begin
        case (state)
        IDLE: begin
            if (start) begin
                command_index <= 3'd7;
                state <= BUSY;
            end
        end
        BUSY: begin
            if (command_index == 0) begin
                state <= IDLE;
            end
            else begin
                command_index <= command_index - 1;
            end
        end
        endcase
    end
endmodule
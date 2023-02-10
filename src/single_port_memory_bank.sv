`timescale 1ns / 1ps

module single_port_memory_bank #(
    parameter DATA_DEPTH = 4096
    )(
    input logic clk, we,
    input logic [$clog2(DATA_DEPTH)-1:0] addr,
    input byte write_data,
    output byte read_data
    );
    
    byte mem [0:DATA_DEPTH-1];

    always_ff @ (posedge clk) begin
        if (we) begin
            mem[addr] <= write_data;
        end
        read_data <= mem[addr];
    end
endmodule
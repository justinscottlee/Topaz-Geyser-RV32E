`timescale 1ns / 1ps

module dual_port_memory_bank #(
    parameter DATA_DEPTH = 4096
    )(
    input logic clk, we,
    input logic [$clog2(DATA_DEPTH)-1:0] addr_a, addr_b,
    input byte write_data,
    output byte read_data
    );
    
    byte mem [0:DATA_DEPTH-1];

    assign read_data = mem[addr_b];

    always_ff @ (posedge clk) begin
        if (we) begin
            mem[addr_a] <= write_data;
        end
    end
endmodule
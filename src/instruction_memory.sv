`timescale 1ns / 1ps

module instruction_memory #(
    parameter DEPTH = 4096
    )(
        input logic clk, we,
        input logic [$clog2(DEPTH)-1:0] addr_ro, addr_rw,
        input integer write_instruction_rw,
        output integer read_instruction_ro, read_instruction_rw
    );
    
    integer mem[0:DEPTH-1];
    
    initial $readmemh("instruction_memory.mem", mem);
    
    always_ff @ (posedge clk) begin
        read_instruction_ro <= mem[addr_ro];
    end
    
    always_ff @ (posedge clk) begin
        if (we) begin
            mem[addr_rw] <= write_instruction_rw;
        end
        else begin
            read_instruction_rw <= mem[addr_rw];
        end
    end
endmodule

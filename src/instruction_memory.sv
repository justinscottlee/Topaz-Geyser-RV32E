`timescale 1ns / 1ps

module instruction_memory #(
    parameter DEPTH = 4096
    )(
        input logic clk, we, stall,
        input logic [$clog2(DEPTH)-1:0] addr_ro, addr_rw,
        input integer write_instruction_rw,
        output integer read_instruction_ro, read_instruction_rw
    );
    
    integer mem[0:DEPTH-1];
    
    // initialize memory for testing in simulation
    initial $readmemh("instruction_memory.mem", mem);
    
    always_ff @ (posedge clk) begin
        if (!stall) begin
            read_instruction_ro <= mem[addr_ro >> 2];
        end
    end
    
    always_ff @ (posedge clk) begin
        if (we) begin
            mem[addr_rw >> 2] <= write_instruction_rw;
        end
        else begin
            read_instruction_rw <= mem[addr_rw >> 2];
        end
    end
endmodule
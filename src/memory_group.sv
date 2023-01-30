`timescale 1ns / 1ps

module memory_group #(
    parameter DATA_DEPTH = 4096
    )(
    input logic clk,
    input logic [3:0] write_mask,
    input logic [2+$clog2(DATA_DEPTH)-1:0] addr,
    input integer write_data,
    output integer read_data
    );
    
    logic [1:0] bank_base;
    logic [$clog2(DATA_DEPTH)-1:0] bank_addr;
    
    assign bank_base = addr % 4; // RISC-V allows misaligned address accesses, so this calculates the memory bank the data starts at.
    assign bank_addr = addr >> 2; // RISC-V instruction address is byte-addressed, whereas the physical memory is word-addressed, so we divide by 4 bytes/word.
    
    // We need to keep the software interpretation of the write-mask aligned with the hardware banks.
    logic bank0_we, bank1_we, bank2_we, bank3_we;
    assign bank0_we = write_mask[(0 - bank_base) % 4];
    assign bank1_we = write_mask[(1 - bank_base) % 4];
    assign bank2_we = write_mask[(2 - bank_base) % 4];
    assign bank3_we = write_mask[(3 - bank_base) % 4];
    
    // When the word eventually loops back on itself to bank0, we need to read the next address of those banks.
    logic [$clog2(DATA_DEPTH)-1:0] bank0_addr, bank1_addr, bank2_addr, bank3_addr;
    assign bank0_addr = bank_addr + ((bank_base > 0) ? 1 : 0);
    assign bank1_addr = bank_addr + ((bank_base > 1) ? 1 : 0);
    assign bank2_addr = bank_addr + ((bank_base > 2) ? 1 : 0);
    assign bank3_addr = bank_addr;
    
    byte bank0_write_data, bank1_write_data, bank2_write_data, bank3_write_data;
    byte bank0_read_data, bank1_read_data, bank2_read_data, bank3_read_data;
    
    memory_bank #(.DATA_DEPTH(DATA_DEPTH)) bank0 (.clk(clk), .we(bank0_we), .addr(bank0_addr), .write_data(bank0_write_data), .read_data(bank0_read_data));
    memory_bank #(.DATA_DEPTH(DATA_DEPTH)) bank1 (.clk(clk), .we(bank1_we), .addr(bank1_addr), .write_data(bank1_write_data), .read_data(bank1_read_data));
    memory_bank #(.DATA_DEPTH(DATA_DEPTH)) bank2 (.clk(clk), .we(bank2_we), .addr(bank2_addr), .write_data(bank2_write_data), .read_data(bank2_read_data));
    memory_bank #(.DATA_DEPTH(DATA_DEPTH)) bank3 (.clk(clk), .we(bank3_we), .addr(bank3_addr), .write_data(bank3_write_data), .read_data(bank3_read_data));
    
    always_comb begin
        case (bank_base)
        2'd0: begin
            bank0_write_data = write_data[7:0];
            bank1_write_data = write_data[15:8];
            bank2_write_data = write_data[23:16];
            bank3_write_data = write_data[31:24];
            read_data = {bank3_read_data, bank2_read_data, bank1_read_data, bank0_read_data};
        end
        2'd1: begin
            bank1_write_data = write_data[7:0];
            bank2_write_data = write_data[15:8];
            bank3_write_data = write_data[23:16];
            bank0_write_data = write_data[31:24];
            read_data = {bank0_read_data, bank3_read_data, bank2_read_data, bank1_read_data};
        end
        2'd2: begin
            bank2_write_data = write_data[7:0];
            bank3_write_data = write_data[15:8];
            bank0_write_data = write_data[23:16];
            bank1_write_data = write_data[31:24];
            read_data = {bank1_read_data, bank0_read_data, bank3_read_data, bank2_read_data};
        end
        2'd3: begin
            bank3_write_data = write_data[7:0];
            bank0_write_data = write_data[15:8];
            bank1_write_data = write_data[23:16];
            bank2_write_data = write_data[31:24];
            read_data = {bank2_read_data, bank1_read_data, bank0_read_data, bank3_read_data};
        end
        endcase
    end
endmodule

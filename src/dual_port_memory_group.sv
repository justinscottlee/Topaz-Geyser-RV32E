`timescale 1ns / 1ps

module dual_port_memory_group #(
    parameter DATA_DEPTH = 4096
    )(
    input logic clk,
    input logic [3:0] write_mask,
    input logic [2+$clog2(DATA_DEPTH)-1:0] addr_a, addr_b,
    input integer write_data,
    output integer read_data
    );

    logic [1:0] bank_base_a, bank_base_b;
    logic [$clog2(DATA_DEPTH)-1:0] bank_addr_a, bank_addr_b;
    
    // RISC-V allows misaligned address accesses, so this calculates the memory bank the data starts at.
    assign bank_base_a = addr_a % 4;
    assign bank_base_b = addr_b % 4;
    
    // RISC-V instruction address is byte-addressed, whereas the physical memory is word-addressed, so we divide by 4 bytes/word.
    assign bank_addr_a = addr_a >> 2;
    assign bank_addr_b = addr_b >> 2;
    
    // We need to keep the software interpretation of the write-mask aligned with the hardware banks.
    logic bank0_we, bank1_we, bank2_we, bank3_we;
    assign bank0_we = write_mask[(0 - bank_base_a) % 4];
    assign bank1_we = write_mask[(1 - bank_base_a) % 4];
    assign bank2_we = write_mask[(2 - bank_base_a) % 4];
    assign bank3_we = write_mask[(3 - bank_base_a) % 4];
    
    // When the word eventually loops back on itself to bank0, we need to read the next address of those banks.
    logic [$clog2(DATA_DEPTH)-1:0] bank0_addr_a, bank1_addr_a, bank2_addr_a, bank3_addr_a;
    assign bank0_addr_a = bank_addr_a + ((bank_base_a > 0) ? 1 : 0);
    assign bank1_addr_a = bank_addr_a + ((bank_base_a > 1) ? 1 : 0);
    assign bank2_addr_a = bank_addr_a + ((bank_base_a > 2) ? 1 : 0);
    assign bank3_addr_a = bank_addr_a;
    
    logic [$clog2(DATA_DEPTH)-1:0] bank0_addr_b, bank1_addr_b, bank2_addr_b, bank3_addr_b;
    assign bank0_addr_b = bank_addr_b + ((bank_base_b > 0) ? 1 : 0);
    assign bank1_addr_b = bank_addr_b + ((bank_base_b > 1) ? 1 : 0);
    assign bank2_addr_b = bank_addr_b + ((bank_base_b > 2) ? 1 : 0);
    assign bank3_addr_b = bank_addr_b;
    
    byte bank0_write_data, bank1_write_data, bank2_write_data, bank3_write_data;
    byte bank0_read_data, bank1_read_data, bank2_read_data, bank3_read_data;
    
    dual_port_memory_bank #(.DATA_DEPTH(DATA_DEPTH)) bank0 (.clk(clk), .we(bank0_we), .addr_a(bank0_addr_a), .addr_b(bank0_addr_b), .write_data(bank0_write_data), .read_data(bank0_read_data));
    dual_port_memory_bank #(.DATA_DEPTH(DATA_DEPTH)) bank1 (.clk(clk), .we(bank1_we), .addr_a(bank1_addr_a), .addr_b(bank1_addr_b), .write_data(bank1_write_data), .read_data(bank1_read_data));
    dual_port_memory_bank #(.DATA_DEPTH(DATA_DEPTH)) bank2 (.clk(clk), .we(bank2_we), .addr_a(bank2_addr_a), .addr_b(bank2_addr_b), .write_data(bank2_write_data), .read_data(bank2_read_data));
    dual_port_memory_bank #(.DATA_DEPTH(DATA_DEPTH)) bank3 (.clk(clk), .we(bank3_we), .addr_a(bank3_addr_a), .addr_b(bank3_addr_b), .write_data(bank3_write_data), .read_data(bank3_read_data));
    
    always_comb begin
        case (bank_base_a)
        2'd0: begin
            bank0_write_data = write_data[7:0];
            bank1_write_data = write_data[15:8];
            bank2_write_data = write_data[23:16];
            bank3_write_data = write_data[31:24];
        end
        2'd1: begin
            bank1_write_data = write_data[7:0];
            bank2_write_data = write_data[15:8];
            bank3_write_data = write_data[23:16];
            bank0_write_data = write_data[31:24];
        end
        2'd2: begin
            bank2_write_data = write_data[7:0];
            bank3_write_data = write_data[15:8];
            bank0_write_data = write_data[23:16];
            bank1_write_data = write_data[31:24];
        end
        2'd3: begin
            bank3_write_data = write_data[7:0];
            bank0_write_data = write_data[15:8];
            bank1_write_data = write_data[23:16];
            bank2_write_data = write_data[31:24];
        end
        endcase
    end
    
    always_ff @ (posedge clk) begin
        case (bank_base_b)
        2'd0: read_data <= {bank3_read_data, bank2_read_data, bank1_read_data, bank0_read_data};
        2'd1: read_data <= {bank0_read_data, bank3_read_data, bank2_read_data, bank1_read_data};
        2'd2: read_data <= {bank1_read_data, bank0_read_data, bank3_read_data, bank2_read_data};
        2'd3: read_data <= {bank2_read_data, bank1_read_data, bank0_read_data, bank3_read_data};
        endcase
    end
endmodule
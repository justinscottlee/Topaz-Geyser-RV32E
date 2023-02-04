`timescale 1ns / 1ps

module program_counter(
    input logic clk, rst, we, stall,
    input integer write_addr,
    output integer pc0, pc4
    );
    
    always_ff @ (posedge clk) begin
        if (rst) begin
            pc0 <= 32'd0;
            pc4 <= 32'd4;
        end
        else begin
            if (!stall) begin
                if (we) begin
                    pc0 <= write_addr;
                    pc4 <= write_addr + 4;
                end
                else begin
                    pc0 <= pc4;
                    pc4 <= pc4 + 4;
                end
            end
        end
    end
endmodule
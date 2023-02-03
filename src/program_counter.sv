`timescale 1ns / 1ps

module program_counter(
    input logic clk, rst, we, stall,
    input integer write_addr,
    output integer pc0, pc4
    );
    
    integer pc;
    
    assign pc0 = pc;
    assign pc4 = pc + 32'd4;
    
    always_ff @ (posedge clk) begin
        if (rst) begin
            pc <= 32'd0;
        end
        else begin
            if (!stall) begin
                if (we) begin
                    pc <= write_addr;
                end
                else begin
                    pc <= pc4;
                end
            end
        end
    end
endmodule
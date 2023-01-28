`timescale 1ns / 1ps

module program_counter(
    input logic clk, rst, we,
    input integer write_addr,
    output integer pc4, pc0
    );
    
    integer pc;
    
    assign pc0 = pc;
    assign pc4 = pc + 32'd4;
    
    always_ff @ (posedge clk) begin
        if (rst) begin
            pc <= 32'd0;
        end
        else begin
            if (we) begin
                pc <= write_addr;
            end
            else begin
                pc <= pc4;
            end
        end
    end
endmodule
`timescale 1ns / 1ps

module regfile(
    input logic clk, rst, we,
    input logic [3:0] rs1, rs2, rd,
    input integer rd_data,
    output integer rs1_data, rs2_data
    );
    
    integer regfile[1:15];
    
    always_comb begin
        rs1_data = (rs1 == 0) ? 32'b0 : regfile[rs1];
        rs2_data = (rs2 == 0) ? 32'b0 : regfile[rs2];
    end
    
    always_ff @ (posedge clk) begin
        if (rst) begin
            for (int i = 1; i < 16; i++) begin
                regfile[i] <= 32'b0;
            end
        end
        else if (we) begin
            regfile[rd] <= rd_data;
        end
    end
endmodule
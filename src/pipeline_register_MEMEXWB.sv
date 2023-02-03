`timescale 1ns / 1ps

module pipeline_register_MEMEX_WB(
    input logic clk, invalid_MEMEX, stall,
    input logic [3:0] rd_MEMEX,
    input integer alu_result_MEMEX,
    input logic regfile_we_MEMEX,
    
    output logic invalid_WB,
    output logic [3:0] rd_WB,
    output integer alu_result_WB,
    output logic regfile_we_WB,
    
    output logic back_stall
    );
    
    logic invalid;
    
    assign invalid = invalid_MEMEX;
    assign back_stall = stall;
    
    always @ (posedge clk) begin
        if (!stall) begin
            invalid_WB <= invalid;
            rd_WB <= rd_MEMEX;
            alu_result_WB <= alu_result_MEMEX;
            regfile_we_WB <= regfile_we_MEMEX;
        end
    end
endmodule
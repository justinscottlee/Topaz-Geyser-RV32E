`timescale 1ns / 1ps

module pipeline_register_MEMPREP_MEMEX(
    input logic clk, invalid_MEMPREP, stall,
    input logic [3:0] rd_MEMPREP,
    input integer alu_result_MEMPREP,
    input logic regfile_we_MEMPREP,
    
    output logic [3:0] rd_MEMEX,
    output integer alu_result_MEMEX,
    output logic regfile_we_MEMEX
    );
    
    always @ (posedge clk) begin
        if (!stall) begin
            rd_MEMEX <= rd_MEMPREP;
            alu_result_MEMEX <= alu_result_MEMPREP;
            regfile_we_MEMEX <= regfile_we_MEMPREP;
        end
        
        if (stall | invalid_MEMPREP) begin
            regfile_we_MEMEX <= 1'b0;
        end
    end
endmodule
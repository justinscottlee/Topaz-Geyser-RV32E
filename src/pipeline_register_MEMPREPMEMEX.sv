`timescale 1ns / 1ps

module pipeline_register_EX_MEMPREP(
    input logic clk, invalid_EX, stall,
    input logic [3:0] rd_EX,
    input integer alu_result_EX,
    input logic regfile_we_EX,
    
    output logic invalid_MEMPREP,
    output logic [3:0] rd_MEMPREP,
    output integer alu_result_MEMPREP,
    output logic regfile_we_MEMPREP
    );
    
    logic invalid;
    
    assign invalid = invalid_EX;
    
    always @ (posedge clk) begin
        if (!stall) begin
            invalid_MEMPREP <= invalid;
            rd_MEMPREP <= rd_EX;
            alu_result_MEMPREP <= alu_result_EX;
            regfile_we_MEMPREP <= regfile_we_EX;
        end
    end
endmodule
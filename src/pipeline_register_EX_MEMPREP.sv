`timescale 1ns / 1ps

module pipeline_register_EX_MEMPREP(
    input logic clk, invalid_EX,
    input integer pc4_EX,
    input logic [3:0] rd_EX,
    input integer alu_result_EX,
    input logic regfile_we_EX,
    input logic [1:0] rd_data_sel_EX,
    
    output integer pc4_MEMPREP,
    output logic [3:0] rd_MEMPREP,
    output integer alu_result_MEMPREP,
    output logic regfile_we_MEMPREP,
    output logic [1:0] rd_data_sel_MEMPREP,
    output logic invalid_MEMPREP
    );
    
    always @ (posedge clk) begin
        invalid_MEMPREP <= invalid_EX;
        pc4_MEMPREP <= pc4_EX;
        rd_MEMPREP <= rd_EX;
        alu_result_MEMPREP <= alu_result_EX;
        regfile_we_MEMPREP <= regfile_we_EX;
        rd_data_sel_MEMPREP <= rd_data_sel_EX;
        
        if (invalid_EX) begin
            regfile_we_MEMPREP <= 1'b0;
        end
    end
endmodule
`timescale 1ns / 1ps

module pipeline_register_MEMPREP_MEMEX(
    input logic clk, invalid_MEMPREP,
    input integer pc4_MEMPREP,
    input logic [3:0] rd_MEMPREP,
    input integer alu_result_MEMPREP,
    input logic regfile_we_MEMPREP,
    input logic [1:0] rd_data_sel_MEMPREP,
    input logic lsu_sign_extend_MEMPREP,
    input logic [1:0] data_width_MEMPREP,
    input integer immediate_MEMPREP,
    
    output integer pc4_MEMEX,
    output logic [3:0] rd_MEMEX,
    output integer alu_result_MEMEX,
    output logic regfile_we_MEMEX,
    output logic [1:0] rd_data_sel_MEMEX,
    output logic lsu_sign_extend_MEMEX,
    output logic [1:0] data_width_MEMEX,
    output integer immediate_MEMEX,
    output logic invalid_MEMEX
    );
    
    always @ (posedge clk) begin
        invalid_MEMEX <= invalid_MEMPREP;
        pc4_MEMEX <= pc4_MEMPREP;
        rd_MEMEX <= rd_MEMPREP;
        alu_result_MEMEX <= alu_result_MEMPREP;
        regfile_we_MEMEX <= regfile_we_MEMPREP;
        rd_data_sel_MEMEX <= rd_data_sel_MEMPREP;
        lsu_sign_extend_MEMEX <= lsu_sign_extend_MEMPREP;
        data_width_MEMEX <= data_width_MEMPREP;
        immediate_MEMEX <= immediate_MEMPREP;
        
        if (invalid_MEMPREP) begin
            regfile_we_MEMEX <= 1'b0;
        end
    end
endmodule
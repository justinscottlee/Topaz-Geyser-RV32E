`timescale 1ns / 1ps

module pipeline_register_EX_MEMPREP(
    input logic clk, invalid_EX,
    input integer pc4_EX,
    input logic [3:0] rd_EX,
    input integer alu_result_EX,
    input logic regfile_we_EX,
    input logic [1:0] rd_data_sel_EX,
    input logic lsu_we_EX, lsu_sign_extend_EX,
    input logic [1:0] data_width_EX,
    input integer rs2_data_EX,
    input integer immediate_EX,
    
    output integer pc4_MEMPREP,
    output logic [3:0] rd_MEMPREP,
    output integer alu_result_MEMPREP,
    output logic regfile_we_MEMPREP,
    output logic [1:0] rd_data_sel_MEMPREP,
    output logic lsu_we_MEMPREP, lsu_sign_extend_MEMPREP,
    output logic [1:0] data_width_MEMPREP,
    output integer rs2_data_MEMPREP,
    output integer immediate_MEMPREP,
    output logic invalid_MEMPREP
    );
    
    always @ (posedge clk) begin
        invalid_MEMPREP <= invalid_EX;
        pc4_MEMPREP <= pc4_EX;
        rd_MEMPREP <= rd_EX;
        alu_result_MEMPREP <= alu_result_EX;
        regfile_we_MEMPREP <= regfile_we_EX;
        rd_data_sel_MEMPREP <= rd_data_sel_EX;
        lsu_we_MEMPREP <= lsu_we_EX;
        lsu_sign_extend_MEMPREP <= lsu_sign_extend_EX;
        data_width_MEMPREP <= data_width_EX;
        rs2_data_MEMPREP <= rs2_data_EX;
        immediate_MEMPREP <= immediate_EX;
        
        if (invalid_EX) begin
            regfile_we_MEMPREP <= 1'b0;
        end
    end
endmodule
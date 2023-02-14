`timescale 1ns / 1ps

module pipeline_register_MEMEX_WB(
    input logic clk, invalid_MEMEX,
    input integer pc4_MEMEX,
    input logic [3:0] rd_MEMEX,
    input integer alu_result_MEMEX,
    input logic regfile_we_MEMEX,
    input logic [1:0] rd_data_sel_MEMEX,
    input logic lsu_sign_extend_MEMEX,
    input logic [1:0] data_width_MEMEX,
    input integer immediate_MEMEX,
    
    output integer pc4_WB,
    output logic [3:0] rd_WB,
    output integer alu_result_WB,
    output logic regfile_we_WB,
    output logic [1:0] rd_data_sel_WB,
    output logic lsu_sign_extend_WB,
    output logic [1:0] data_width_WB,
    output integer immediate_WB,
    output logic invalid_WB
    );
    
    always @ (posedge clk) begin
        invalid_WB <= invalid_MEMEX;
        pc4_WB <= pc4_MEMEX;
        rd_WB <= rd_MEMEX;
        alu_result_WB <= alu_result_MEMEX;
        regfile_we_WB <= regfile_we_MEMEX;
        rd_data_sel_WB <= rd_data_sel_MEMEX;
        lsu_sign_extend_WB <= lsu_sign_extend_MEMEX;
        data_width_WB <= data_width_MEMEX;
        immediate_WB <= immediate_MEMEX;
        
        if (invalid_MEMEX) begin
            regfile_we_WB <= 1'b0;
        end
    end
endmodule
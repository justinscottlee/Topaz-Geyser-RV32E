`timescale 1ns / 1ps

module pipeline_register_ID_EX(
    input logic clk, invalid_ID, stall,
    input integer pc0_ID, pc4_ID,
    input logic [3:0] rd_ID, alu_operation_ID,
    input logic regfile_we_ID, alu_a_sel_ID, alu_b_sel_ID,
    input integer immediate_ID, rs1_data_ID, rs2_data_ID,
    
    output integer pc0_EX, pc4_EX, 
    output logic [3:0] rd_EX, alu_operation_EX,
    output logic regfile_we_EX, alu_a_sel_EX, alu_b_sel_EX,
    output integer immediate_EX, rs1_data_EX, rs2_data_EX
    );
    
    always @ (posedge clk) begin
        if (!stall) begin
            pc0_EX <= pc0_ID;
            pc4_EX <= pc4_ID;
            rd_EX <= rd_ID;
            alu_operation_EX <= alu_operation_ID;
            regfile_we_EX <= regfile_we_ID;
            alu_a_sel_EX <= alu_a_sel_ID;
            alu_b_sel_EX <= alu_b_sel_ID;
            immediate_EX <= immediate_ID;
            rs1_data_EX <= rs1_data_ID;
            rs2_data_EX <= rs2_data_ID;
        end
        
        if (stall | invalid_ID) begin
            regfile_we_EX <= 1'b0;
        end
    end
endmodule
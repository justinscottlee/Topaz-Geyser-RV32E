`timescale 1ns / 1ps

module forwarding_unit(
    input integer regfile_rs1_data, regfile_rs2_data,
    input logic [3:0] rs1, rs2,
    input logic regfile_we_EX, regfile_we_MEMPREP, regfile_we_MEMEX, regfile_we_WB,
    input logic [3:0] rd_EX, rd_MEMPREP, rd_MEMEX, rd_WB,
    input integer alu_result_EX, alu_result_MEMPREP, alu_result_MEMEX, alu_result_WB,
    // TODO: include rd_data_sel input from each stage to determine who is providing the data rather than just picking alu_result always
    output integer rs1_data_ID, rs2_data_ID,
    output logic rs1_data_forwarded, rs2_data_forwarded
    );
    
    always_comb begin
        if (regfile_we_EX & (rs1 == rd_EX)) begin
            rs1_data_ID = alu_result_EX;
            rs1_data_forwarded = 1;
        end
        else if (regfile_we_MEMPREP & (rs1 == rd_MEMPREP)) begin
            rs1_data_ID = alu_result_MEMPREP;
            rs1_data_forwarded = 1;
        end
        else if (regfile_we_MEMEX & (rs1 == rd_MEMEX)) begin
            rs1_data_ID = alu_result_MEMEX;
            rs1_data_forwarded = 1;
        end
        else if (regfile_we_WB & (rs1 == rd_WB)) begin
            rs1_data_ID = alu_result_WB;
            rs1_data_forwarded = 1;
        end
        else begin
            rs1_data_ID = regfile_rs1_data;
            rs1_data_forwarded = 0;
        end
        
        if (regfile_we_EX & (rs2 == rd_EX)) begin
            rs2_data_ID = alu_result_EX;
            rs2_data_forwarded = 1;
        end
        else if (regfile_we_MEMPREP & (rs2 == rd_MEMPREP)) begin
            rs2_data_ID = alu_result_MEMPREP;
            rs2_data_forwarded = 1;
        end
        else if (regfile_we_MEMEX & (rs2 == rd_MEMEX)) begin
            rs2_data_ID = alu_result_MEMEX;
            rs2_data_forwarded = 1;
        end
        else if (regfile_we_WB & (rs2 == rd_WB)) begin
            rs2_data_ID = alu_result_WB;
            rs2_data_forwarded = 1;
        end
        else begin
            rs2_data_ID = regfile_rs2_data;
            rs2_data_forwarded = 0;
        end
    end
endmodule
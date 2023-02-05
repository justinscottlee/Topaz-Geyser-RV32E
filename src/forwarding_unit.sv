`timescale 1ns / 1ps

`include "defines.vh"

module forwarding_unit(
    input integer regfile_rs1_data, regfile_rs2_data,
    input logic [3:0] rs1, rs2,
    input logic regfile_we_EX, regfile_we_MEMPREP, regfile_we_MEMEX, regfile_we_WB,
    input logic [3:0] rd_EX, rd_MEMPREP, rd_MEMEX, rd_WB,
    input integer alu_result_EX, alu_result_MEMPREP, alu_result_MEMEX, alu_result_WB,
    input integer pc4_MEMPREP, pc4_MEMEX, pc4_WB,
    input logic [1:0] rd_data_sel_EX, rd_data_sel_MEMPREP, rd_data_sel_MEMEX, rd_data_sel_WB,
    output integer rs1_data_ID, rs2_data_ID,
    output logic rs1_data_forwarded, rs2_data_forwarded
    );
    
    always_comb begin
        if (rs1 == 0) begin
            rs1_data_ID = regfile_rs1_data;
            rs1_data_forwarded = 1;
        end
        else if (regfile_we_EX & (rs1 == rd_EX)) begin
            case (rd_data_sel_EX)
            `RD_DATA_SEL_ALU: rs1_data_ID = alu_result_EX;
            endcase
            rs1_data_forwarded = 1;
        end
        else if (regfile_we_MEMPREP & (rs1 == rd_MEMPREP)) begin
            case (rd_data_sel_MEMPREP)
            `RD_DATA_SEL_ALU: rs1_data_ID = alu_result_MEMPREP;
            `RD_DATA_SEL_PC4: rs1_data_ID = pc4_MEMPREP;
            endcase
            rs1_data_forwarded = 1;
        end
        else if (regfile_we_MEMEX & (rs1 == rd_MEMEX)) begin
            case (rd_data_sel_MEMEX)
            `RD_DATA_SEL_ALU: rs1_data_ID = alu_result_MEMEX;
            `RD_DATA_SEL_PC4: rs1_data_ID = pc4_MEMEX;
            endcase
            rs1_data_forwarded = 1;
        end
        else if (regfile_we_WB & (rs1 == rd_WB)) begin
            case (rd_data_sel_WB)
            `RD_DATA_SEL_ALU: rs1_data_ID = alu_result_WB;
            `RD_DATA_SEL_PC4: rs1_data_ID = pc4_WB;
            endcase
            rs1_data_forwarded = 1;
        end
        else begin
            rs1_data_ID = regfile_rs1_data;
            rs1_data_forwarded = 0;
        end
        
        if (rs2 == 0) begin
            rs2_data_ID = regfile_rs1_data;
            rs2_data_forwarded = 1;
        end
        else if (regfile_we_EX & (rs2 == rd_EX)) begin
            case (rd_data_sel_EX)
            `RD_DATA_SEL_ALU: rs2_data_ID = alu_result_EX;
            endcase
            rs2_data_forwarded = 1;
        end
        else if (regfile_we_MEMPREP & (rs2 == rd_MEMPREP)) begin
            case (rd_data_sel_MEMPREP)
            `RD_DATA_SEL_ALU: rs2_data_ID = alu_result_MEMPREP;
            `RD_DATA_SEL_PC4: rs2_data_ID = pc4_MEMPREP;
            endcase
            rs2_data_forwarded = 1;
        end
        else if (regfile_we_MEMEX & (rs2 == rd_MEMEX)) begin
            case (rd_data_sel_MEMEX)
            `RD_DATA_SEL_ALU: rs2_data_ID = alu_result_MEMEX;
            `RD_DATA_SEL_PC4: rs2_data_ID = pc4_MEMEX;
            endcase
            rs2_data_forwarded = 1;
        end
        else if (regfile_we_WB & (rs2 == rd_WB)) begin
            case (rd_data_sel_WB)
            `RD_DATA_SEL_ALU: rs2_data_ID = alu_result_WB;
            `RD_DATA_SEL_PC4: rs2_data_ID = pc4_WB;
            endcase
            rs2_data_forwarded = 1;
        end
        else begin
            rs2_data_ID = regfile_rs2_data;
            rs2_data_forwarded = 0;
        end
    end
endmodule
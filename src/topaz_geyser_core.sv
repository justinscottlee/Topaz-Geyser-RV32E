`timescale 1ns / 1ps

`include "defines.vh"

module topaz_geyser_core(
    input logic clk, rst
    );
    
    // unpipelined, (instantly interrupt core and flush pipeline)
    logic branch_taken;
    integer branch_addr;
    
    logic stall_program_counter;
    program_counter program_counter (clk, rst, 1'b0 /*branch_taken*/, stall_program_counter, 32'b0 /*branch_addr*/, pc0_IF, pc4_IF);
    integer pc0_IF, pc4_IF;
    
    logic itcm_we_MEMEX; // TODO: pipeline LSU's itcm_we_MEMPREP
    // TODO: pipeline alu_result_MEMPREP
    // TODO: pipeline rs2_data_MEMPREP
    instruction_memory instruction_tcm (clk, itcm_we_MEMEX, stall_IF, pc0_IF, alu_result_MEMEX, rs2_data_MEMEX, instruction_ID, itcm_read_data_MEMEX);
    integer instruction_ID;
    integer itcm_read_data_MEMEX;
    
    logic invalid_IF; // TODO: make brancher invalidate IF
    logic stall_IF; // TODO: consider stall conditions from hazard unit
    pipeline_register_IF_ID pr_IFID (clk, invalid_IF, stall_IF, pc0_IF, pc4_IF, pc0_ID, pc4_ID);
    logic invalid_ID;
    integer pc0_ID, pc4_ID;
    
    logic [2:0] imm_sel;
    logic [6:0] funct7;
    logic [3:0] rs2, rs1, rd_ID;
    logic [2:0] funct3;
    logic [6:0] opcode;
    decoder decoder (instruction_ID, imm_sel, funct7, rs2, rs1, rd_ID, funct3, opcode, immediate_ID);
    control_unit control_unit (funct7, funct3, opcode, imm_sel, alu_operation_ID, regfile_we_ID, alu_a_sel_ID, alu_b_sel_ID);
    integer immediate_ID; // TODO: pipeline immediate_ID whereever needed
    logic [3:0] alu_operation_ID;
    logic regfile_we_ID;
    logic alu_a_sel_ID, alu_b_sel_ID;
    
    logic regfile_we_WB;
    logic [3:0] rd_WB;
    integer rd_data; // TODO: connect to a mux4 that is connected to all the sources needed (lives in WB)
    
    regfile regfile (clk, rst, regfile_we_WB, rs1, rs2, rd_WB, alu_result_WB/*rd_data*/, rs1_data_ID, rs2_data_ID); // TODO: verify rs1_data and rs2_data live in EX from this output (it may be ID)
    integer rs1_data_ID; // TODO: pipeline wherever needed
    integer rs2_data_ID; // TODO: pipeline wherever needed
    
    integer rs1_data_ID_PASS;
    integer rs2_data_ID_PASS;
    logic rs1_data_forwarded, rs2_data_forwarded;
    
    always_comb begin
        if (regfile_we_EX & (rs1 == rd_EX)) begin
            rs2_data_forwarded = 1'b1;
            rs1_data_ID_PASS = alu_result_EX;
        end
        else if (regfile_we_MEMPREP & (rs1 == rd_MEMPREP)) begin
            rs1_data_forwarded = 1'b1;
            rs1_data_ID_PASS = alu_result_MEMPREP;
        end
        else if (regfile_we_MEMEX & (rs1 == rd_MEMEX)) begin
            rs1_data_forwarded = 1'b1;
            rs1_data_ID_PASS = alu_result_MEMEX;
        end
        else if (regfile_we_WB & (rs1 == rd_WB)) begin
            rs1_data_forwarded = 1'b1;
            rs1_data_ID_PASS = alu_result_WB;
        end
        else begin
            rs1_data_forwarded = 1'b0;
            rs1_data_ID_PASS = rs1_data_ID;
        end
        
        if (regfile_we_EX & (rs2 == rd_EX)) begin
            rs2_data_forwarded = 1'b1;
            rs2_data_ID_PASS = alu_result_EX;
            
            /*
            case (rd_data_sel_EX) begin
            `RD_DATA_SEL_ALU: ...
            `RD_DATA_SEL_LSU: ...
            end
            */
        end
        else if (regfile_we_MEMPREP & (rs2 == rd_MEMPREP)) begin
            rs2_data_forwarded = 1'b1;
            rs2_data_ID_PASS = alu_result_MEMPREP;
        end
        else if (regfile_we_MEMEX & (rs2 == rd_MEMEX)) begin
            rs2_data_forwarded = 1'b1;
            rs2_data_ID_PASS = alu_result_MEMEX;
        end
        else if (regfile_we_WB & (rs2 == rd_WB)) begin
            rs2_data_forwarded = 1'b1;
            rs2_data_ID_PASS = alu_result_WB;
        end
        else begin
            rs2_data_forwarded = 1'b0;
            rs2_data_ID_PASS = rs2_data_ID;
        end
    end
    
    logic stall_ID; // TODO: consider stall conditions from hazard unit
    pipeline_register_ID_EX pr_IDEX (clk, invalid_ID, stall_ID, pc0_ID, pc4_ID, rd_ID, alu_operation_ID, regfile_we_ID, alu_a_sel_ID, alu_b_sel_ID, immediate_ID, rs1_data_ID_PASS, rs2_data_ID_PASS, pc0_EX, pc4_EX, rd_EX, alu_operation_EX, regfile_we_EX, alu_a_sel_EX, alu_b_sel_EX, immediate_EX, rs1_data_EX, rs2_data_EX);
    logic invalid_EX; // TODO: attch to EX_MEMPREP pr
    integer pc0_EX, pc4_EX; // TODO: pipeline to MEMPREP? doublecheck
    logic [3:0] rd_EX;
    logic [3:0] alu_operation_EX;
    logic regfile_we_EX;
    logic alu_a_sel_EX, alu_b_sel_EX;
    integer immediate_EX; // TODO: pipeline to WB
    integer rs1_data_EX;
    integer rs2_data_EX;
    
    mux2 mux_alu_a (alu_a_sel_EX, rs1_data_EX, pc0_EX, alu_a);
    integer alu_a;
    mux2 mux_alu_b (alu_b_sel_EX, immediate_EX, rs2_data_EX, alu_b);
    integer alu_b;
    
    alu alu (alu_operation_EX, alu_a, alu_b, alu_result_EX);
    integer alu_result_EX;
    
    logic stall_EX;
    pipeline_register_EX_MEMPREP pr_EXMEMPREP (clk, invalid_EX, stall_EX, rd_EX, alu_result_EX, regfile_we_EX, rd_MEMPREP, alu_result_MEMPREP, regfile_we_MEMPREP);
    logic invalid_MEMPREP;
    logic [3:0] rd_MEMPREP;
    integer alu_result_MEMPREP;
    logic regfile_we_MEMPREP;
    
    logic stall_MEMPREP;
    pipeline_register_MEMPREP_MEMEX pr_MEMPREPMEMEX (clk, invalid_MEMPREP, stall_MEMPREP, rd_MEMPREP, alu_result_MEMPREP, regfile_we_MEMPREP, rd_MEMEX, alu_result_MEMEX, regfile_we_MEMEX);
    logic invalid_MEMEX;
    logic [3:0] rd_MEMEX;
    integer alu_result_MEMEX;
    logic regfile_we_MEMEX;
    
    logic stall_MEMEX;
    pipeline_register_MEMEX_WB pr_MEMEXWB (clk, invalid_MEMEX, stall_MEMEX, rd_MEMEX, alu_result_MEMEX, regfile_we_MEMEX, rd_WB, alu_result_WB, regfile_we_WB);
    logic invalid_WB;
    integer alu_result_WB;
    
    //mux4 mux_rd_data ();
    assign stall_program_counter = stall_IF;
    assign stall_IF = stall_ID;
    always_comb begin
        logic signal = ~rs1_data_forwarded & ~rs2_data_forwarded & (((rs1 == rd_EX | rs2 == rd_EX) & regfile_we_EX) | ((rs1 == rd_MEMPREP | rs2 == rd_MEMPREP) & regfile_we_MEMPREP) | ((rs1 == rd_MEMEX | rs2 == rd_MEMEX) & regfile_we_MEMEX) | ((rs1 == rd_WB | rs2 == rd_WB) & regfile_we_WB));
        case (signal)
        1'b1: begin
            stall_ID = 1'b1;
        end
        1'b0: begin
            stall_ID = 1'b0;
        end
        default: begin
            stall_ID = 1'b0;
        end
        endcase
    end
    assign stall_EX = stall_MEMPREP;
    assign stall_MEMPREP = stall_MEMEX;
    assign stall_MEMEX = 1'b0;
endmodule
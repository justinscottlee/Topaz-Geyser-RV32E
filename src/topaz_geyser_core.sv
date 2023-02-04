`timescale 1ns / 1ps

module topaz_geyser_core(
    input logic clk_in, rst_in,
    output logic [8:0] outputreg
    );
    
    clk_wiz_0 clk_wiz (.clk_in1(clk_in), .reset(rst_in), .locked(locked), .clk_out(clk));
    
    logic rst; // generate initial cpu reset signal
    always_ff @ (posedge clk or posedge locked) begin
        if (locked) rst <= 1;
        if (clk) rst <= 0;
    end
    
    always_ff @ (posedge clk) begin
        if (alu_result_WB[31:20] == 0) begin
            outputreg <= alu_result_WB[8:0];
        end
    end
    
    logic stall_PC;
    program_counter program_counter (.clk(clk), .rst(rst), .we(1'b0) /*branch_taken*/, .stall(stall_PC), .write_addr(32'b0) /*write_addr, branch_addr*/, .pc0(pc0_IF), .pc4(pc4_IF));
    integer pc0_IF, pc4_IF;
    // IF-STAGE
    instruction_memory itcm (.clk(clk), .we(1'b0) /*lsu-controlled*/, .addr_ro(pc0_IF[11:0]), .addr_rw(32'b0) /*alu_result_MEMEX*/, .write_instruction_rw(32'b0) /*rs2_data_MEMEX*/, .read_instruction_ro(instruction_IF), .read_instruction_rw(/*itcm_read_data_WB*/));
    integer instruction_IF;
    
    logic stall_IF;
    logic invalid_IF = 0;
    pipeline_register_IF_ID pr_IF_ID (clk, invalid_IF, stall_IF, pc0_IF, pc4_IF, instruction_IF, pc0_ID, pc4_ID, instruction_ID);
    integer pc0_ID, pc4_ID, instruction_ID;
    // ID-STAGE
    control_unit control_unit (instruction_ID, immediate_ID, rd_ID, rs1, rs2, alu_operation_ID, regfile_we_ID, alu_a_sel_ID, alu_b_sel_ID);
    integer immediate_ID;
    logic [3:0] rd_ID, rs1, rs2;
    logic [3:0] alu_operation_ID;
    logic regfile_we_ID, alu_a_sel_ID, alu_b_sel_ID;
    logic regfile_we_WB;
    integer alu_result_WB;
    regfile regfile (clk, rst, regfile_we_WB, rs1, rs2, rd_WB, alu_result_WB /*rd_data, replace with a mux later*/, regfile_rs1_data, regfile_rs2_data);
    integer regfile_rs1_data, regfile_rs2_data;
    forwarding_unit forwarding_unit (regfile_rs1_data, regfile_rs2_data, rs1, rs2, regfile_we_EX, regfile_we_MEMPREP, regfile_we_MEMEX, regfile_we_WB, rd_EX, rd_MEMPREP, rd_MEMEX, rd_WB, alu_result_EX, alu_result_MEMPREP, alu_result_MEMEX, alu_result_WB, rs1_data_ID, rs2_data_ID, rs1_data_forwarded, rs2_data_forwarded);
    integer rs1_data_ID, rs2_data_ID;
    logic rs1_data_forwarded, rs2_data_forwarded;
    
    logic stall_ID;
    logic invalid_ID = 0;
    pipeline_register_ID_EX pr_ID_EX (clk, invalid_ID, stall_ID, pc0_ID, pc4_ID, rd_ID, alu_operation_ID, regfile_we_ID, alu_a_sel_ID, alu_b_sel_ID, immediate_ID, rs1_data_ID, rs2_data_ID, pc0_EX, pc4_EX, rd_EX, alu_operation_EX, regfile_we_EX, alu_a_sel_EX, alu_b_sel_EX, immediate_EX, rs1_data_EX, rs2_data_EX);
    integer pc0_EX, pc4_EX;
    logic [3:0] rd_EX, alu_operation_EX;
    logic regfile_we_EX, alu_a_sel_EX, alu_b_sel_EX;
    integer immediate_EX, rs1_data_EX, rs2_data_EX;
    // EX-STAGE
    logic alu_a_sel_EX, alu_b_sel_EX;
    mux2 mux_alu_a (alu_a_sel_EX, rs1_data_EX, pc0_EX, alu_a);
    mux2 mux_alu_b (alu_b_sel_EX, immediate_EX, rs2_data_EX, alu_b);
    integer alu_a, alu_b;
    alu alu (alu_operation_EX, alu_a, alu_b, alu_result_EX);
    integer alu_result_EX;
    
    logic stall_EX;
    logic invalid_EX = 0;
    pipeline_register_EX_MEMPREP pr_EX_MEMPREP (clk, invalid_EX, stall_EX, rd_EX, alu_result_EX, regfile_we_EX, rd_MEMPREP, alu_result_MEMPREP, regfile_we_MEMPREP);
    logic [3:0] rd_MEMPREP;
    integer alu_result_MEMPREP;
    logic regfile_we_MEMPREP;
    // MEMPREP-STAGE
    
    logic stall_MEMPREP;
    logic invalid_MEMPREP = 0;
    pipeline_register_MEMPREP_MEMEX pr_MEMPREP_MEMEX (clk, invalid_MEMPREP, stall_MEMPREP, rd_MEMPREP, alu_result_MEMPREP, regfile_we_MEMPREP, rd_MEMEX, alu_result_MEMEX, regfile_we_MEMEX);
    logic [3:0] rd_MEMEX;
    integer alu_result_MEMEX;
    logic regfile_we_MEMEX;
    // MEMEX-STAGE
    
    logic stall_MEMEX;
    logic invalid_MEMEX = 0;
    pipeline_register_MEMEX_WB pr_MEMEX_WB (clk, invalid_MEMEX, stall_MEMEX, rd_MEMEX, alu_result_MEMEX, regfile_we_MEMEX, rd_WB, alu_result_WB, regfile_we_WB);
    logic [3:0] rd_WB;
    integer alu_result_WB;
    logic regfile_we_WB;
    
    assign stall_PC = stall_IF;
    assign stall_IF = stall_ID;
    always_comb begin
        logic should_stall = (~rs1_data_forwarded & (((rs1 == rd_EX) & regfile_we_EX) | ((rs1 == rd_MEMPREP) & regfile_we_MEMPREP) | ((rs1 == rd_MEMEX) & regfile_we_MEMEX) | ((rs1 == rd_WB) & regfile_we_WB))) | (~rs2_data_forwarded & (((rs2 == rd_EX) & regfile_we_EX) | ((rs2 == rd_MEMPREP) & regfile_we_MEMPREP) | ((rs2 == rd_MEMEX) & regfile_we_MEMEX) | ((rs2 == rd_WB) & regfile_we_WB)));
        case (should_stall)
        1: stall_ID = 1;
        0: stall_ID = 0;
        default: stall_ID = 0;
        endcase
    end
    assign stall_EX = stall_MEMPREP;
    assign stall_MEMPREP = stall_MEMEX;
    assign stall_MEMEX = 0;
    
    // test output to prevent synthesizer from optimizing away the cpu
    always_ff @ (posedge clk) begin
        //if (alu_result_WB[31:26] == 0) begin
            //outputreg = alu_result_WB[8:0];
        //end
    end
endmodule
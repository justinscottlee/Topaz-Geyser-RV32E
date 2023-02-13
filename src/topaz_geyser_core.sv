`timescale 1ns / 1ps

module topaz_geyser_core(
    input logic sys_clk, cpu_rst,
    output logic [14:0] seven_segment_control_field
    );
    
    logic clk;
    clk_wiz_0 clk_wiz (.clk_100M(sys_clk), .reset(~cpu_rst), .locked(locked), .clk_170M(clk));

    logic rst;
    always_ff @ (posedge clk or posedge locked) begin
        if (locked) rst <= 1;
        if (clk) rst <= 0;
    end
/*
    logic rst;
    assign rst = ~cpu_rst;
    
    logic clk = 0;
    logic [16:0] clock_division_counter = 0;
    always_ff @ (posedge sys_clk) begin
        clock_division_counter <= clock_division_counter + 1;
        if (clock_division_counter == 0) begin
            clk = ~clk;
        end
    end
*/
    seven_segment_display_controller seven_segment_display_controller (sys_clk, alu_result_EX, seven_segment_control_field);

    logic stall;
    
    program_counter program_counter (.clk(clk), .rst(rst), .we(branch_taken), .stall(stall), .write_addr(branch_addr), .pc0(pc0_IF), .pc4(pc4_IF));
    integer pc0_IF, pc4_IF;
    // IF-STAGE
    instruction_memory itcm (.clk(clk), .we(1'b0) /*lsu-controlled*/, .addr_ro(pc0_IF[11:0]), .addr_rw(12'b0) /*alu_result_MEMEX*/, .write_instruction_rw(32'b0) /*rs2_data_MEMEX*/, .read_instruction_ro(instruction_IF), .read_instruction_rw(/*itcm_read_data_WB*/));
    integer instruction_IF;
    
    // PIPELINE WALL COMMENT -- IF-ID BOUNDARY
    pipeline_register_IF_ID pr_IF_ID (clk, branch_taken | rst, stall, pc0_IF, pc4_IF, instruction_IF, pc0_ID, pc4_ID, instruction_ID, invalid_ID);
    logic invalid_ID;
    integer pc0_ID, pc4_ID, instruction_ID;
    // ID-STAGE
    // TODO: make the control unit make the control signals
    control_unit control_unit (instruction_ID, immediate_ID, rd_ID, rs1, rs2, alu_operation_ID, regfile_we_ID, alu_a_sel_ID, alu_b_sel_ID, branch_condition_ID, rd_data_sel_ID, branch_base_sel_ID, lsu_we_ID, lsu_sign_extend_ID, data_width_ID);
    integer immediate_ID;
    logic [3:0] rd_ID, rs1, rs2;
    logic [3:0] alu_operation_ID;
    logic regfile_we_ID, alu_a_sel_ID, alu_b_sel_ID;
    logic [1:0] branch_condition_ID, rd_data_sel_ID;
    logic branch_base_sel_ID, lsu_we_ID, lsu_sign_extend_ID;
    logic [1:0] data_width_ID;
    regfile regfile (clk, rst, regfile_we_WB, rs1, rs2, rd_WB, rd_data_WB, regfile_rs1_data, regfile_rs2_data);
    integer regfile_rs1_data, regfile_rs2_data;
    forwarding_unit forwarding_unit (regfile_rs1_data, regfile_rs2_data, rs1, rs2, regfile_we_EX & ~invalid_EX, regfile_we_MEMPREP & ~invalid_MEMPREP, regfile_we_MEMEX & ~invalid_MEMEX, regfile_we_WB & ~invalid_WB, rd_EX, rd_MEMPREP, rd_MEMEX, rd_WB, alu_result_EX, alu_result_MEMPREP, alu_result_MEMEX, alu_result_WB, pc4_MEMPREP, pc4_MEMEX, pc4_WB, rd_data_sel_EX, rd_data_sel_MEMPREP, rd_data_sel_MEMEX, rd_data_sel_WB, rs1_data_ID, rs2_data_ID, rs1_data_forwarded, rs2_data_forwarded);
    integer rs1_data_ID, rs2_data_ID;
    logic rs1_data_forwarded, rs2_data_forwarded;
    
    // PIPELINE WALL COMMENT -- ID-EX BOUNDARY
    pipeline_register_ID_EX pr_ID_EX (clk, branch_taken | invalid_ID | rst, stall, pc0_ID, pc4_ID, rd_ID, alu_operation_ID, regfile_we_ID, alu_a_sel_ID, alu_b_sel_ID, immediate_ID, rs1_data_ID, rs2_data_ID, branch_condition_ID, rd_data_sel_ID, branch_base_sel_ID, lsu_we_ID, lsu_sign_extend_ID, data_width_ID, pc0_EX, pc4_EX, rd_EX, alu_operation_EX, regfile_we_EX, alu_a_sel_EX, alu_b_sel_EX, immediate_EX, rs1_data_EX, rs2_data_EX, branch_condition_EX, rd_data_sel_EX, branch_base_sel_EX, lsu_we_EX, lsu_sign_extend_EX, data_width_EX, invalid_EX);
    logic invalid_EX;
    integer pc0_EX, pc4_EX;
    logic [3:0] rd_EX, alu_operation_EX;
    logic regfile_we_EX, alu_a_sel_EX, alu_b_sel_EX;
    integer immediate_EX, rs1_data_EX, rs2_data_EX;
    logic [1:0] branch_condition_EX, rd_data_sel_EX;
    logic branch_base_sel_EX, lsu_we_EX, lsu_sign_extend_EX;
    logic [1:0] data_width_EX;
    // EX-STAGE
    mux2 mux_alu_a (alu_a_sel_EX, rs1_data_EX, pc0_EX, alu_a);
    mux2 mux_alu_b (alu_b_sel_EX, immediate_EX, rs2_data_EX, alu_b);
    integer alu_a, alu_b;
    alu alu (alu_operation_EX, alu_a, alu_b, alu_result_EX);
    integer alu_result_EX;
    
    mux2 mux_branch_base (branch_base_sel_EX, pc0_EX, rs1_data_EX, branch_base);
    integer branch_base;
    brancher brancher (clk, branch_taken | rst, branch_condition_EX, alu_result_EX, branch_taken, branch_base, immediate_EX, branch_addr);
    logic branch_taken;
    integer branch_addr;
    
    // PIPELINE WALL COMMENT -- EX-MEMPREP BOUNDARY
    pipeline_register_EX_MEMPREP pr_EX_MEMPREP (clk, branch_taken | invalid_EX | rst, pc4_EX, rd_EX, alu_result_EX, regfile_we_EX, rd_data_sel_EX, lsu_we_EX, lsu_sign_extend_EX, data_width_EX, rs2_data_EX, pc4_MEMPREP, rd_MEMPREP, alu_result_MEMPREP, regfile_we_MEMPREP, rd_data_sel_MEMPREP, lsu_we_MEMPREP, lsu_sign_extend_MEMPREP, data_width_MEMPREP, rs2_data_MEMPREP, invalid_MEMPREP);
    logic invalid_MEMPREP;
    integer pc4_MEMPREP;
    logic [3:0] rd_MEMPREP;
    integer alu_result_MEMPREP;
    logic regfile_we_MEMPREP;
    logic [1:0] rd_data_sel_MEMPREP;
    logic lsu_we_MEMPREP, lsu_sign_extend_MEMPREP;
    logic [1:0] data_width_MEMPREP;
    integer rs2_data_MEMPREP;
    
    
    // NOTE: this stuff should all be mostly fine??? just setup the variables retrieved from the control unit (make sure to get the logic inside there correct), and then pipeline that shit throughout the whole pipeline
    
    // MEMPREP-STAGE
    // sign extend only affects reads
    logic lsu_we_MEMPREP, lsu_sign_extend_WB;
    logic [1:0] data_width_WB;
    load_store_unit lsu (clk, lsu_we_MEMPREP, lsu_sign_extend_WB, data_width_WB, alu_result_WB, alu_result_MEMPREP, dtcm_we_MEMPREP, dtcm_read_data_WB, lsu_read_data_WB);
    logic dtcm_we_MEMPREP;
    integer lsu_read_data_WB;
    single_port_memory_group dtcm (clk, dtcm_we_MEMPREP, data_width_MEMPREP, alu_result_MEMPREP - 32'h1000, rs2_data_MEMPREP, dtcm_read_data_WB);
    integer dtcm_read_data_WB;
    
    // PIPELINE WALL COMMENT -- MEMPREP-MEMEX BOUNDARY
    pipeline_register_MEMPREP_MEMEX pr_MEMPREP_MEMEX (clk, invalid_MEMPREP | rst, pc4_MEMPREP, rd_MEMPREP, alu_result_MEMPREP, regfile_we_MEMPREP, rd_data_sel_MEMPREP, lsu_sign_extend_MEMPREP, data_width_MEMPREP, pc4_MEMEX, rd_MEMEX, alu_result_MEMEX, regfile_we_MEMEX, rd_data_sel_MEMEX, lsu_sign_extend_MEMEX, data_width_MEMEX, invalid_MEMEX);
    logic invalid_MEMEX;
    integer pc4_MEMEX;
    logic [3:0] rd_MEMEX;
    integer alu_result_MEMEX;
    logic regfile_we_MEMEX;
    logic [1:0] rd_data_sel_MEMEX;
    logic lsu_sign_extend_MEMEX;
    logic [1:0] data_width_MEMEX;
    // MEMEX-STAGE
    
    // PIPELINE WALL COMMENT -- MEMEX-WB BOUNDARY
    pipeline_register_MEMEX_WB pr_MEMEX_WB (clk, invalid_MEMEX | rst, pc4_MEMEX, rd_MEMEX, alu_result_MEMEX, regfile_we_MEMEX, rd_data_sel_MEMEX, lsu_sign_extend_MEMEX, data_width_MEMEX, pc4_WB, rd_WB, alu_result_WB, regfile_we_WB, rd_data_sel_WB, lsu_sign_extend_WB, data_width_WB, invalid_WB);
    logic invalid_WB;
    integer pc4_WB;
    logic [3:0] rd_WB;
    integer alu_result_WB;
    logic regfile_we_WB;
    logic [1:0] rd_data_sel_WB;
    logic lsu_sign_extend_WB;
    logic [1:0] data_width_WB;
    
    mux4 mux_rd_data (rd_data_sel_WB, alu_result_WB, pc4_WB, lsu_read_data_WB, 32'b0, rd_data_WB);
    integer rd_data_WB;
    
    always_comb begin
        logic should_stall = (~rs1_data_forwarded & (((rs1 == rd_EX) & regfile_we_EX & ~invalid_EX) | ((rs1 == rd_MEMPREP) & regfile_we_MEMPREP & ~invalid_MEMPREP) | ((rs1 == rd_MEMEX) & regfile_we_MEMEX & ~invalid_MEMEX) | ((rs1 == rd_WB) & regfile_we_WB & ~invalid_WB))) | (~rs2_data_forwarded & (((rs2 == rd_EX) & regfile_we_EX & ~invalid_EX) | ((rs2 == rd_MEMPREP) & regfile_we_MEMPREP & ~invalid_MEMPREP) | ((rs2 == rd_MEMEX) & regfile_we_MEMEX & ~invalid_MEMEX) | ((rs2 == rd_WB) & regfile_we_WB & ~invalid_WB)));
        case (should_stall)
        1: stall = 1;
        0: stall = 0;
        default: stall = 0;
        endcase
    end
endmodule
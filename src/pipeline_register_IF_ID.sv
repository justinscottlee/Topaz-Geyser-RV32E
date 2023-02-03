`timescale 1ns / 1ps

module pipeline_register_IF_ID(
    input logic clk, invalid_IF, stall,
    input integer pc0_IF, pc4_IF,
    
    output logic invalid_ID,
    output integer pc0_ID, pc4_ID
    );
    
    logic invalid;
    
    assign invalid = invalid_IF;
    
    always @ (posedge clk) begin
        if (!stall) begin
            invalid_ID <= invalid;
            pc0_ID <= pc0_IF;
            pc4_ID <= pc4_IF;
        end
    end
endmodule
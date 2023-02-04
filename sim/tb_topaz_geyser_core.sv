`timescale 1ns / 1ps

module tb_topaz_geyser_core;

    logic clk, rst;
    
    topaz_geyser_core dut(.clk_in(clk), .rst_in(rst));
    
    always #1 clk = ~clk;
    
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        #10;
        rst = 1'b0;
        
        #15000;
        $finish;
    end
endmodule
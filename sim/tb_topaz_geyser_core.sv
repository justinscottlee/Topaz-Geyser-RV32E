`timescale 1ns / 1ps

module tb_topaz_geyser_core;

    logic clk, rst;
    
    topaz_geyser_core dut(.sys_clk(clk), .cpu_rst(rst));
    
    always #1 clk = ~clk;
    
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        #10;
        rst = 1'b1;
        
        #10000;
        $finish;
    end
endmodule
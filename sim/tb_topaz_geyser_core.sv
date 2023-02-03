`timescale 1ns / 1ps

module tb_topaz_geyser_core;

    logic clk, rst;
    
    topaz_geyser_core dut(clk, rst);
    
    always #1 clk = ~clk;
    
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        #1;
        #2;
        rst = 1'b0;
        
        
        #40;
        $finish;
    end
endmodule
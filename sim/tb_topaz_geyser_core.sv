`timescale 1ns / 1ps

module tb_topaz_geyser_core;

    logic clk, rst;
    logic [14:0] seven_segment_control_field;
    logic spi_mosi, spi_miso, spi_sck;
    
    topaz_geyser_core dut(.sys_clk(clk), .cpu_rst(rst), .seven_segment_control_field(seven_segment_control_field), .spi_mosi(spi_mosi), .spi_miso(spi_miso), .spi_sck(spi_sck));
    
    always #1 clk = ~clk;
    
    assign spi_miso = 1'b0;
    
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        #10;
        rst = 1'b1;
        
        #10000;
        $finish;
    end
endmodule
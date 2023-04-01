`timescale 1ns / 1ps

module tb_topaz_geyser_core;

    logic clk, rst;
    logic [14:0] seven_segment_control_field;
    logic spi_mosi, spi_miso, spi_sck;
    logic ic_we;
    wire [7:0] ic_io;
    logic [16:0] ic_addr;
    
    topaz_geyser_core dut(.sys_clk(clk), .cpu_rst(rst), .seven_segment_control_field(seven_segment_control_field), .spi_mosi(spi_mosi), .spi_miso(spi_miso), .spi_sck(spi_sck), .ic_we(ic_we), .ic_io(ic_io), .ic_addr(ic_addr));
    
    always #1 clk = ~clk;
    always #3 spi_miso = ~spi_miso;
    
    initial begin
        clk = 1'b0;
        rst = 1'b0;
        #2000;
        rst = 1'b1;
        spi_miso = 1'b1;
        
        #100000;
        $finish;
    end
endmodule
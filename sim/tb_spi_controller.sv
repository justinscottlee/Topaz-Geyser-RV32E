`timescale 1ns / 1ps

module tb_spi_controller;

reg clk, rst, miso;
wire mosi, slave_clk, slave_select;
reg [63:0] command;
wire [63:0] response;
wire [7:0] csr;

spi_controller dut(clk, rst, miso, mosi, slave_clk, slave_select, command, response, csr);

always #1 clk = ~clk;

logic ready = 0;
assign csr[3:1] = 3'd4;
assign csr[4] = ready;

initial begin
    clk = 0;
    rst = 0;
    command = {8'h3, 24'h1000, 8'h74, 24'b0};
    #5;
    ready = 1;
    #5;
    ready = 0;
    #500;
    
    $finish;
end
endmodule
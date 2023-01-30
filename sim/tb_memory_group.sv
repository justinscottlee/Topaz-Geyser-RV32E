`timescale 1ns / 1ps

module tb_memory_group;

logic clk;
logic [3:0] write_mask;
logic [13:0] addr;
integer write_data, read_data;

memory_group dut (clk, write_mask, addr, write_data, read_data);

always #1 clk = ~clk;

initial begin
    clk = 1'b0;
    addr = 14'h0;
    write_data = 32'h77ff8855;
    write_mask = 4'b1111;
    #10;
    #2;
    addr = 14'h1;
    #4;
    addr = 14'h0;
    #2;
    write_mask = 4'b0;
    #2;
    addr = 14'h1;
    #2;
    addr = 14'h2;
    #2;
    addr = 14'h3;
    #2;
    addr = 14'h4;
    #2;
    $finish;
end

endmodule

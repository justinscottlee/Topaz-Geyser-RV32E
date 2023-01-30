`timescale 1ns / 1ps

module tb_dual_port_memory_group;

logic clk;
logic [3:0] write_mask;
logic [13:0] addr_a, addr_b;
integer write_data, read_data;

dual_port_memory_group dut (clk, write_mask, addr_a, addr_b, write_data, read_data);

always #1 clk = ~clk;

initial begin
    clk = 1'b0;
    addr_a = 14'h0;
    addr_b = 14'h0;
    write_data = 32'h77ff8855;
    write_mask = 4'b1111;
    #4;
    addr_a = 14'h4;
    write_data = 32'h116699aa;
    #2;
    addr_b = 14'h1;
    #2;
    addr_b = 14'h2;
    #2;
    write_data = 32'h55440011;
    addr_a = 14'h0;
    #2;
    addr_b = 14'h4;
    #2;
    $finish;
end

endmodule
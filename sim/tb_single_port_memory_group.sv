`timescale 1ns / 1ps

module tb_single_port_memory_group;

logic clk, we;
logic [1:0] data_width;
integer addr, write_data, read_data;

single_port_memory_group dut (clk, we, data_width, addr, write_data, read_data);

always #1 clk = ~clk;

initial begin
    clk = 1'b0;
    #1;
    
    // WRITE 1 MEMPREP
    we = 1'b1;
    data_width = 2'b10;
    addr = 32'h0;
    write_data = 32'h77FF99AA;
    #2; // wait for cycle to finish
    
    // WRITE 1 MEMEX
    // READ 1 MEMPREP
    we = 1'b0;
    #2; // wait for cycle to finish
    
    // WRITE 1 WB (instruction complete)
    // READ 1 MEMEX
    // READ 2 MEMPREP
    addr = 32'h1;
    #2; // wait for cycle to finish
    
    // READ 1 WB (should be outputting)
    // READ 2 MEMEX
    // WRITE 2 MEMPREP
    addr = 32'h2;
    we = 1'b1;
    write_data = 32'h11111111;
    #2; // wait for cycle to finish
    
    // READ 2 WB (should be outputting)
    // WRITE 2 MEMEX
    // READ 3 MEMPREP
    we = 1'b0;
    addr = 1'b0;
    #2; // wait for cycle to finish
    
    // WRITE 2 WB
    // READ 3 MEMEX
    // READ 4 MEMPREP
    addr = 32'h3;
    #2; // wait for cycle to finish
    
    // READ 3 WB (should be outputting)
    // READ 4 MEMEX
    #2; // wait for cycle to finish
    
    // READ 4 WB (should be outputting)
    #2; // wait for cycle to finish
    $finish;
end

endmodule
`timescale 1ns / 1ps

// CE_1 physically hardwired to 0
// CE_2 physically hardwired to 1
// VCC physically hardwired to VCC
// GND physically hardwired to GND
// OE physically hardwired to 0
module sram_controller(
    input logic clk, rst, we, trigger,
    input logic [16:0] addr,
    input logic [7:0] rs2_data,
    output logic [7:0] read_data,
    output logic busy,
    
    output logic ic_we,         // IC write-enable pin (active low)
    inout logic [7:0] ic_io,    // IC I/O pins (bidirectional)
    output logic [16:0] ic_addr // IC address pins
    );
    
    reg [7:0] write_data;
    
    // Assuming SRAM Controller Clock is 200 MHz, timing increments are by 5 ns.
    reg [7:0] tRC = 9;
    
    reg [7:0] tSA = 0;
    reg [7:0] tHZWE = 4;
    reg [7:0] tPWE = 7;
    reg [7:0] tSD = 5;
    reg [7:0] tHD = 0;
    reg [7:0] tWC = 9;
    
    reg [7:0] timing_counter;
    
    localparam IDLE = 2'b00;
    localparam READ = 2'b01;    // READ operation is Address Transition Controlled (Ready Cylce No. 1 in datasheet)
    localparam WRITE = 2'b10;   // WRITE operation is WE controlled, OE low (Write Cycle No. 3 in datasheet)
    
    bit [1:0] state;
    assign busy = state != IDLE;                        // busy signal to control pipeline stalling.
    bit io_drive;
    assign ic_io = (io_drive ? write_data : 8'hZZ);     // inout I/O pins driven if writing, else undriven for read operation.
    
    always_ff @ (posedge clk) begin
        if (rst) begin
            timing_counter <= 8'b0;
            state <= IDLE;
        end
        else begin
            case (state)
            IDLE: begin
                ic_we <= 1'b1;                          // write-enable is false in IDLE state
                io_drive <= 1'b0;                       // I/O pins are undriven for IDLE state
                write_data <= rs2_data;
                if (trigger) begin
                    timing_counter <= 7'b0;             // Reset timing counter.
                    ic_addr <= addr;                    // address is locked into ic_addr bus for operation.
                    if (we) state <= WRITE;
                    else state <= READ;
                end
            end
            READ: begin
                ic_we <= 1'b1;                          // write-enable is false in READ state
                io_drive <= 1'b0;                       // I/O pins are undriven for READ state
                timing_counter <= timing_counter + 1;
                if (timing_counter == tRC) begin
                    read_data <= ic_io;
                    state <= IDLE;
                end
            end
            WRITE: begin
                timing_counter <= timing_counter + 1;
                if (timing_counter == tSA) begin
                    ic_we <= 1'b0;
                end
                
                if (timing_counter == (tSA + tHZWE)) begin
                    io_drive <= 1'b1;
                end
                
                if (timing_counter == (tSA + tHZWE + tSD)) begin
                    ic_we <= 1'b1;
                end
                
                if (timing_counter == (tSA + tHZWE + tSD + tHD)) begin
                    io_drive <= 1'b0;
                end
                
                if (timing_counter == tWC) begin
                    state <= IDLE;
                end
            end
            endcase
        end
    end
endmodule
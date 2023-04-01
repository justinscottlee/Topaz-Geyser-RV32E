`timescale 1ns / 1ps

module spi_controller (
    input logic clk, rst, trigger,

    input logic miso,
    output logic mosi, sck,

    /*input logic pol, pha,*/
    output logic busy,

    input logic [7:0] tx_data,
    output logic [7:0] rx_data
);

localparam IDLE = 2'b00, TRANSFER = 2'b01, TIMING = 2'b10;

bit [1:0] state;
bit [2:0] index;

assign busy = (state != IDLE);
assign mosi = tx_data[index];

function void reset();
    state <= IDLE;
    index <= 3'd7;
    sck <= 1'b0;
endfunction

always_ff @ (posedge clk) begin
    if (rst) begin
        reset();
    end

    case (state)
    IDLE: begin
        if (trigger) begin
            state <= TRANSFER;
        end
    end

    TRANSFER: begin
        rx_data[index] <= miso;
        sck <= ~sck;
        state <= TIMING;
    end

    TIMING: begin
        index <= index - 1;
        sck <= ~sck;
        if (index == 0) begin
            reset();
        end
        else begin
            state <= TRANSFER;
        end
    end
    endcase
end
endmodule
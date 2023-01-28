`timescale 1ns / 1ps

module mux4(
    input logic [1:0] sel,
    input integer a, b, c, d,
    output integer out
    );
    
    always_comb begin
        case(sel)
        2'b00: out = a;
        2'b01: out = b;
        2'b10: out = c;
        2'b11: out = d;
        endcase
    end
endmodule
`timescale 1ns / 1ps

module mux2(
    input logic sel,
    input integer a, b,
    output integer out
    );

    always_comb begin
        case (sel)
        1'd0: out = a;
        1'd1: out = b;
        endcase
    end
endmodule
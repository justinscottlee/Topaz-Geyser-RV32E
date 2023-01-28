`timescale 1ns / 1ps

module adder(
    input integer a, b,
    output integer sum
    );
    
    always_comb begin
        sum = a + b;
    end
endmodule
`timescale 1ns / 1ps

module seven_segment_display_controller (
    input logic clk,
    input integer value,
    output logic [14:0] control_field
    );

    logic [3:0] digits[7:0];
    logic [3:0] counter = 0;
    logic [15:0] clock_division_counter = 0;

    always_comb begin
        for (int i = 0; i < 8; i++) begin
            digits[i] = (value >> (i << 2)) & 'hF;
        end
    end

    function void output_digit (logic [2:0] digit);
        case (digits[digit])
        'h0: control_field[6:0] <= 7'b0000001;
        'h1: control_field[6:0] <= 7'b1001111;
        'h2: control_field[6:0] <= 7'b0010010;
        'h3: control_field[6:0] <= 7'b0000110;
        'h4: control_field[6:0] <= 7'b1001100;
        'h5: control_field[6:0] <= 7'b0100100;
        'h6: control_field[6:0] <= 7'b0100000;
        'h7: control_field[6:0] <= 7'b0001111;
        'h8: control_field[6:0] <= 7'b0000000;
        'h9: control_field[6:0] <= 7'b0000100;
        'hA: control_field[6:0] <= 7'b0001000;
        'hB: control_field[6:0] <= 7'b1100000;
        'hC: control_field[6:0] <= 7'b0110001;
        'hD: control_field[6:0] <= 7'b1000010;
        'hE: control_field[6:0] <= 7'b0110000;
        'hF: control_field[6:0] <= 7'b0111000;
        endcase
    endfunction

    always_ff @ (posedge clk) begin
        clock_division_counter <= clock_division_counter + 1;
        if (clock_division_counter == 0) begin
            counter <= counter + 1;
            if (counter % 2 == 0) begin // output on even clock
                control_field[14:7] <= 8'hFF & ~(1 << (counter >> 1));
                output_digit(counter >> 1);
            end
            else begin // blank on odd clock
                control_field[14:7] <= 8'hFF;
            end
        end
    end
endmodule
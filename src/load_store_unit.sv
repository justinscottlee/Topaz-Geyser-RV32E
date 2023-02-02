`timescale 1ns / 1ps

module load_store_unit(
    input logic clk, we,
    input logic sign_extend,
    input logic [1:0] data_width,
    input integer addr,
    input integer read_bus
    );
    
    always_comb begin
        // prepare control signals and inputs for next memory operation
        case (addr) inside
        [32'h0000:32'h0FFF]: begin // CSR
        
        end
        [32'h1000:32'h4FFF]: begin // data TCM
            
        end
        [32'h5000:32'h8FFF]: begin // instruction TCM
        
        end
        endcase
    end
    
endmodule
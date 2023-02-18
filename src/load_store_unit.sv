`timescale 1ns / 1ps

module load_store_unit(
    input logic clk, we,
    input logic sign_extend,
    input logic [1:0] data_width,
    input integer addr_read,
    input integer addr_write,
    
    // CSR
    
    // DTCM (writes are truly executed during MEMEX stage, reads are truly executed during WB stage)
    output logic dtcm_we,
    input integer dtcm_read_data,
    
    // ITCM
    output logic itcm_we,
    input integer itcm_read_data,
    
    output integer read_data
    );
    
    always_comb begin
        dtcm_we = 0;
        case (addr_write) inside
        [32'h0000:32'h0FFF]: begin // CSR
        
        end
        [32'h1000:32'h4FFF]: begin // data TCM
            dtcm_we = we;
        end
        [32'h5000:32'h8FFF]: begin // instruction TCM
            itcm_we = we;
        end
        endcase
        
        case (addr_read) inside
        [32'h0000:32'h0FFF]: begin // CSR
            
        end
        [32'h1000:32'h4FFF]: begin // data TCM
            read_data = dtcm_read_data;
        end
        [32'h5000:32'h8FFF]: begin // instruction TCM
            read_data = itcm_read_data;
        end
        endcase
        
        if (sign_extend) begin
            case (data_width)
            `DATAWIDTH_BYTE: read_data = { {24{read_data[7]}}, read_data[7:0] };
            `DATAWIDTH_SHORT: read_data = { {16{read_data[15]}}, read_data[15:0] };
            default: read_data = read_data;
            endcase
        end
    end
endmodule
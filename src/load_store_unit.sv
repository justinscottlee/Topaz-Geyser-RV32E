`timescale 1ns / 1ps

module load_store_unit(
    input logic clk, we, rst,
    input logic sign_extend,
    input logic [1:0] data_width,
    input integer write_data,
    input integer addr_read,
    input integer addr_write,
    
    // CSR
    
    // SEVEN SEGMENT
    output integer seven_segment_value,
    
    // SPI
    inout logic [7:0] spi_csr,
    output logic spi_trigger,
    output byte spi_command,
    input byte spi_response,
    
    // DTCM (writes are truly executed during MEMEX stage, reads are truly executed during WB stage)
    output logic dtcm_we,
    input integer dtcm_read_data,
    
    // ITCM
    output logic itcm_we,
    input integer itcm_read_data,
    
    output integer read_data
    );
    
    reg [6:0] internal_spi_csr;
    assign spi_csr[7:1] = internal_spi_csr;
    
    always_ff @ (posedge clk) begin
        if (rst) begin
            internal_spi_csr <= 7'b0;
            internal_spi_csr[2] <= 1'b1; // SPI_CS
            seven_segment_value <= 32'd0;
        end
        
        spi_trigger <= 1'b0;
        
        if (we) begin
            case (addr_write) inside
            [32'h0000:32'hFFF]: begin // CSR
                if (addr_write == 32'h800) begin // SPI_COMMAND
                    spi_command <= write_data;
                    spi_trigger <= 1'b1;
                end
                
                else if (addr_write == 32'h801) begin // SPI_CSR
                    internal_spi_csr <= write_data[7:1];
                end
                
                else if (addr_write == 32'h804) begin // SEVEN SEGMENT
                    seven_segment_value <= write_data;
                end
            end
            endcase
        end
    end
    
    always_comb begin
        dtcm_we = 0;
        itcm_we = 0;
        
        read_data = 32'd0; // initialize to 0 to prevent latching
        
        case (addr_write) inside
        [32'h1000:32'h4FFF]: begin // data TCM
            dtcm_we = we;
        end
        [32'h5000:32'h8FFF]: begin // instruction TCM
            itcm_we = we;
        end
        endcase
        
        case (addr_read) inside
        [32'h0000:32'hFFF]: begin // CSR
            if (addr_read == 32'h800) begin
                read_data = spi_response;
            end
            else if (addr_read == 32'h801) begin
                read_data = spi_csr;
            end
            else if (addr_read == 32'h804) begin
                read_data = seven_segment_value;
            end
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
            endcase
        end else begin
            case (data_width)
            `DATAWIDTH_BYTE: read_data = { 24'b0, read_data[7:0] };
            `DATAWIDTH_SHORT: read_data = { 16'b0, read_data[15:0] };
            endcase
        end
    end
endmodule
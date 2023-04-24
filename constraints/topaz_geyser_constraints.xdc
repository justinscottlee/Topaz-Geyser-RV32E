set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

# 100MHZ CLK
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {sys_clk}]

# RESET
set_property -dict { PACKAGE_PIN C12 IOSTANDARD LVCMOS33 } [get_ports cpu_rst]; # active-low CPU_RST button

# 7-SEGMENT
set_property -dict { PACKAGE_PIN U13 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[14]];
set_property -dict { PACKAGE_PIN K2  IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[13]];
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[12]];
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[11]];
set_property -dict { PACKAGE_PIN J14 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[10]];
set_property -dict { PACKAGE_PIN T9  IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[9]];
set_property -dict { PACKAGE_PIN J18 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[8]];
set_property -dict { PACKAGE_PIN J17 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[7]];

set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[6]];
set_property -dict { PACKAGE_PIN R10 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[5]];
set_property -dict { PACKAGE_PIN K16 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[4]];
set_property -dict { PACKAGE_PIN K13 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[3]];
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[2]];
set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[1]];
set_property -dict { PACKAGE_PIN L18 IOSTANDARD LVCMOS33 } [get_ports seven_segment_control_field[0]];

# SWITCHES
set_property -dict { PACKAGE_PIN V10 IOSTANDARD LVCMOS33 } [get_ports switch_input[15]];
set_property -dict { PACKAGE_PIN U11 IOSTANDARD LVCMOS33 } [get_ports switch_input[14]];
set_property -dict { PACKAGE_PIN U12 IOSTANDARD LVCMOS33 } [get_ports switch_input[13]];
set_property -dict { PACKAGE_PIN H6 IOSTANDARD LVCMOS33 } [get_ports switch_input[12]];
set_property -dict { PACKAGE_PIN T13 IOSTANDARD LVCMOS33 } [get_ports switch_input[11]];
set_property -dict { PACKAGE_PIN R16 IOSTANDARD LVCMOS33 } [get_ports switch_input[10]];
set_property -dict { PACKAGE_PIN U8 IOSTANDARD LVCMOS33 } [get_ports switch_input[9]];
set_property -dict { PACKAGE_PIN T8 IOSTANDARD LVCMOS33 } [get_ports switch_input[8]];
set_property -dict { PACKAGE_PIN R13 IOSTANDARD LVCMOS33 } [get_ports switch_input[7]];
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports switch_input[6]];
set_property -dict { PACKAGE_PIN T18 IOSTANDARD LVCMOS33 } [get_ports switch_input[5]];
set_property -dict { PACKAGE_PIN R17 IOSTANDARD LVCMOS33 } [get_ports switch_input[4]];
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports switch_input[3]];
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports switch_input[2]];
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports switch_input[1]];
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports switch_input[0]];

# SPI
set_property -dict { PACKAGE_PIN H4  IOSTANDARD LVCMOS33 } [get_ports spi_sck];
set_output_delay -clock clk_SPI_clk_wiz_0 0 [get_ports spi_sck];
set_input_delay -clock clk_SPI_clk_wiz_0 0 [get_ports spi_sck];
set_property -dict { PACKAGE_PIN H1  IOSTANDARD LVCMOS33 } [get_ports spi_miso];
set_output_delay -clock clk_SPI_clk_wiz_0 0 [get_ports spi_miso];
set_input_delay -clock clk_SPI_clk_wiz_0 0 [get_ports spi_miso];
set_property -dict { PACKAGE_PIN G1  IOSTANDARD LVCMOS33 } [get_ports spi_mosi];
set_output_delay -clock clk_SPI_clk_wiz_0 0 [get_ports spi_mosi];
set_input_delay -clock clk_SPI_clk_wiz_0 0 [get_ports spi_mosi];
set_property -dict { PACKAGE_PIN G3  IOSTANDARD LVCMOS33 } [get_ports spi_cs];
set_output_delay -clock clk_SPI_clk_wiz_0 0 [get_ports spi_cs];
set_input_delay -clock clk_SPI_clk_wiz_0 0 [get_ports spi_cs];

# SRAM
set_property -dict { PACKAGE_PIN H2  IOSTANDARD LVCMOS33 } [get_ports ic_we];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_we];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_we];

set_property -dict { PACKAGE_PIN G4  IOSTANDARD LVCMOS33 } [get_ports ic_addr[16]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[16]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[16]];
set_property -dict { PACKAGE_PIN K1  IOSTANDARD LVCMOS33 } [get_ports ic_addr[15]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[15]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[15]];
set_property -dict { PACKAGE_PIN F6  IOSTANDARD LVCMOS33 } [get_ports ic_addr[14]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[14]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[14]];
set_property -dict { PACKAGE_PIN J2  IOSTANDARD LVCMOS33 } [get_ports ic_addr[13]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[13]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[13]];
set_property -dict { PACKAGE_PIN G6  IOSTANDARD LVCMOS33 } [get_ports ic_addr[12]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[12]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[12]];
set_property -dict { PACKAGE_PIN E7  IOSTANDARD LVCMOS33 } [get_ports ic_addr[11]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[11]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[11]];
set_property -dict { PACKAGE_PIN J3  IOSTANDARD LVCMOS33 } [get_ports ic_addr[10]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[10]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[10]];
set_property -dict { PACKAGE_PIN J4  IOSTANDARD LVCMOS33 } [get_ports ic_addr[9]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[9]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[9]];
set_property -dict { PACKAGE_PIN E6  IOSTANDARD LVCMOS33 } [get_ports ic_addr[8]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[8]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[8]];
set_property -dict { PACKAGE_PIN D14  IOSTANDARD LVCMOS33 } [get_ports ic_addr[7]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[7]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[7]];
set_property -dict { PACKAGE_PIN F16  IOSTANDARD LVCMOS33 } [get_ports ic_addr[6]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[6]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[6]];
set_property -dict { PACKAGE_PIN G16  IOSTANDARD LVCMOS33 } [get_ports ic_addr[5]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[5]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[5]];
set_property -dict { PACKAGE_PIN H14  IOSTANDARD LVCMOS33 } [get_ports ic_addr[4]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[4]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[4]];
set_property -dict { PACKAGE_PIN E16  IOSTANDARD LVCMOS33 } [get_ports ic_addr[3]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[3]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[3]];
set_property -dict { PACKAGE_PIN F13  IOSTANDARD LVCMOS33 } [get_ports ic_addr[2]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[2]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[2]];
set_property -dict { PACKAGE_PIN G13  IOSTANDARD LVCMOS33 } [get_ports ic_addr[1]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[1]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[1]];
set_property -dict { PACKAGE_PIN H16  IOSTANDARD LVCMOS33 } [get_ports ic_addr[0]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[0]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_addr[0]];

set_property -dict { PACKAGE_PIN C17  IOSTANDARD LVCMOS33 } [get_ports ic_io[7]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[7]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[7]];
set_property -dict { PACKAGE_PIN D18  IOSTANDARD LVCMOS33 } [get_ports ic_io[6]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[6]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[6]];
set_property -dict { PACKAGE_PIN E18  IOSTANDARD LVCMOS33 } [get_ports ic_io[5]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[5]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[5]];
set_property -dict { PACKAGE_PIN G17  IOSTANDARD LVCMOS33 } [get_ports ic_io[4]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[4]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[4]];
set_property -dict { PACKAGE_PIN D17  IOSTANDARD LVCMOS33 } [get_ports ic_io[3]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[3]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[3]];
set_property -dict { PACKAGE_PIN E17  IOSTANDARD LVCMOS33 } [get_ports ic_io[2]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[2]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[2]];
set_property -dict { PACKAGE_PIN F18  IOSTANDARD LVCMOS33 } [get_ports ic_io[1]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[1]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[1]];
set_property -dict { PACKAGE_PIN G18  IOSTANDARD LVCMOS33 } [get_ports ic_io[0]];
set_output_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[0]];
set_input_delay -clock clk_SRAM_clk_wiz_0 0 [get_ports ic_io[0]];
# 100MHZ SYS CLOCK
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk_in}];

# RESET BUTTON
set_property -dict { PACKAGE_PIN C12 IOSTANDARD LVCMOS33 } [get_ports {rst_in}];

# 7-SEGMENT DISPLAY
set_property -dict { PACKAGE_PIN J17 IOSTANDARD LVCMOS33 } [get_ports {outputreg[8]}];
set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33 } [get_ports {outputreg[7]}];
set_property -dict { PACKAGE_PIN R10 IOSTANDARD LVCMOS33 } [get_ports {outputreg[6]}];
set_property -dict { PACKAGE_PIN K16 IOSTANDARD LVCMOS33 } [get_ports {outputreg[5]}];
set_property -dict { PACKAGE_PIN K13 IOSTANDARD LVCMOS33 } [get_ports {outputreg[4]}];
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports {outputreg[3]}];
set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports {outputreg[2]}];
set_property -dict { PACKAGE_PIN L18 IOSTANDARD LVCMOS33 } [get_ports {outputreg[1]}];
set_property -dict { PACKAGE_PIN H15 IOSTANDARD LVCMOS33 } [get_ports {outputreg[0]}];
# 100MHZ SYS CLOCK
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {sys_clk}]

# RESET BUTTON
set_property -dict { PACKAGE_PIN C12 IOSTANDARD LVCMOS33 } [get_ports cpu_rst]; # active-low CPU_RST button

# 7-SEGMENT DISPLAY (everything is active-low)
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
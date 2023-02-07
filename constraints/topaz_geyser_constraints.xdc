# 100MHZ SYS CLOCK
#set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {sys_clk}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets sys_clk_IBUF]
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports sys_clk]

# RESET BUTTON
set_property -dict { PACKAGE_PIN C12 IOSTANDARD LVCMOS33 } [get_ports cpu_rst]

# 7-SEGMENT DISPLAY
set_property -dict { PACKAGE_PIN U13 IOSTANDARD LVCMOS33 } [get_ports outputreg[14]]
set_property -dict { PACKAGE_PIN K2  IOSTANDARD LVCMOS33 } [get_ports outputreg[13]]
set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports outputreg[12]]
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports outputreg[11]]
set_property -dict { PACKAGE_PIN J14 IOSTANDARD LVCMOS33 } [get_ports outputreg[10]]
set_property -dict { PACKAGE_PIN T9  IOSTANDARD LVCMOS33 } [get_ports outputreg[9]]
set_property -dict { PACKAGE_PIN J18 IOSTANDARD LVCMOS33 } [get_ports outputreg[8]]
set_property -dict { PACKAGE_PIN J17 IOSTANDARD LVCMOS33 } [get_ports outputreg[7]]

set_property -dict { PACKAGE_PIN T10 IOSTANDARD LVCMOS33 } [get_ports outputreg[6]]
set_property -dict { PACKAGE_PIN R10 IOSTANDARD LVCMOS33 } [get_ports outputreg[5]]
set_property -dict { PACKAGE_PIN K16 IOSTANDARD LVCMOS33 } [get_ports outputreg[4]]
set_property -dict { PACKAGE_PIN K13 IOSTANDARD LVCMOS33 } [get_ports outputreg[3]]
set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports outputreg[2]]
set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports outputreg[1]]
set_property -dict { PACKAGE_PIN L18 IOSTANDARD LVCMOS33 } [get_ports outputreg[0]]
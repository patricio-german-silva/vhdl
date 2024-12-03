set_property IOSTANDARD LVCMOS33 [get_ports {poUaRxData[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {poUaRxData[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {poUaRxData[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {poUaRxData[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {poUaRxData[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {poUaRxData[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {poUaRxData[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {poUaRxData[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports piUaRxClk]
set_property IOSTANDARD LVCMOS33 [get_ports piUaRxEna]
set_property IOSTANDARD LVCMOS33 [get_ports piUaRxRst]
set_property IOSTANDARD LVCMOS33 [get_ports piUaRxRx]
set_property IOSTANDARD LVCMOS33 [get_ports poUaRxC]
set_property PACKAGE_PIN E3 [get_ports piUaRxClk]
set_property PACKAGE_PIN A8 [get_ports piUaRxEna]
set_property PACKAGE_PIN C11 [get_ports piUaRxRst]
set_property PACKAGE_PIN A9 [get_ports piUaRxRx]
set_property PACKAGE_PIN H5 [get_ports {poUaRxData[7]}]
set_property PACKAGE_PIN J5 [get_ports {poUaRxData[6]}]
set_property PACKAGE_PIN T9 [get_ports {poUaRxData[5]}]
set_property PACKAGE_PIN T10 [get_ports {poUaRxData[4]}]
set_property PACKAGE_PIN E1 [get_ports {poUaRxData[3]}]
set_property PACKAGE_PIN G4 [get_ports {poUaRxData[2]}]
set_property PACKAGE_PIN H4 [get_ports {poUaRxData[1]}]
set_property PACKAGE_PIN K2 [get_ports {poUaRxData[0]}]

set_property PACKAGE_PIN U11 [get_ports poUaRxC]
create_clock -period 10.000 -name clk [get_ports piUaRxClk]

set_property PACKAGE_PIN N17 [get_ports poUaRxBR]
set_property PACKAGE_PIN P18 [get_ports poUaRxRx]

set_property IOSTANDARD LVCMOS33 [get_ports poUaRxBR]
set_property IOSTANDARD LVCMOS33 [get_ports poUaRxRx]

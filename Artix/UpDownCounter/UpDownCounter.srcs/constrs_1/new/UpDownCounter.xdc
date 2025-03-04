set_property IOSTANDARD LVCMOS33 [get_ports piClk]
set_property IOSTANDARD LVCMOS33 [get_ports piEna]
set_property IOSTANDARD LVCMOS33 [get_ports piRst]
set_property IOSTANDARD LVCMOS33 [get_ports poX]
set_property IOSTANDARD LVCMOS33 [get_ports piUpDown]
set_property PACKAGE_PIN E3 [get_ports piClk]
set_property PACKAGE_PIN D9 [get_ports piEna]
set_property PACKAGE_PIN C9 [get_ports piRst]
set_property PACKAGE_PIN E1 [get_ports poX]
set_property PACKAGE_PIN E2 [get_ports piUpDown]


create_clock -period 10.000 -name clk [get_ports piClk]


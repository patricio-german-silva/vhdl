create_clock -period 10.000 -name clk [get_ports CLK]

set_property PACKAGE_PIN E3 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]

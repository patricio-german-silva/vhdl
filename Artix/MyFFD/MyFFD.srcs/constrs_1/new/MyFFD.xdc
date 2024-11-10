set_property IOSTANDARD LVCMOS33 [get_ports piClk]

set_property PACKAGE_PIN E3 [get_ports piClk]

create_clock -name clk -period 10 [get_ports piClk]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
set_property PACKAGE_PIN L1 [get_ports {LED[15]}]
set_property PACKAGE_PIN P1 [get_ports {LED[14]}]
set_property PACKAGE_PIN N3 [get_ports {LED[13]}]
set_property PACKAGE_PIN P3 [get_ports {LED[12]}]
set_property PACKAGE_PIN U3 [get_ports {LED[11]}]
set_property PACKAGE_PIN W3 [get_ports {LED[10]}]
set_property PACKAGE_PIN V3 [get_ports {LED[9]}]
set_property PACKAGE_PIN V13 [get_ports {LED[8]}]
set_property PACKAGE_PIN V14 [get_ports {LED[7]}]
set_property PACKAGE_PIN U14 [get_ports {LED[6]}]
set_property PACKAGE_PIN U15 [get_ports {LED[5]}]
set_property PACKAGE_PIN W18 [get_ports {LED[4]}]
set_property PACKAGE_PIN V19 [get_ports {LED[3]}]
set_property PACKAGE_PIN U19 [get_ports {LED[2]}]
set_property PACKAGE_PIN E19 [get_ports {LED[1]}]
set_property PACKAGE_PIN U16 [get_ports {LED[0]}]

set_property PACKAGE_PIN W4 [get_ports {DIGIT[3]}]
set_property PACKAGE_PIN V4 [get_ports {DIGIT[2]}]
set_property PACKAGE_PIN U4 [get_ports {DIGIT[1]}]
set_property PACKAGE_PIN U2 [get_ports {DIGIT[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIGIT[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIGIT[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIGIT[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DIGIT[0]}]
set_property PACKAGE_PIN W7 [get_ports {DISPLAY[6]}]
set_property PACKAGE_PIN W6 [get_ports {DISPLAY[5]}]
set_property PACKAGE_PIN U8 [get_ports {DISPLAY[4]}]
set_property PACKAGE_PIN V8 [get_ports {DISPLAY[3]}]
set_property PACKAGE_PIN U5 [get_ports {DISPLAY[2]}]
set_property PACKAGE_PIN V5 [get_ports {DISPLAY[1]}]
set_property PACKAGE_PIN U7 [get_ports {DISPLAY[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DISPLAY[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports start]
set_property PACKAGE_PIN T18 [get_ports start]



set_property PACKAGE_PIN W19 [get_ports cheat]
set_property IOSTANDARD LVCMOS33 [get_ports cheat]

set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN U18 [get_ports rst]

#USB HID (PS/2)
set_property PACKAGE_PIN C17 [get_ports PS2_CLK]						
	set_property IOSTANDARD LVCMOS33 [get_ports PS2_CLK]
	set_property PULLUP true [get_ports PS2_CLK]
set_property PACKAGE_PIN B17 [get_ports PS2_DATA]					
	set_property IOSTANDARD LVCMOS33 [get_ports PS2_DATA]	
	set_property PULLUP true [get_ports PS2_DATA]
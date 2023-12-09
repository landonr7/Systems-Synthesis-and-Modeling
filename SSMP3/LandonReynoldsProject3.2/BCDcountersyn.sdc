###################################################################

# Created by write_sdc on Sun Oct  8 22:51:03 2023

###################################################################
set sdc_version 1.8

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock [get_ports clk]  -name CLK_0  -period 20  -waveform {0 15}

###################################################################

# Created by write_sdc on Sun Oct  8 19:33:00 2023

###################################################################
set sdc_version 1.8

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
create_clock -name virt_clk  -period 20  -waveform {0 10}

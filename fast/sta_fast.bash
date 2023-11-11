read_liberty stdcells_fast.lib
read_verilog synth.v
link_design fft
create_clock -name CLK -period 100 {clk}
set_power_activity -input -activity 0.5
set_power_activity -global -activity 0.5

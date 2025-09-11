V1 VP_VCC GND DC 12V 
V2 VN_VCC GND DC -12V

V3 INPUT GND DC 1 SIN(0 1V 1000)

.control
  * Time domain analysis - show 5 cycles of 1kHz signal
  tran 10u 5m
  
  * Save output as SVG
  set hcopydevtype = svg
  
  * Time domain plot of input and output
  hardcopy simulation/test/output/levelshifter.svg v(INPUT) v(VOFFSET) v(PROBE) title "Level Shifter - Time Domain Response" xlabel "Time (s)" ylabel "Voltage (V)"
.endc

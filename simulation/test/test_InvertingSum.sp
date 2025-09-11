* Establish ground as a 0v node
V0 GND DC 0V

* Power rails +/- 12V
V1 VP_VCC GND DC 12V 
V2 VN_VCC GND DC -12V

* Input source
V3 INPUT_SIGNAL GND DC 1 SIN(0 1V 1000)
V4 INPUT_OFFSET GND DC 3

.control
  * Time domain analysis - show 5 cycles of 1kHz signal
  tran 10u 5m
  
  * Save output as SVG
  set hcopydevtype = svg
  
  * Time domain plot of input and output
  hardcopy simulation/test/output/inverting_sum.svg v(INPUT_SIGNAL) v(INPUT_OFFSET) v(INVERTING_SUM) title "Inverting Sum - Time Domain Response" xlabel "Time (s)" ylabel "Voltage (V)"
.endc

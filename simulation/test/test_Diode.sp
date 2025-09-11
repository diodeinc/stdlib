# Test Diode SPICE model - shows forward voltage drop and rectification
# Sine wave input to demonstrate diode rectification behavior
V1 VIN_VCC GND SIN(0 2V 1kHz)

.control
  # Transient analysis to show rectification
  tran 10u 5m
  
  # Save the output to SVG
  set hcopydevtype = svg
  hardcopy simulation/test/output/diode.svg v(VIN_VCC) v(PROBE) title "Diode Rectification" xlabel "Time (s)" ylabel "Voltage (V)"
.endc

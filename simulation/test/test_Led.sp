# Test LED SPICE model - shows different forward voltages for different colors
V1 VCC GND DC 5V

.control
  # DC operating point analysis
  op
  
  # Print currents and voltages to verify LED behavior
  print v(VCC) v(PROBE_RED) v(PROBE_GREEN) v(PROBE_BLUE)
  print i(VLED1) i(VLED2) i(VLED3)
  
  # DC sweep to show LED turn-on characteristics
  dc V1 0 5 0.05
  
  # Save the output to SVG
  set hcopydevtype = svg
  hardcopy simulation/test/output/led.svg v(PROBE_RED) v(PROBE_GREEN) v(PROBE_BLUE) title "LED Forward Voltage Comparison" xlabel "Supply Voltage (V)" ylabel "Cathode Voltage (V)"
.endc

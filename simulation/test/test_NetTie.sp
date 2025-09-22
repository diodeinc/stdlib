# Test NetTie SPICE model - should show near-zero voltage drop across net tie
V1 VCC GND DC 5V

.control
  # DC operating point analysis
  op
  
  # Print voltages to verify net tie behavior
  print v(VCC) v(NET1) v(NET2) v(PROBE)
  
  # DC sweep to show voltage division
  dc V1 0 5 0.1
  
  # Save the output to SVG
  set hcopydevtype = svg
  hardcopy simulation/test/output/nettie.svg v(NET1) v(NET2) v(PROBE) title "NetTie Test - Voltage Division" xlabel "Input Voltage (V)" ylabel "Node Voltages (V)"
.endc

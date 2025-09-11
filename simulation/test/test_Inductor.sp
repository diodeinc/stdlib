# Switching voltage source to demonstrate inductor behavior
# Square wave that switches between 0V and 5V to show exponential current response
V VCC GND PULSE(0 5V 0 10n 10n 1u 2u)


.control
  # Transient analysis - show several switching cycles
  # Time constant τ = L/R = 1mH/1kΩ = 1µs
  # Show ~10 time constants to see full exponential behavior
  tran 1u 10u
  
  # Save the output to SVG
  set hcopydevtype = svg
  hardcopy simulation/test/output/inductor.svg v(VCC) v(PROBE) title "Inductor Response to Switching Voltage" xlabel "Time (s)" ylabel "Voltage (V)"
.endc

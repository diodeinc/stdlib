# Test Crystal SPICE model - frequency response analysis
# AC source for frequency sweep
V1 VIN GND AC 1

.control
  # AC frequency sweep around the 16MHz resonance
  # Sweep from 10MHz to 20MHz to see resonance peaks
  ac dec 100 10Meg 20Meg
  
  # Save the output to SVG - magnitude plot
  set hcopydevtype = svg
  hardcopy simulation/test/output/crystal_magnitude.svg db(v(XIN)) db(v(XOUT)) title "Crystal Frequency Response - Magnitude" xlabel "Frequency (Hz)" ylabel "Magnitude (dB)"
  
  # Phase plot
  hardcopy simulation/test/output/crystal_phase.svg phase(v(XIN)) phase(v(XOUT)) title "Crystal Frequency Response - Phase" xlabel "Frequency (Hz)" ylabel "Phase (degrees)"
.endc

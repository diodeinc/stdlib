* Ground node

* Positive and negative rails
V1 VP GND DC 12V 
V2 VN GND DC -12V

* Input stimulus for AC analysis. 0V - 1.8V (centered at 0.9V, 0.9V peak AC)
V3 INPUT GND DC 0.9 AC 0.9

.control
  * AC analysis from 10Hz to 1MHz with 200 points per decade
  ac dec 200 10 1meg
  
  * Save output as SVG
  set hcopydevtype = svg
  
  * AC magnitude response plot
  hardcopy simulation/test/output/twintnotch_magnitude.svg vdb(PROBE) title "Twin-T Notch AC Response" xlabel Frequency ylabel "Magnitude (dB)"
  
  * AC phase response plot
  hardcopy simulation/test/output/twintnotch_phase.svg vp(PROBE) title "Twin-T Notch Phase Response" xlabel Frequency ylabel "Phase (degrees)"
.endc


* Ground node

* Positive and negative rails
V1 VP GND DC 12V 
V2 VN GND DC -12V

* Input stimulus for AC analysis. 0V - 1.8V (centered at 0.9V, 0.9V peak AC)
V3 INPUT GND DC 0.9 AC 0.9

.control
  * AC analysis from 1Hz to 10kHz with 10 points per decade
  ac dec 200 1 10g
  
  * Save output as SVG
  set hcopydevtype = svg
  
  * AC magnitude response plot
  hardcopy simulation/test/output/sallenkey_magnitude.svg vdb(PROBE) title "Sallen Key AC Response" xlabel Frequency ylabel "Magnitude (dB)"
  
  * AC phase response plot
  hardcopy simulation/test/output/sallenkey_phase.svg vp(PROBE) title "Sallen Key Phase Response" xlabel Frequency ylabel "Phase (degrees)"
.endc

V1 VCC GND AC 1V SIN(0 5V 1kHz)

.control
  * Time domain analysis
  tran 0.001m 5m
  
  * Frequency domain analysis
  ac dec 100 1 100k
  
  * Save output as SVG
  set hcopydevtype = svg
  set 
  
  * Amplitude response plot  
  hardcopy simulation/test/output/RC_amplitude.svg vdb(PROBE) title "RC Filter - Amplitude Response" ylabel dB
  
  * Phase response plot
  hardcopy simulation/test/output/RC_phase.svg vp(PROBE) title "RC Filter - Phase Response" ylabel rad 
.endc

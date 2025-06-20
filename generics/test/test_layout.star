"""Comprehensive test for all generic components."""

# Load all generic components
load("..", "Capacitor", "Led", "Resistor")
load("../../properties.star", "Layout")

Capacitor(name = "C1", value = "100nF", voltage = "16V", dielectric = "X7R", package = "0603", P1 = Net("P1"), P2 = Net("P2"))
Capacitor(name = "C2", value = "100nF", package = "0201", mpn = "MPN_C2", P1 = Net("P1"), P2 = Net("P2"))
Resistor(name = "R1", value = "100kOhm", package = "0603", P1 = Net("P1"), P2 = Net("P2"))
Resistor(name = "R2", value = "1kOhm", package = "0201", mpn = "MPN_R2", P1 = Net("P1"), P2 = Net("P2"))
Led(name = "D1", color = "red", package = "0603", A = Net("LED_A"), K = Net("LED_K"))
Led(name = "D2", color = "blue", package = "0805", forward_voltage = "3.3V", forward_current = "20mA", A = Net("LED_A2"), K = Net("LED_K2"))
Led(name = "D3", color = "green", package = "0402", mpn = "MPN_LED3", A = Net("LED_A3"), K = Net("LED_K3"))

Layout(
    name = "C1",
    path = "build/preview",
)

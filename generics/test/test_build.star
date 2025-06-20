"""Comprehensive test for all generic components."""

# Load all generic components
load(
    "..",
    "Bjt",
    "Capacitor",
    "Crystal",
    "FerriteBead",
    "Inductor",
    "Led",
    "Mosfet",
    "MountingHole",
    "NetTie",
    "Resistor",
    "SolderJumper",
    "TestPoint",
)
load("../../interfaces.star", "Ground")

# Create test nets
VCC_3V3 = Net("VCC_3V3")
VCC_5V = Net("VCC_5V")
GND = Ground("GND")
SIGNAL_A = Net("SIGNAL_A")
SIGNAL_B = Net("SIGNAL_B")
SIGNAL_C = Net("SIGNAL_C")
SIGNAL_D = Net("SIGNAL_D")
XTAL_IN = Net("XTAL_IN")
XTAL_OUT = Net("XTAL_OUT")
BASE = Net("BASE")
COLLECTOR = Net("COLLECTOR")
EMITTER = Net("EMITTER")
GATE = Net("GATE")
DRAIN = Net("DRAIN")
SOURCE = Net("SOURCE")

# Test Resistor - basic passive component
Resistor(
    name = "R1",
    value = "1kOhm",
    package = "0402",
    P1 = VCC_3V3,
    P2 = SIGNAL_A,
)

Resistor(
    name = "R2",
    value = "10kOhm",
    package = "0603",
    voltage = "50V",
    P1 = SIGNAL_A,
    P2 = GND.NET,
)

# Test Capacitor - with different dielectrics
Capacitor(
    name = "C1",
    value = "100nF",
    package = "0402",
    dielectric = "X7R",
    voltage = "16V",
    P1 = VCC_3V3,
    P2 = GND.NET,
)

Capacitor(
    name = "C2",
    value = "10uF",
    package = "0805",
    dielectric = "X5R",
    voltage = "25V",
    P1 = VCC_5V,
    P2 = GND.NET,
)

# Test LED - different colors and packages
Led(
    name = "LED1",
    color = "red",
    package = "0603",
    forward_voltage = "2.0V",
    forward_current = "20mA",
    A = SIGNAL_A,
    K = GND.NET,
)

Led(
    name = "LED2",
    color = "green",
    package = "0805",
    A = SIGNAL_B,
    K = GND.NET,
)

Led(
    name = "LED3",
    color = "blue",
    package = "1206",
    A = SIGNAL_C,
    K = GND.NET,
)

# Test Inductor
Inductor(name = "L1", value = "10uH", package = "0603", current = "1A", P1 = VCC_3V3, P2 = SIGNAL_B)

Inductor(name = "L2", value = "100uH", package = "0805", P1 = SIGNAL_B, P2 = SIGNAL_C)

# Test Ferrite Bead
FerriteBead(name = "FB1", resistance = "100Ohm", frequency = "100MHz", package = "0603", P1 = VCC_5V, P2 = VCC_3V3)

# Test Crystal
Crystal(
    name = "XTAL1",
    frequency = "8MHz",
    load_capacitance = "18pF",
    package = "5032_4Pin",
    XIN = XTAL_IN,
    XOUT = XTAL_OUT,
    GND = GND.NET,
)

Crystal(
    name = "XTAL2",
    frequency = "32.768kHz",
    load_capacitance = "12.5pF",
    package = "3225_4Pin",
    XIN = SIGNAL_C,
    XOUT = SIGNAL_D,
    GND = GND.NET,
)

# Test BJT - both NPN and PNP
Bjt(
    name = "Q1",
    bjt_type = "NPN",
    package = "SOT-23-3",
    hfe = 100.0,
    vceo = "30V",
    ic_max = "100mA",
    COLLECTOR = COLLECTOR,
    BASE = BASE,
    EMITTER = EMITTER,
)

Bjt(name = "Q2", bjt_type = "PNP", package = "SOT-23-3", COLLECTOR = SIGNAL_A, BASE = SIGNAL_B, EMITTER = VCC_3V3)

# Test MOSFET - both N-channel and P-channel
Mosfet(name = "M1", channel = "N", package = "SOT-23-3", vds_max = "30V", id_max = "1A", GATE = GATE, DRAIN = DRAIN, SOURCE = SOURCE)

Mosfet(name = "M2", channel = "P", package = "SOT-23-3", GATE = SIGNAL_C, DRAIN = SIGNAL_D, SOURCE = VCC_3V3)

# Test TestPoint
TestPoint(name = "TP1", variant = "Pad_D1.5mm", P1 = VCC_3V3)

TestPoint(name = "TP2", variant = "Pad_D2.0mm", P1 = SIGNAL_A)

TestPoint(name = "TP3", variant = "Pad_D1.0mm", P1 = GND.NET)

# Test MountingHole
MountingHole(name = "MH1", diameter = "M3", standard = "DIN965", plating = "TopBottom")

MountingHole(name = "MH2", diameter = "M2.5", standard = "DIN965", plating = "TopBottom")

# Test NetTie
NetTie(name = "NT1", pad_size = "0.5mm", pin_count = 2, P1 = SIGNAL_A, P2 = SIGNAL_B)

# Test SolderJumper - different styles
SolderJumper(name = "SJ1", style = "Open", variant = "Pad", pitch = "P1.3mm", P1 = SIGNAL_C, P2 = SIGNAL_D)

SolderJumper(name = "SJ2", style = "Bridged", variant = "Pad", pitch = "P1.3mm", P1 = VCC_3V3, P2 = VCC_5V)

SolderJumper(
    name = "SJ3",
    pin_count = 3,
    style = "Bridged123",
    variant = "Pad",
    pitch = "P1.3mm",
    P1 = SIGNAL_A,
    P2 = SIGNAL_B,
    P3 = SIGNAL_C,
)

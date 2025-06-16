load("../config.star", "config_properties", "config_unit")
load("../units.star", "Resistance", "Voltage")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

Package = enum("0201", "0402", "0603", "0805", "1206", "1210", "2010", "2512")
Mount = enum("SMD")

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Required
package = config("package", Package, convert = Package)
value = config_unit("value", Resistance)

# Optional
mount = config("mount", Mount, default = Mount("SMD"), optional = True)
voltage = config_unit("voltage", Voltage, optional = True)

# Properties – combined and normalized
properties = config_properties({
    "mount": mount,
    "package": package,
    "resistance": value,
    "voltage": voltage,
})

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

P1 = io("P1", Net)
P2 = io("P2", Net)

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------

def _footprint(package: Package) -> str:
    kicad_footprints = {
        Package("0201"): "Resistor_SMD:R_0201_0603Metric",
        Package("0402"): "Resistor_SMD:R_0402_1005Metric",
        Package("0603"): "Resistor_SMD:R_0603_1608Metric",
        Package("0805"): "Resistor_SMD:R_0805_2012Metric",
        Package("1206"): "Resistor_SMD:R_1206_3216Metric",
        Package("1210"): "Resistor_SMD:R_1210_3225Metric",
        Package("2010"): "Resistor_SMD:R_2010_5025Metric",
        Package("2512"): "Resistor_SMD:R_2512_6332Metric",
    }

    if package not in kicad_footprints:
        error("Invalid package: " + str(package))

    return kicad_footprints[package]

# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

Component(
    name = "R",
    type = "resistor",
    symbol = "Device:R",
    footprint = _footprint(package),
    prefix = "R",
    pin_defs = {
        "P1": "1",
        "P2": "2",
    },
    pins = {
        "P1": P1,
        "P2": P2,
    },
    properties = properties,
)

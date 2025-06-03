load("../config.star", "config_unit")
load("../interfaces.star", "Ground")
load("../properties.star", "Properties")
load("../units.star", "Capacitance", "Frequency")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

Mount = enum("SMD")
Package = enum(
    "2012_2Pin",
    "3215_2Pin",
    "5032_2Pin",
    "5032_4Pin",
    "7050_2Pin",
    "7050_4Pin",
    "3225_4Pin",
    "2520_4Pin",
    "2016_4Pin",
    "1210_4Pin",
    "0603_2Pin",
    "0603_4Pin",
)

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Required
package = config("package", Package, convert=Package)
frequency = config_unit("frequency", Frequency)

# Optional
mount = config("mount", Mount, default=Mount("SMD"), optional=True)
load_capacitance = config_unit("load_capacitance", Capacitance, optional=True)

# Properties
properties = config("properties", dict, optional=True)

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

# For 2-pin crystals
XIN = io("XIN", Net)
XOUT = io("XOUT", Net)

# Additional pins for 4-pin crystals
GND = io("GND", Ground, optional=True)

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------


def _footprint(package: Package) -> str:
    _footprints = {
        Package("2012_2Pin"): "Crystal:Crystal_SMD_2012-2Pin_2.0x1.2mm",
        Package("3215_2Pin"): "Crystal:Crystal_SMD_3215-2Pin_3.2x1.5mm",
        Package("5032_2Pin"): "Crystal:Crystal_SMD_5032-2Pin_5.0x3.2mm",
        Package("5032_4Pin"): "Crystal:Crystal_SMD_5032-4Pin_5.0x3.2mm",
        Package("7050_2Pin"): "Crystal:Crystal_SMD_7050-2Pin_7.0x5.0mm",
        Package("7050_4Pin"): "Crystal:Crystal_SMD_7050-4Pin_7.0x5.0mm",
        Package("3225_4Pin"): "Crystal:Crystal_SMD_3225-4Pin_3.2x2.5mm",
        Package("2520_4Pin"): "Crystal:Crystal_SMD_2520-4Pin_2.5x2.0mm",
        Package("2016_4Pin"): "Crystal:Crystal_SMD_2016-4Pin_2.0x1.6mm",
        Package("1210_4Pin"): "Crystal:Crystal_SMD_1210-4Pin_1.2x1.0mm",
        Package("0603_2Pin"): "Crystal:Crystal_SMD_0603-2Pin_6.0x3.5mm",
        Package("0603_4Pin"): "Crystal:Crystal_SMD_0603-4Pin_6.0x3.5mm",
    }

    return _footprints[package]


def _pin_defs_and_pins(package: Package, XIN: Net, XOUT: Net, GND: Ground | None):
    if "4Pin" in str(package):
        if not GND:
            error("GND is required for 4-pin crystals")
        pins = {
            "XIN": XIN,
            "GND1": GND,
            "XOUT": XOUT,
            "GND2": GND,
        }
        pin_defs = {
            "XIN": "1",
            "GND1": "2",
            "XOUT": "3",
            "GND2": "4",
        }
    else:
        pins = {
            "XIN": XIN,
            "XOUT": XOUT,
        }
        pin_defs = {
            "XIN": "1",
            "XOUT": "2",
        }
    return pins, pin_defs


# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

pins, pin_defs = _pin_defs_and_pins(package, XIN, XOUT, GND)

Component(
    name="CRYSTAL",
    type="crystal",
    prefix="Y",
    footprint=_footprint(package),
    pins=pins,
    pin_defs=pin_defs,
    properties=Properties(
        properties,
        {
            "frequency": frequency,
            "load_capacitance": load_capacitance,
            "package": package,
            "mount": mount,
        },
    ),
)

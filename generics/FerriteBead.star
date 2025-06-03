load("../units.star", "Resistance", "Current", "Frequency")
load("../config.star", "config_unit")
load("../properties.star", "Properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

Package = enum("0201", "0402", "0603", "0805", "1206", "1210", "2010", "2512")
Mount = enum("SMD")

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Required
package = config("package", Package, convert=Package)
resistance = config_unit("resistance", Resistance)
frequency = config_unit("frequency", Frequency)

# Optional
mount = config("mount", Mount, default=Mount("SMD"), optional=True)
current = config_unit("current", Current, optional=True)

# Properties
properties = config("properties", dict, optional=True)

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

P1 = io("P1", Net)
P2 = io("P2", Net)

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------


def _footprint(package: Package) -> str:
    """Returns the resistor SMD footprint for the ferrite bead based on the package."""
    resistor_footprints = {
        Package("0201"): "Resistor_SMD:R_0201_0603Metric",
        Package("0402"): "Resistor_SMD:R_0402_1005Metric",
        Package("0603"): "Resistor_SMD:R_0603_1608Metric",
        Package("0805"): "Resistor_SMD:R_0805_2012Metric",
        Package("1206"): "Resistor_SMD:R_1206_3216Metric",
        Package("1210"): "Resistor_SMD:R_1210_3225Metric",
        Package("2010"): "Resistor_SMD:R_2010_5025Metric",
        Package("2512"): "Resistor_SMD:R_2512_6332Metric",
    }

    if package not in resistor_footprints:
        error("Invalid package: " + str(package))

    return resistor_footprints[package]


def _value(resistance: Resistance, frequency: Frequency, package: Package) -> str:
    """Returns the appropriate ferrite bead value based on the resistance and frequency."""
    r = resistance.__str__(resistance)
    f = frequency.__str__(frequency)
    p = package.value
    return f"Ferrite {r} @{f} {p}"


# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

Component(
    name="FB",
    type="ferrite_bead",
    footprint=_footprint(package),
    prefix="FB",
    pin_defs={
        "P1": "1",
        "P2": "2",
    },
    pins={
        "P1": P1,
        "P2": P2,
    },
    properties=Properties(
        properties,
        {
            "value": _value(resistance, frequency, package),
            "package": package,
            "current": current,
        },
    ),
)

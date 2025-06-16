load("../config.star", "config_properties", "config_unit")
load("../units.star", "Current", "Inductance")

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
value = config_unit("value", Inductance)

# Optional
mount = config("mount", Mount, default = Mount("SMD"), optional = True)
current = config_unit("current", Current, optional = True)

# Properties – combined and normalized
properties = config_properties({
    "mount": mount,
    "value": value,
    "package": package,
    "inductance": value,
    "current": current,
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
    """Returns the appropriate inductor footprint based on the package."""
    footprints = {
        Package("0201"): "Inductor_SMD:L_0201_0603Metric",
        Package("0402"): "Inductor_SMD:L_0402_1005Metric",
        Package("0603"): "Inductor_SMD:L_0603_1608Metric",
        Package("0805"): "Inductor_SMD:L_0805_2012Metric",
        Package("1206"): "Inductor_SMD:L_1206_3216Metric",
        Package("1210"): "Inductor_SMD:L_1210_3225Metric",
        Package("2010"): "Inductor_SMD:L_2010_5025Metric",
        Package("2512"): "Inductor_SMD:L_2512_7032Metric",
    }

    if package not in footprints:
        error("Invalid package: " + str(package))

    return footprints[package]

# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

Component(
    name = "INDUCTOR",
    type = "inductor",
    footprint = _footprint(package),
    prefix = "L",
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

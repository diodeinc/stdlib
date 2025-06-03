load("../config.star", "config_unit")
load("../properties.star", "Properties")
load("../units.star", "Capacitance", "Resistance", "Temperature", "Voltage")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

Package = enum("0201", "0402", "0603", "0805", "1206", "1210", "2010", "2512")
Mount = enum("SMD")
Dielectric = enum("C0G", "NP0", "X5R", "X7R", "X7S", "X7T", "Y5V", "Z5U")

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Required
package = config("package", Package, convert=Package)
value = config_unit("value", Capacitance)

# Optional
mount = config("mount", Mount, default=Mount("SMD"), optional=True)
voltage = config_unit("voltage", Voltage, optional=True)
dielectric = config("dielectric", Dielectric, optional=True)
esr = config_unit("esr", Resistance, optional=True)
t_max = config_unit("t_max", Temperature, optional=True)
t_min = config_unit("t_min", Temperature, optional=True)

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


def _footprint(mount: Mount, package: Package) -> str:
    kicad_footprints = {
        (Mount("SMD"), Package("0201")): "Capacitor_SMD:C_0201_0603Metric",
        (Mount("SMD"), Package("0402")): "Capacitor_SMD:C_0402_1005Metric",
        (Mount("SMD"), Package("0603")): "Capacitor_SMD:C_0603_1608Metric",
        (Mount("SMD"), Package("0805")): "Capacitor_SMD:C_0805_2012Metric",
        (Mount("SMD"), Package("1206")): "Capacitor_SMD:C_1206_3216Metric",
        (Mount("SMD"), Package("1210")): "Capacitor_SMD:C_1210_3225Metric",
        (Mount("SMD"), Package("2010")): "Capacitor_SMD:C_2010_5025Metric",
        (Mount("SMD"), Package("2512")): "Capacitor_SMD:C_2512_7032Metric",
    }

    if (mount, package) not in kicad_footprints:
        error("Invalid footprint: " + str(mount) + " " + str(package))

    return kicad_footprints[(mount, package)]


# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

Component(
    name="CAPACITOR",
    type="capacitor",
    footprint=_footprint(mount, package),
    prefix="C",
    pins={
        "P1": P1,
        "P2": P2,
    },
    pin_defs={
        "P1": "1",
        "P2": "2",
    },
    properties=Properties(
        properties,
        {
            "value": value,
            "voltage": voltage,
            "dielectric": dielectric,
            "package": package,
            "mount": mount,
            "esr": esr,
        },
    ),
)

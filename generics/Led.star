load("../units.star", "Voltage", "Current")
load("../config.star", "config_unit", "config_properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

Mount = enum("SMD")
Package = enum("0201", "0402", "0603", "0805", "1206", "1210", "2010", "2512", "1210_Reverse", "1812")
Color = enum("red", "green", "blue", "yellow", "white", "amber", "orange", "pink", "uv", "rgb", "other")

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Required
package = config("package", Package, convert=Package)
color = config("color", Color, convert=Color)

# Optional
mount = config("mount", Mount, default=Mount("SMD"), optional=True)
forward_voltage = config_unit("forward_voltage", Voltage, optional=True)
forward_current = config_unit("forward_current", Current, optional=True)

# Properties – combined and normalized
properties = config_properties({
    "mount": mount,
    "package": package,
    "color": color,
    "forward_voltage": forward_voltage,
    "forward_current": forward_current,
})

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

A = io("A", Net)
K = io("K", Net)

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------


def _footprint(package: Package) -> str:
    kicad_footprints = {
        Package("0201"): "LED_SMD:LED_0201_0603Metric",
        Package("0402"): "LED_SMD:LED_0402_1005Metric",
        Package("0603"): "LED_SMD:LED_0603_1608Metric",
        Package("0805"): "LED_SMD:LED_0805_2012Metric",
        Package("1206"): "LED_SMD:LED_1206_3216Metric",
        Package("1210"): "LED_SMD:LED_1210_3225Metric",
        Package("2010"): "LED_SMD:LED_2010_5025Metric",
        Package("2512"): "LED_SMD:LED_2512_6332Metric",
        Package("1210_Reverse"): "LED_SMD:LED_1206_3216Metric_ReverseMount_Hole1.8x2.4mm",
        Package("1812"): "LED_SMD:LED_1812_4532Metric",
    }
    if package not in kicad_footprints:
        error("Invalid package: " + str(package))
    return kicad_footprints[package]


def _value(color: Color, package: Package) -> str:
    color = str(color.value).title()
    package = str(package.value)
    return f"LED {package} {color}"


# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

Component(
    name="LED",
    type="led",
    footprint=_footprint(package),
    prefix="D",
    symbol="Device:LED",
    pin_defs={
        "K": "1",
        "A": "2",
    },
    pins={
        "K": K,
        "A": A,
    },
    properties=properties,
)

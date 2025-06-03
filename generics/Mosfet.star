load("../units.star", "Voltage", "Current")
load("../config.star", "config_unit")
load("../properties.star", "Properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

Package = enum("SOT-23-3")
MosfetChannel = enum("N", "P")
Mount = enum("SMD")

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Required
package = config("package", Package, convert=Package)
channel = config("channel", MosfetChannel, convert=MosfetChannel)

# Optional
mount = config("mount", Mount, default=Mount("SMD"), optional=True)
vgs_max = config_unit("vgs_max", Voltage, optional=True)
vds_max = config_unit("vds_max", Voltage, optional=True)
id_max = config_unit("id_max", Current, optional=True)

# Properties
properties = config("properties", dict, optional=True)

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

DRAIN = io("DRAIN", Net)
GATE = io("GATE", Net)
SOURCE = io("SOURCE", Net)

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------


def _footprint(package: Package) -> str:
    kicad_footprints = {
        Package("SOT-23-3"): "Package_TO_SOT_SMD:SOT-23-3",
    }

    if package not in kicad_footprints:
        error("Invalid package: " + str(package))

    return kicad_footprints[package]


# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

channel_type = str(channel.value).lower()

Component(
    name="MOSFET",
    type=f"{channel_type}-mosfet",
    footprint=_footprint(package),
    prefix="M",
    pin_defs={
        "DRAIN": "1",
        "GATE": "2",
        "SOURCE": "3",
    },
    pins={
        "DRAIN": DRAIN,
        "GATE": GATE,
        "SOURCE": SOURCE,
    },
    properties=Properties(
        properties,
        {
            "package": package,
            "mount": mount,
            "channel": channel,
            "vgs_max": vgs_max,
            "vds_max": vds_max,
            "id_max": id_max,
        },
    ),
)

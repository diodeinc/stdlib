load("../units.star", "Voltage", "Current", "Frequency")
load("../config.star", "config_unit", "config_properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

Package = enum("SOT-23-3")
BjtType = enum("NPN", "PNP")
Mount = enum("SMD")

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Required
package = config("package", Package, convert=Package)
bjt_type = config("bjt_type", BjtType, convert=BjtType)

# Optional
mount = config("mount", Mount, default=Mount("SMD"), optional=True)
hfe = config("hfe", float, optional=True)
vceo = config_unit("vceo", Voltage, optional=True)
vebo = config_unit("vebo", Voltage, optional=True)
vcbo = config_unit("vcbo", Voltage, optional=True)
ic_max = config_unit("ic_max", Current, optional=True)
ft = config_unit("ft", Frequency, optional=True)

# Properties – combined and normalized
properties = config_properties({
    "mount": mount,
    "package": package,
    "bjt_type": bjt_type,
    "hfe": hfe,
    "vceo": vceo,
    "vebo": vebo,
    "vcbo": vcbo,
    "ic_max": ic_max,
    "ft": ft,
})

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

COLLECTOR = io("COLLECTOR", Net)
BASE = io("BASE", Net)
EMITTER = io("EMITTER", Net)

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


def _name(bjt_type: BjtType) -> str:
    type_str = str(bjt_type.value).lower()
    return f"{type_str}-bjt"


# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

Component(
    name="BJT",
    type=_name(bjt_type),
    footprint=_footprint(package),
    prefix="Q",
    pins={
        "COLLECTOR": COLLECTOR,
        "BASE": BASE,
        "EMITTER": EMITTER,
    },
    pin_defs={
        "COLLECTOR": "1",
        "BASE": "2",
        "EMITTER": "3",
    },
    properties=properties,
)

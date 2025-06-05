load("../units.star", "unit")
load("../config.star", "config_properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

Diameter = enum("M2", "M2.5", "M3", "M4", "M5", "M6", "M8")
Standard = enum("DIN965", "ISO14580")
Plating = enum("TopBottom", "TopOnly", "Via")

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

diameter = config("diameter", Diameter, convert=Diameter)
standard = config("standard", Standard, default=Standard("DIN965"), convert=Standard, optional=True)
plating = config("plating", Plating, default=Plating("TopBottom"), convert=Plating, optional=True)

# Properties – combined and normalized
properties = config_properties({
    "diameter": diameter,
    "standard": standard,
    "plating": plating,
})

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

P1 = io("P1", Net, optional=True)

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------


def _footprint(diameter: Diameter, standard: Standard | None = None, plating: Plating | None = None) -> str:
    """
    Returns the appropriate mounting hole footprint based on the parameters.

    Parameters:
    - diameter: The screw diameter (M2, M2.5, etc.)
    - standard: Optional screw head standard (DIN965, ISO14580)
    - plating: Optional plating type for the hole

    Returns:
    - Footprint path string
    """
    # Diameter to hole size mapping
    hole_sizes = {
        Diameter("M2"): "2.2mm",
        Diameter("M2.5"): "2.7mm",
        Diameter("M3"): "3.2mm",
        Diameter("M4"): "4.3mm",
        Diameter("M5"): "5.3mm",
        Diameter("M6"): "6.4mm",
        Diameter("M8"): "8.4mm",
    }

    # Start building the footprint name
    footprint = "MountingHole_" + hole_sizes[diameter] + "_" + diameter.value
    footprint += "_" + standard.value if standard else ""
    footprint += "_Pad_" + plating.value if plating else ""

    return f"MountingHole:{footprint}"


# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

Component(
    name="MH",
    type="mounting_hole",
    footprint=_footprint(diameter, standard, plating),
    prefix="H",
    pin_defs={
        "P1": "1",
    },
    pins={
        "P1": P1,
    },
    properties=properties,
)

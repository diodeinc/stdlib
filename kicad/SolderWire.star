load("../config.star", "config_properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

Size = enum(
    "SMD_1x2mm",  # Small SMD pad
    "SMD_5x10mm",  # Large SMD pad
)

# Backwards compatibility
SolderWireSize = Size

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Required
size = config("size", Size, default = Size("SMD_1x2mm"), convert = Size)

# Properties – combined and normalized
properties = config_properties(
    properties = {
        "size": size,
    },
    exclude_from_bom = True,
)

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

P1 = io("P1", Net)

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------

def _footprint(size: SolderWireSize) -> str:
    """Returns the appropriate solder wire pad footprint based on the size."""
    footprints = {
        SolderWireSize("SMD_1x2mm"): "Connector_Wire:SolderWirePad_1x01_SMD_1x2mm",
        SolderWireSize("SMD_5x10mm"): "Connector_Wire:SolderWirePad_1x01_SMD_5x10mm",
    }

    if size not in footprints:
        error("Invalid size: " + str(size))
    return footprints[size]

# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

Component(
    name = "SW",
    type = "solder_wire",
    footprint = _footprint(size),
    symbol = "Connector_Generic:Conn_01x01",
    prefix = "P",
    pins = {"P1": P1},
    pin_defs = {"P1": "1"},
    properties = properties,
)

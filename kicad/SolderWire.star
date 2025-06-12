load("../config.star", "config_properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

SolderWireSize = enum(
    "SMD_1x2mm",  # Small SMD pad
    "SMD_5x7mm",  # Medium SMD pad
    "SMD_5x10mm",  # Large SMD pad
)

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Required
size = config("size", SolderWireSize, default = SolderWireSize("SMD_5x7mm"), convert = SolderWireSize)

# Properties – combined and normalized
properties = config_properties({
    "size": size,
})


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
        SolderWireSize("SMD_5x7mm"): "Connector_Wire:SolderWirePad_1x01_SMD_5x7mm",
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
    properties = properties
)

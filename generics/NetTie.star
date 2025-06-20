load("../config.star", "config_properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

PadSize = enum("0.3mm", "0.5mm", "1.0mm", "2.0mm")
MountType = enum("SMD", "THT")
PinCount = enum("2", "3", "4")

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Optional
mount_type = config("mount_type", MountType, default=MountType("SMD"), optional=True)
pad_size = config("pad_size", PadSize, default=PadSize("0.5mm"), optional=True)
pin_count = config("pin_count", int, default=2, optional=True)

# Properties – combined and normalized
properties = config_properties({
    "mount_type": mount_type,
    "pad_size": pad_size,
    "pin_count": pin_count,
    "exclude_from_bom": True,
})

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

P = [io(f"P{i}", Net) for i in range(1, pin_count + 1)]

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------


def _get_footprint(pin_count, mount_type, pad_size):
    """Returns the appropriate net tie footprint."""
    pins = str(pin_count)
    mount = mount_type.value
    pad = pad_size.value
    return f"NetTie:NetTie-{pins}_{mount}_Pad{pad}"


def _get_pins_and_connections(P):
    """Get both the pin specifications and connection mappings based on pin count."""
    pin_defs = {
        "P1": "1",
        "P2": "2",
    }
    pins = {
        "P1": P[0],
        "P2": P[1],
    }

    if str(pin_count) >= "3":
        pin_defs["P3"] = "3"
        pins["P3"] = P[2]

    if str(pin_count) >= "4":
        pin_defs["P4"] = "4"
        pins["P4"] = P[3]

    return pins, pin_defs


# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

# Determine pin count based on provided nets
pins, pin_defs = _get_pins_and_connections(P)

Component(
    name="NT",
    type="net_tie",
    footprint=_get_footprint(pin_count, mount_type, pad_size),
    prefix="NT",
    pins=pins,
    pin_defs=pin_defs,
    properties=properties,
)

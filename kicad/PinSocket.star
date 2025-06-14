load("../config.star", "config_properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

Pitch = enum(
    "P2_00mm",  # 2.00mm pitch
    "P2_54mm",  # 2.54mm pitch (standard)
)

Orientation = enum(
    "Vertical",  # Vertical through-hole
    "Horizontal",  # Horizontal through-hole
    "Vertical_SMD",  # Vertical SMD
)

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Required
pins = config("pins", int, default = 1)
rows = config("rows", int, default = 1)
pitch = config("pitch", Pitch, default = Pitch("P2_54mm"))
orientation = config("orientation", Orientation, default = Orientation("Vertical"))

# Properties – combined and normalized
properties = config_properties({
    "pins": pins,
    "rows": rows,
    "pitch": pitch,
    "orientation": orientation,
})

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

# Generate IO ports dynamically based on pin count
io_ports = {}
for i in range(1, pins * rows + 1):
    io_ports["P" + str(i)] = io("P" + str(i), Net)

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------

def _footprint(pins: int, rows: int, pitch: Pitch, orientation: Orientation) -> str:
    """Returns the appropriate PinSocket footprint based on parameters."""

    # Validate parameters
    if pins < 1 or pins > 40:
        error("Invalid pin count: " + str(pins) + ". Must be between 1 and 40.")
    if rows not in [1, 2]:
        error("Invalid row count: " + str(rows) + ". Must be 1 or 2.")

    # Build footprint name
    pitch_str = "2.00mm" if pitch == Pitch("P2_00mm") else "2.54mm"

    # Format pin count with leading zero if needed
    pin_str = str(pins) if pins >= 10 else "0" + str(pins)

    # Build the footprint name
    if rows == 1:
        footprint_name = "Connector_PinSocket_" + pitch_str + ":PinSocket_1x" + pin_str + "_P" + pitch_str + "_" + orientation.value
    else:
        footprint_name = "Connector_PinSocket_" + pitch_str + ":PinSocket_2x" + pin_str + "_P" + pitch_str + "_" + orientation.value

    # Handle SMD variants with pin position
    if orientation == Orientation("Vertical_SMD") and rows == 1:
        # For single row SMD, we default to Pin1Left
        footprint_name += "_Pin1Left"

    return footprint_name

def _symbol(pins: int, rows: int) -> str:
    """Returns the appropriate generic connector symbol based on pin configuration."""

    # Format pin count with leading zero if needed
    pin_str = str(pins) if pins >= 10 else "0" + str(pins)

    if rows == 1:
        return "Connector_Generic:Conn_01x" + pin_str
    else:
        return "Connector_Generic:Conn_02x" + pin_str + "_Odd_Even"

def _generate_pin_defs(pins: int, rows: int) -> dict:
    """Generate pin definitions mapping port names to pin numbers."""
    pin_defs = {}

    if rows == 1:
        # Single row: simple 1-to-1 mapping
        for i in range(1, pins + 1):
            pin_defs["P" + str(i)] = str(i)
    else:
        # Double row: odd pins on one side, even on the other
        for i in range(1, pins * 2 + 1):
            pin_defs["P" + str(i)] = str(i)

    return pin_defs

# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

Component(
    name = "PS",
    type = "pin_socket",
    footprint = _footprint(pins, rows, pitch, orientation),
    symbol = _symbol(pins, rows),
    prefix = "J",
    pins = io_ports,
    pin_defs = _generate_pin_defs(pins, rows),
    properties = properties,
)

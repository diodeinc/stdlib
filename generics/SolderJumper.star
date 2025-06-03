load("../properties.star", "Properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

SolderJumperStyle = enum(
    "Open",
    "Bridged",
    "Bridged2Bar",
    "Bridged123",
    "Bridged12",
    "Bridged2Bar123",
    "Bridged2Bar12",
)
SolderJumperVariant = enum(
    "Pad",
    "RoundedPad",
    "TrianglePad",
    "Pad_NumberLabels",
    "RoundedPad_NumberLabels",
    "TrianglePad_NumberLabels",
)
SolderJumperPitch = enum("P1.3mm", "P2.0mm")

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

pin_count = config("pin_count", int, default=2, optional=True)
style = config("style", SolderJumperStyle, convert=SolderJumperStyle)
variant = config("variant", SolderJumperVariant, convert=SolderJumperVariant)
pitch = config("pitch", SolderJumperPitch, default=SolderJumperPitch("P1.3mm"), optional=True)
properties = config("properties", dict, optional=True)

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

P = [io(f"P{i}", Net) for i in range(1, pin_count + 1)]

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------


def _footprint(pin_count, style, variant, pitch):
    base = "Jumper:SolderJumper-"

    # Compose the footprint name
    name = str(pin_count) + "_" + pitch.value + "_" + style.value

    # Variant handling
    if variant.value.startswith("Pad"):
        name += "_Pad1.0x1.5mm"
    elif variant.value.startswith("RoundedPad"):
        name += "_RoundedPad1.0x1.5mm"
    elif variant.value.startswith("TrianglePad"):
        name += "_TrianglePad1.0x1.5mm"

    # NumberLabels
    if "NumberLabels" in variant.value:
        name += "_NumberLabels"
    return base + name


def _pins_and_connections(pin_count):
    # pin_defs: mapping of pin name to pin number as string
    # pins: mapping of pin name to net (if connected)
    pin_defs = {}
    pins = {}
    nets = P
    for i in range(pin_count):
        pin_name = "P" + str(i + 1)
        pin_defs[pin_name] = str(i + 1)
        net = nets[i]
        if net != None:
            pins[pin_name] = net
    return pins, pin_defs


# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

pins, pin_defs = _pins_and_connections(pin_count)

Component(
    name="SJ",
    type="solder_jumper",
    footprint=_footprint(pin_count, style, variant, pitch),
    prefix="JP",
    pins=pins,
    pin_defs=pin_defs,
    properties=Properties(
        properties,
        {
            "pin_count": pin_count,
            "style": style,
            "variant": variant,
            "pitch": pitch,
            "symbol_path": "/Applications/KiCad/KiCad.app/Contents/SharedSupport/symbols/Jumper",
        },
    ),
)

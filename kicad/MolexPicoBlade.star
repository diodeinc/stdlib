load("../properties.star", "Properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

MolexPicoBladeVariant = enum(
    "53261-1471_1x14-1MP_Horizontal",
    "53047-1510_1x15_Vertical",
    "53398-1271_1x12-1MP_Vertical",
    "53261-0671_1x06-1MP_Horizontal",
    "53047-0510_1x05_Vertical",
    "53048-0910_1x09_Horizontal",
    "53398-1471_1x14-1MP_Vertical",
    "53398-0271_1x02-1MP_Vertical",
    "53261-1371_1x13-1MP_Horizontal",
    "53047-1410_1x14_Vertical",
    "53398-0471_1x04-1MP_Vertical",
    "53047-0410_1x04_Vertical",
    "53261-1771_1x17-1MP_Horizontal",
    "53261-0971_1x09-1MP_Horizontal",
    "53047-0910_1x09_Vertical",
    "53398-1371_1x13-1MP_Vertical",
    "53398-1571_1x15-1MP_Vertical",
    "53047-1110_1x11_Vertical",
    "53261-0571_1x05-1MP_Horizontal",
    "53261-1071_1x10-1MP_Horizontal",
    "53047-0810_1x08_Vertical",
    "53398-0371_1x03-1MP_Vertical",
    "53047-1010_1x10_Vertical",
    "53398-0571_1x05-1MP_Vertical",
    "53048-0810_1x08_Horizontal",
    "53261-0271_1x02-1MP_Horizontal",
    "53047-1210_1x12_Vertical",
    "53048-0710_1x07_Horizontal",
    "53048-1510_1x15_Horizontal",
    "53261-1271_1x12-1MP_Horizontal",
    "53398-1071_1x10-1MP_Vertical",
    "53047-0210_1x02_Vertical",
    "53048-0410_1x04_Horizontal",
    "53048-1310_1x13_Horizontal",
    "53047-1310_1x13_Vertical",
    "53398-0671_1x06-1MP_Vertical",
    "53398-0871_1x08-1MP_Vertical",
    "53261-1571_1x15-1MP_Horizontal",
    "53047-0310_1x03_Vertical",
    "53261-0771_1x07-1MP_Horizontal",
    "53048-1010_1x10_Horizontal",
    "53048-0210_1x02_Horizontal",
    "53048-1210_1x12_Horizontal",
    "53047-0610_1x06_Vertical",
    "53261-1171_1x11-1MP_Horizontal",
    "53261-0371_1x03-1MP_Horizontal",
    "53048-0310_1x03_Horizontal",
    "53048-1110_1x11_Horizontal",
    "53398-1171_1x11-1MP_Vertical",
    "53398-0771_1x07-1MP_Vertical",
    "53398-0971_1x09-1MP_Vertical",
    "53048-1410_1x14_Horizontal",
    "53048-0610_1x06_Horizontal",
    "53261-0871_1x08-1MP_Horizontal",
    "53047-0710_1x07_Vertical",
    "53261-0471_1x04-1MP_Horizontal",
    "53048-0510_1x05_Horizontal",
)

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

variant = config("variant", MolexPicoBladeVariant, convert=MolexPicoBladeVariant)
properties = config("properties", dict, optional=True)

# -----------------------------------------------------------------------------
# IO ports (up to 17 pins)
# -----------------------------------------------------------------------------

P1 = io("P1", Net)
P2 = io("P2", Net)
P3 = io("P3", Net | None, default=None, optional=True)
P4 = io("P4", Net | None, default=None, optional=True)
P5 = io("P5", Net | None, default=None, optional=True)
P6 = io("P6", Net | None, default=None, optional=True)
P7 = io("P7", Net | None, default=None, optional=True)
P8 = io("P8", Net | None, default=None, optional=True)
P9 = io("P9", Net | None, default=None, optional=True)
P10 = io("P10", Net | None, default=None, optional=True)
P11 = io("P11", Net | None, default=None, optional=True)
P12 = io("P12", Net | None, default=None, optional=True)
P13 = io("P13", Net | None, default=None, optional=True)
P14 = io("P14", Net | None, default=None, optional=True)
P15 = io("P15", Net | None, default=None, optional=True)
P16 = io("P16", Net | None, default=None, optional=True)
P17 = io("P17", Net | None, default=None, optional=True)

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------


def _footprint(variant: MolexPicoBladeVariant) -> str:
    footprints = {
        MolexPicoBladeVariant(
            "53261-1471_1x14-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-1471_1x14-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53047-1510_1x15_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-1510_1x15_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-1271_1x12-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-1271_1x12-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53261-0671_1x06-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-0671_1x06-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53047-0510_1x05_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-0510_1x05_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53048-0910_1x09_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-0910_1x09_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53398-1471_1x14-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-1471_1x14-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-0271_1x02-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-0271_1x02-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53261-1371_1x13-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-1371_1x13-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53047-1410_1x14_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-1410_1x14_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-0471_1x04-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-0471_1x04-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53047-0410_1x04_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-0410_1x04_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53261-1771_1x17-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-1771_1x17-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53261-0971_1x09-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-0971_1x09-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53047-0910_1x09_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-0910_1x09_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-1371_1x13-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-1371_1x13-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-1571_1x15-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-1571_1x15-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53047-1110_1x11_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-1110_1x11_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53261-0571_1x05-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-0571_1x05-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53261-1071_1x10-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-1071_1x10-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53047-0810_1x08_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-0810_1x08_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-0371_1x03-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-0371_1x03-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53047-1010_1x10_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-1010_1x10_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-0571_1x05-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-0571_1x05-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53048-0810_1x08_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-0810_1x08_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53261-0271_1x02-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-0271_1x02-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53047-1210_1x12_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-1210_1x12_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53048-0710_1x07_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-0710_1x07_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53048-1510_1x15_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-1510_1x15_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53261-1271_1x12-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-1271_1x12-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53398-1071_1x10-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-1071_1x10-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53047-0210_1x02_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-0210_1x02_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53048-0410_1x04_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-0410_1x04_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53048-1310_1x13_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-1310_1x13_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53047-1310_1x13_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-1310_1x13_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-0671_1x06-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-0671_1x06-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-0871_1x08-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-0871_1x08-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53261-1571_1x15-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-1571_1x15-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53047-0310_1x03_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-0310_1x03_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53261-0771_1x07-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-0771_1x07-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53048-1010_1x10_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-1010_1x10_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53048-0210_1x02_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-0210_1x02_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53048-1210_1x12_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-1210_1x12_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53047-0610_1x06_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-0610_1x06_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53261-1171_1x11-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-1171_1x11-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53261-0371_1x03-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-0371_1x03-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53048-0310_1x03_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-0310_1x03_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53048-1110_1x11_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-1110_1x11_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53398-1171_1x11-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-1171_1x11-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-0771_1x07-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-0771_1x07-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53398-0971_1x09-1MP_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53398-0971_1x09-1MP_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53048-1410_1x14_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-1410_1x14_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53048-0610_1x06_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-0610_1x06_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53261-0871_1x08-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-0871_1x08-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53047-0710_1x07_Vertical"
        ): "Connector_Molex:Molex_PicoBlade_53047-0710_1x07_P1.25mm_Vertical",
        MolexPicoBladeVariant(
            "53261-0471_1x04-1MP_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53261-0471_1x04-1MP_P1.25mm_Horizontal",
        MolexPicoBladeVariant(
            "53048-0510_1x05_Horizontal"
        ): "Connector_Molex:Molex_PicoBlade_53048-0510_1x05_P1.25mm_Horizontal",
    }
    if variant not in footprints:
        error("Invalid Molex PicoBlade variant: " + str(variant))
    return footprints[variant]


def _pin_count(variant: MolexPicoBladeVariant) -> int:
    # Extract pin count from variant string, e.g. "1x14" or "1x15"
    s = str(variant)
    idx = s.find("1x")
    if idx != -1:
        start = idx + 2
        end = start
        for i in range(start, len(s)):
            if not s[i].isdigit():
                break
            end = i + 1
        return int(s[start:end])
    error("Cannot determine pin count from variant: " + str(variant))


def _pins_and_connections(pin_count: int):
    pins = {}
    pin_defs = {}
    nets = [P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17]
    for i in range(pin_count):
        index = i + 1
        pin_name = f"P{index}"
        pin = str(index)
        net = nets[i]
        if net != None:
            pins[pin_name] = net
            pin_defs[pin_name] = str(index)

    return pins, pin_defs

def _mpn(variant: MolexPicoBladeVariant) -> str:
    return variant.value.split("_")[0]

# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

pin_count = _pin_count(variant)
pins, pin_defs = _pins_and_connections(pin_count)

Component(
    name="MPB",
    type="molex_picoblade",
    footprint=_footprint(variant),
    prefix="J",
    pin_defs=pin_defs,
    pins=pins,
    properties=Properties(
        properties,
        {
            "value": _mpn(variant),
        },
    ),
)

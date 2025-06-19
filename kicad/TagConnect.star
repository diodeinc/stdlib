load("../properties.star", "Properties")

# -----------------------------------------------------------------------------
# Component types
# -----------------------------------------------------------------------------

TagConnectType = enum(
    "TC2030-IDC-NL-2x03",
    "TC2030-IDC-FP-2x03",
    "TC2050-IDC-NL-2x05",
    "TC2050-IDC-FP-2x05",
    "TC2050-IDC-NL-2x05-BottomClip",
    "TC2070-IDC-FP-2x07",
)


def TagConnectPinCount(tag_type: TagConnectType) -> int:
    if "2x03" in str(tag_type):
        return 6
    elif "2x05" in str(tag_type):
        return 10
    elif "2x07" in str(tag_type):
        return 14


def TagConnectFootprint(tag_type: TagConnectType) -> str:
    """Get the KiCad footprint name for a Tag-Connect type."""
    footprints = {
        TagConnectType("TC2030-IDC-NL-2x03"): "Connector:Tag-Connect_TC2030-IDC-NL_2x03_P1.27mm_Vertical",
        TagConnectType("TC2030-IDC-FP-2x03"): "Connector:Tag-Connect_TC2030-IDC-FP_2x03_P1.27mm_Vertical",
        TagConnectType("TC2050-IDC-NL-2x05"): "Connector:Tag-Connect_TC2050-IDC-NL_2x05_P1.27mm_Vertical",
        TagConnectType("TC2050-IDC-FP-2x05"): "Connector:Tag-Connect_TC2050-IDC-FP_2x05_P1.27mm_Vertical",
        TagConnectType(
            "TC2050-IDC-NL-2x05-BottomClip"
        ): "Connector:Tag-Connect_TC2050-IDC-NL_2x05_P1.27mm_Vertical_with_bottom_clip",
        TagConnectType("TC2070-IDC-FP-2x07"): "Connector:Tag-Connect_TC2070-IDC-FP_2x07_P1.27mm_Vertical",
    }
    if tag_type not in footprints:
        error("Invalid Tag-Connect type: " + str(tag_type))
    return footprints[tag_type]

def _get_symbol(pin_count: int) -> str:
    """Returns a generic connector symbol based on pin count."""
    # Use 2-row connectors for Tag-Connect
    rows = 2
    cols = pin_count // rows
    # Format with zero padding manually
    rows_str = "0" + str(rows) if rows < 10 else str(rows)
    cols_str = "0" + str(cols) if cols < 10 else str(cols)
    return f"Connector_Generic:Conn_{rows_str}x{cols_str}_Odd_Even"

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

tag_type = config("tag_type", TagConnectType, convert=TagConnectType)
properties = config("properties", dict, optional=True)

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

pins = {}
pin_defs = {}

for i in range(1, TagConnectPinCount(tag_type) + 1):
    pin_name = f"P{i}"
    pins[pin_name] = io(pin_name, Net)
    pin_defs[pin_name] = str(i)

# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------


Component(
    name="TAG_CONNECT",
    type="tag_connect",
    footprint=TagConnectFootprint(tag_type),
    symbol=_get_symbol(TagConnectPinCount(tag_type)),
    prefix="J",
    pins=pins,
    pin_defs=pin_defs,
    properties=Properties(
        properties,
        {
            "tag_type": tag_type,
            "exclude_from_bom": True,
        },
    ),
)

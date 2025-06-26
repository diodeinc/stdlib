load("../config.star", "config_properties")

# -----------------------------------------------------------------------------
# Component types and variants
# -----------------------------------------------------------------------------

Variant = enum(
    # Pad
    "Pad_D1.0mm",
    "Pad_D1.5mm",
    "Pad_D2.0mm",
    "Pad_D2.5mm",
    "Pad_D3.0mm",
    "Pad_D4.0mm",
    "Pad_1.0x1.0mm",
    "Pad_1.5x1.5mm",
    "Pad_2.0x2.0mm",
    "Pad_2.5x2.5mm",
    "Pad_3.0x3.0mm",
    "Pad_4.0x4.0mm",
    # Loop
    "Loop_D1.80mm_Drill1.0mm_Beaded",
    "Loop_D2.50mm_Drill1.0mm",
    "Loop_D2.50mm_Drill1.0mm_LowProfile",
    "Loop_D2.50mm_Drill1.85mm",
    "Loop_D2.54mm_Drill1.5mm_Beaded",
    "Loop_D2.60mm_Drill0.9mm_Beaded",
    "Loop_D2.60mm_Drill1.4mm_Beaded",
    "Loop_D2.60mm_Drill1.6mm_Beaded",
    "Loop_D3.50mm_Drill0.9mm_Beaded",
    "Loop_D3.50mm_Drill1.4mm_Beaded",
    "Loop_D3.80mm_Drill2.0mm",
    "Loop_D3.80mm_Drill2.5mm",
    "Loop_D3.80mm_Drill2.8mm",
    # Bridge
    "Bridge_Pitch2.0mm_Drill0.7mm",
    "Bridge_Pitch2.54mm_Drill0.7mm",
    "Bridge_Pitch2.54mm_Drill1.0mm",
    "Bridge_Pitch2.54mm_Drill1.3mm",
    "Bridge_Pitch3.81mm_Drill1.3mm",
    "Bridge_Pitch5.08mm_Drill0.7mm",
    "Bridge_Pitch5.08mm_Drill1.3mm",
    "Bridge_Pitch6.35mm_Drill1.3mm",
    "Bridge_Pitch7.62mm_Drill1.3mm",
    # PlatedHole
    "Plated_Hole_D2.0mm",
    "Plated_Hole_D3.0mm",
    "Plated_Hole_D4.0mm",
    "Plated_Hole_D5.0mm",
    # Keystone
    "Keystone_5000-5004_Miniature",
    "Keystone_5005-5009_Compact",
    "Keystone_5010-5014_Multipurpose",
    "Keystone_5015_Micro_Mini",
    "Keystone_5019_Miniature",
    # THTPad
    "THTPad_D1.0mm_Drill0.5mm",
    "THTPad_D1.5mm_Drill0.7mm",
    "THTPad_D2.0mm_Drill1.0mm",
    "THTPad_D2.5mm_Drill1.2mm",
    "THTPad_D3.0mm_Drill1.5mm",
    "THTPad_D4.0mm_Drill2.0mm",
    "THTPad_1.0x1.0mm_Drill0.5mm",
    "THTPad_1.5x1.5mm_Drill0.7mm",
    "THTPad_2.0x2.0mm_Drill1.0mm",
    "THTPad_2.5x2.5mm_Drill1.2mm",
    "THTPad_3.0x3.0mm_Drill1.5mm",
    "THTPad_4.0x4.0mm_Drill2.0mm",
    # 2Pads
    "2Pads_Pitch2.54mm_Drill0.8mm",
    "2Pads_Pitch5.08mm_Drill1.3mm",
)

# -----------------------------------------------------------------------------
# Component parameters
# -----------------------------------------------------------------------------

# Config
variant = config("variant", Variant)

# Properties – combined and normalized
properties = config_properties({
    "variant": variant,
})

# -----------------------------------------------------------------------------
# IO ports
# -----------------------------------------------------------------------------

P1 = io("P1", Net)

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------


def _get_footprint(variant):
    lib = "TestPoint"
    name = variant.value  # e.g., "Pad_D1.0mm"
    return f"{lib}:TestPoint_{name}"

def _get_symbol(variant):
    lib = "TestPoint"
    name = variant.value  # e.g., "Pad_D1.0mm"
    return f"{lib}:TestPoint_{name}"

# -----------------------------------------------------------------------------
# Component definition
# -----------------------------------------------------------------------------

Component(
    name="TP",
    type="test_point",
    footprint=_get_footprint(variant),    
    symbol=_get_symbol(variant),
    prefix="TP",
    pin_defs={
        "P1": "1",
    },
    pins={
        "P1": P1,
    },
    properties=properties,
)

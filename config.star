load("units.star", "unit")

def config_unit(name, UnitType, optional = False, default = None, **kwargs):
    """Helper function to create a config value for a unit type.

    Args:
        name (str): The name of the configuration value.
        UnitType (Any): The unit type of the configuration value.
        optional (bool): Whether the configuration value is optional.
        default (UnitType): The default value of the configuration value.
        **kwargs: Additional keyword arguments.

    Returns:
        config: The configuration value.
    """
    unit_type = UnitType | None if optional else UnitType
    default = default or (None if optional else UnitType(value = 0.0))

    def convert_unit(x):
        if x == None:
            return None
        return unit(x, UnitType)

    return config(name, unit_type, default = default, convert = convert_unit, optional = optional, **kwargs)

def merge_properties(user_properties: dict | None, base_properties: dict) -> dict:
    """Helper function to merge user properties with base properties.

    Args:
        user_properties: The user properties to merge with the base properties.
        base_properties: The base properties to merge with the user properties.

    Returns:
        dict: The merged properties.
    """
    properties = {}

    def to_string(value):
        if hasattr(value, "__str__"):
            return value.__str__(value)
        if hasattr(value, "value"):
            return value.value
        return str(value)

    def add_property(key, value):
        key = to_string(key).lower().capitalize()
        if value == None:
            return
        properties[key] = to_string(value)

    for key, value in base_properties.items():
        add_property(key, value)

    if user_properties:
        for key, value in user_properties.items():
            add_property(key, value)

    return properties

def config_properties(properties: dict | None, exclude_from_bom: bool | None = None, do_not_populate: bool | None = None) -> dict:
    """Generate component properties with automatic Value field generation.

    This function merges component-specific properties with generic properties
    (mpn, do_not_populate, exclude_from_bom) and automatically generates a
    meaningful Value field for the component.

    The Value field generation follows these rules:
    1. If an MPN (manufacturer part number) is provided, it becomes the Value
    2. Otherwise, the Value is constructed by concatenating all non-metadata
       properties with spaces

    Args:
        properties: Component-specific properties (e.g., capacitance, voltage,
            package). Keys are normalized to capitalize the first letter.
        exclude_from_bom: Whether to exclude the component from the BOM.
        do_not_populate: Whether to not populate the component in the schematic.

    Returns:
        dict: Complete property dictionary with normalized keys and generated
        Value field, ready for use in Component definition.
    """

    # Generic properties
    user_properties = config("user_properties", dict, default = {}, optional = True)
    mpn = config("mpn", str, optional = True)
    do_not_populate = do_not_populate or config("do_not_populate", bool, optional = True)
    exclude_from_bom = exclude_from_bom or config("exclude_from_bom", bool, optional = True)

    default_properties = {
        "mpn": mpn,
        "do_not_populate": do_not_populate,
        "exclude_from_bom": exclude_from_bom,
    }

    # Merge and normalise via the existing helper.
    result = merge_properties(default_properties | user_properties, properties)

    # Keys come back with capitalised first letter.
    mpn_val = result.get("Mpn", "")

    if mpn_val:
        result["Value"] = mpn_val
        return result

    # Metadata keys that must be excluded from automatic Value generation.
    META_KEYS = ["Mpn", "Do_not_populate", "Exclude_from_bom", "Value"]

    parts = [v for k, v in result.items() if k not in META_KEYS and v]

    result["Value"] = " ".join(parts)

    return result

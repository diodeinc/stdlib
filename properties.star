Hint = struct(
    near = lambda a, b: "near({}, {})".format(a, b),
    right = lambda a, b: "right({}, {})".format(a, b),
    left = lambda a, b: "left({}, {})".format(a, b),
    above = lambda a, b: "above({}, {})".format(a, b),
    below = lambda a, b: "below({}, {})".format(a, b),
)

def Properties(user_properties: dict | None, base_properties: dict) -> dict:
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

def Layout(name: str, path: str | None = None, hints: list | None = None) -> None:
    """Helper function to create a layout object"""

    if path:
        add_property("layout_path", path)
    if hints:
        add_property("layout_hints", hints)

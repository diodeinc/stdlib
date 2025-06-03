load("units.star", "unit")


def config_unit(name, UnitType, optional=False, default=None, **kwargs):
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
    default = default or (None if optional else UnitType(value=0.0))

    def convert_unit(x):
        if x == None:
            return None
        return unit(x, UnitType)

    return config(name, unit_type, default=default, convert=convert_unit, optional=optional, **kwargs)

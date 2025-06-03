Pins = dict[str, Net]
PinOption = record(name=str, interface_type=typing.Any, field=str)
PinMap = dict[str, list[PinOption]]
PinInterfaces = dict[str, list[str]]
PinBuilder = record(pin_map=PinMap, pins=dict[str, Net | None])


def PinMapBuilder(pin_map: dict):
    """Return a fluent builder for pin configuration.

    Example:
        pins = (
            RP2040.PinMap()
                .connect("RUN", power_3v3.net)
                .assign("I2C0", i2c0, scl="GPIO1", sda="GPIO8")
                .build()
        )
    """

    def _init(pin_map: dict, pins: Pins | None = None) -> PinBuilder:
        """Create a PinBuilder with every *pin_map* entry initialised to None."""

        return PinBuilder(pin_map=pin_map, pins={pin: None for pin in pin_map} | (pins or {}))

    def _interfaces(builder: PinBuilder):
        """Return a dict of interfaces and their pins.

        Example:
            interfaces = _interfaces(builder)
        """
        interfaces = {}
        for pin, properties in builder.pin_map.items():
            for interface in properties:
                interfaces.setdefault(interface.name, {}).setdefault(pin, interface)
        return interfaces

    def _connect(builder: PinBuilder, pin_name: str, net: Net) -> PinBuilder:
        """Connect a pin to a net.

        Example:
            config.connect(config, "RUN", power_3v3.net)
        """
        pins = builder.pins
        pin_net = pins.get(pin_name)
        if pin_net:
            error(f"Pin already connected: {pin_name} -> {pin_net}, can't be {net}")

        available_pins = builder.pin_map.keys()
        if pin_name not in available_pins:
            error(f"Pin {pin_name} not found in pin map: {available_pins}")

        pins[pin_name] = net
        return PinBuilder(pins=pins, pin_map=builder.pin_map)

    def _assign(builder: PinBuilder, name: str, nets, **kwargs) -> PinBuilder:
        """Assign pins to an interface.

        Example:
            config.assign(config, "I2C0", i2c, scl="GPIO0", sda="GPIO1")
        """
        interfaces = _interfaces(builder)

        if name not in interfaces:
            interface_names = interfaces.keys()
            error(f"{name} not in {interface_names}")

        # Filter pins belonging to *name* that match the interface type
        iface_pins = {pin: opt for pin, opt in interfaces[name].items() if isinstance(nets, opt.interface_type)}

        available_pins = iface_pins.keys()
        available_fields = {i.field: None for i in iface_pins.values()}.keys()

        for field, pin_name in kwargs.items():
            pin = iface_pins.get(pin_name)
            if not pin:
                error(f"Pin {pin_name} not found for {name}: {available_pins}")

            if field not in available_fields:
                error(f"Field {field} not found for {name}: {available_fields}")

            if pin.field != field:
                alt_pins = [p for p, i in iface_pins.items() if i.field == field]
                error(f"{pin_name} can't be {name}.{field}: pick from {alt_pins}")

            builder = _connect(builder, pin_name, getattr(nets, field))

        return builder

    def _not_connected(builder: PinBuilder, pin: str) -> PinBuilder:
        # Substitute any un-connected pin with a new Net carrying the pin's name
        return _connect(builder, pin, Net(pin))

    def _assign_all(builder: PinBuilder, pins: Pins = {}, warn=True) -> Pins:
        """Assign all pins to the builder.pins dict."""
        result = {}
        unconnected_pins = []

        for pin, net in pins.items():
            builder = _connect(builder, pin, net)

        for pin, net in builder.pins.items():
            if net == None:
                unconnected_pins.append(pin)
                result[pin] = Net(pin)
            else:
                result[pin] = net
                
        if unconnected_pins and warn:
            print(f"Warning: Unconnected pins: {unconnected_pins}")
        return result

    def _pins(builder: PinBuilder) -> Pins:
        # Substitute any un-connected pin with a new Net carrying the pin's name
        return {name: pin for name, pin in builder.pins.items() if pin != None}

    def _fluent(bldr: PinBuilder):
        """Return a struct supporting chained connect/assign/build calls."""
        return struct(
            _init=lambda pins={}: _fluent(_init(pin_map, pins)),
            not_connected=lambda pin: _fluent(_not_connected(bldr, pin)),
            connect=lambda pin, net: _fluent(_connect(bldr, pin, net)),
            assign=lambda name, nets, **kw: _fluent(_assign(bldr, name, nets, **kw)),
            assign_all=lambda pins={}, warn=True: _assign_all(bldr, pins, warn),
            pins=lambda: _pins(bldr),
        )

    return _fluent(_init(pin_map))._init


def PinInterface(name: str, interface_type):
    """Return a struct of PinOption objects for *interface_type* bound to *name*.

    Example:
        load("stdlib/interfaces.star", "OscPair", "Usb2")
        load("stdlib/pins.star", "bind_interface")

        OSC = PinInterface("OSC", OscPair, ["xin", "xout"])
        USB = PinInterface("USB", Usb2, ["dp", "dm"])
    """

    # Extract interface fields: str(Spi) -> "<Interface: cs=Net, miso=Net, mosi=Net, clk=Net>"
    fields = [f.split("=")[0].strip() for f in str(interface_type).split(":")[1].split(",")]

    # One-liner dict-comprehension keeps behaviour yet trims verbosity
    pin_options = {f.upper(): PinOption(name=name, interface_type=interface_type, field=f) for f in fields}

    return struct(**pin_options)

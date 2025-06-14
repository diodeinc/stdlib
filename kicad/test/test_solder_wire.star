load("..", "SolderWire")

for wire_size in SolderWire.Size:
    name = "SolderWire_" + wire_size.value
    SolderWire(name = name, size = wire_size.value, P1 = Net("Net1"))

add_property("layout_path", "build/preview")

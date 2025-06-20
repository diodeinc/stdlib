load("..", "PinSocket")

for orientation in PinSocket.Orientation:
    for pitch in PinSocket.Pitch:
        for rows in range(1, 3):
            for positions in range(1, 11):
                orientation_str = orientation.value
                pitch_str = pitch.value
                
                pins = {f"P{n}": Net(f"Net{n}") for n in range(1, positions * rows + 1)}
                name = "PinSocket_" + orientation_str + "_" + pitch_str + "_" + str(positions) + "_" + str(rows)
                
                if orientation_str == "Vertical_SMD" and positions == 1:
                    # Vertical_SMD with 1 pin is not a valid footprint
                    continue
                
                PinSocket(name = name, pins = positions, rows = rows, orientation = orientation_str, pitch = pitch_str, **pins)


add_property("layout_path", "build/pin_socket")

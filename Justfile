
sim:
    pcb sim simulation/test/test_VoltageDivider.zen --setup simulation/test/test_VoltageDivider.sp -o - | ngspice
    pcb sim simulation/test/test_InvertingSum.zen --setup simulation/test/test_InvertingSum.sp -o - | ngspice
    pcb sim simulation/test/test_LevelShifter.zen --setup simulation/test/test_LevelShifter.sp -o - | ngspice
    pcb sim simulation/test/test_SallenKey.zen --setup simulation/test/test_SallenKey.sp -o - | ngspice
    pcb sim simulation/test/test_Sum.zen --setup simulation/test/test_Sum.sp -o - | ngspice
    pcb sim simulation/test/test_Inductor.zen --setup simulation/test/test_Inductor.sp -o - | ngspice
    pcb sim simulation/test/test_NetTie.zen --setup simulation/test/test_NetTie.sp -o - | ngspice
    pcb sim simulation/test/test_Diode.zen --setup simulation/test/test_Diode.sp -o - | ngspice
    pcb sim simulation/test/test_Led.zen --setup simulation/test/test_Led.sp -o - | ngspice

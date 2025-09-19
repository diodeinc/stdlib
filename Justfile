
sim: sim_VoltageDivider sim_InvertingSum sim_LevelShifter sim_SallenKey sim_Sum sim_Inductor sim_NetTie sim_Diode sim_Led sim_Crystal

sim_VoltageDivider:
    pcb sim simulation/test/test_VoltageDivider.zen --setup simulation/test/test_VoltageDivider.sp -o - | ngspice

sim_InvertingSum:
    pcb sim simulation/test/test_InvertingSum.zen --setup simulation/test/test_InvertingSum.sp -o - | ngspice

sim_LevelShifter:
    pcb sim simulation/test/test_LevelShifter.zen --setup simulation/test/test_LevelShifter.sp -o - | ngspice

sim_SallenKey:
    pcb sim simulation/test/test_SallenKey.zen --setup simulation/test/test_SallenKey.sp -o - | ngspice

sim_Sum:
    pcb sim simulation/test/test_Sum.zen --setup simulation/test/test_Sum.sp -o - | ngspice

sim_Inductor:
    pcb sim simulation/test/test_Inductor.zen --setup simulation/test/test_Inductor.sp -o - | ngspice

sim_NetTie:
    pcb sim simulation/test/test_NetTie.zen --setup simulation/test/test_NetTie.sp -o - | ngspice

sim_Diode:
    pcb sim simulation/test/test_Diode.zen --setup simulation/test/test_Diode.sp -o - | ngspice

sim_Led:
    pcb sim simulation/test/test_Led.zen --setup simulation/test/test_Led.sp -o - | ngspice

sim_Crystal:
    pcb sim simulation/test/test_Crystal.zen --setup simulation/test/test_Crystal.sp -o - | ngspice

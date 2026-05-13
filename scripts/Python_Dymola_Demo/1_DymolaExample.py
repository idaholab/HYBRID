from dymola.dymola_interface import DymolaInterface
import os
from path_config import load_paths, abs_wd

#Path to dymola output directory of your choosing (relative to project root)
WD = "Output_1"
WD_abs = abs_wd(WD)


# Instantiate the Dymola interface and start Dymola
dymola = DymolaInterface()

dymola.ExecuteCommand('Modelica.Utilities.System.setWorkDirectory("'+ WD_abs +'")')

# Call a function in Dymola and check its return value
result = dymola.simulateModel("Modelica.Mechanics.Rotational.Examples.CoupledClutches")
if not result:
    print("Simulation failed. Below is the translation log.")
    log = dymola.getLastErrorLog()
    print(log)
    exit(1)

dymola.plot(["J1.w", "J2.w", "J3.w", "J4.w"])
plotPath = WD_abs + "/plot.png"
dymola.ExportPlotAsImage(plotPath)

print("OK")

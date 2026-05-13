from dymola.dymola_interface import DymolaInterface
import matplotlib.pyplot as plt
import numpy as np
import os
from path_config import load_paths, abs_wd

#External library locations live in paths.txt - edit there, not here
PATHS = load_paths()

#Path to dymola output directory of your choosing (relative to project root)
WD = "Output_3"
WD_abs = abs_wd(WD)


# Instantiate the Dymola interface and start Dymola
dymola = DymolaInterface()
print(dymola.DymolaVersion())

#open HYBRID with path to your HYBRID Library
dymola.openModel(PATHS["HYBRID_PACKAGE"])
#open TRANSFORM
dymola.openModel(PATHS["TRANSFORM_PACKAGE"])


#String of the model you wante to simulate
model = "NHES.Systems.BalanceOfPlant.RankineCycle.Examples.SteamTurbine_L1_boundaries_Test_a" 

#Modelica String Paths of the variables you want to investigate - always leave "Time" as first variable
variables = ["Time","BOP.sensorW.W","BOP.CS.TCV_opening_nominal", "BOP.valve_TCV.m_flow"]

#Open the model of interest
dymola.openModel(model)

#Set the Dymola working directory to where you want your dymola output
#This command just executes the string given in the dymola terminal so make sure you use speech marks not just apostrophes
dymola.ExecuteCommand('Modelica.Utilities.System.setWorkDirectory("'+ WD_abs +'")')

#define a logarithmic spacing of turbine control valve positions
openings = np.logspace(-2,0,10)

#create empty lists to hold average values
powers = []
mflows = []

# loop over TCV openings and rerun simulation
for opening in openings:
    #create dctionary to hold simulation results
    results = {}
    for key in variables:
        results[key] = []
        
    #translate the model
    dymola.translateModel(model)
    
    #change an input variable - ensure it can be changed by running a test command in the dymola command line
    var = "BOP.CS.TCV_opening_nominal ="+ str(opening)
    print(var)
    dymola.ExecuteCommand(var)

    #run the episode
    result = dymola.simulateModel(model, startTime=0, stopTime=300, numberOfIntervals=0, outputInterval=1, method="Esdirk45a",resultFile="PythonDymola");

    if not result:
        print("Simulation failed. Below is the translation log.")
        log = dymola.getLastErrorLog()
        print(log)
        dymola.exit(1)

    #get results and add to dictionary
    trajsize = dymola.readTrajectorySize(WD_abs + "/PythonDymola.mat")
    signals=dymola.readTrajectory(WD_abs + "/PythonDymola.mat", variables, trajsize)
  
    for i in range(0,len(variables),1):
        results[variables[i]].extend(signals[i])
        
    #take average of power and mass flow for interval of interest - 120-150s here
    average_power = np.mean(results["BOP.sensorW.W"][125:155])
    average_mflow = np.mean(results["BOP.valve_TCV.m_flow"][125:155])
    
    #add these results to storage list
    powers.append(average_power)
    mflows.append(average_mflow)
    
    #plot episode trajectory        
    plt.plot(results["Time"],results["BOP.sensorW.W"], label = "Power Output")
    plt.grid(linestyle=':')
    plt.xlabel("Time / s")
    plt.ylabel("Power / W")
    plt.show()
    
#Plot parameteric analysis
plt.plot(mflows,powers, '-x')
plt.grid(linestyle=':')
plt.xlabel("Turbine Inlet Mass Flow Rate / kg/s")
plt.ylabel("Power / W")
plt.savefig(WD + "/Parametric_Run.png")
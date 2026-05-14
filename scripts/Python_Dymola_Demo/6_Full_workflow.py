from dymola.dymola_interface import DymolaInterface
import matplotlib.pyplot as plt
from modelica_builder.model import Model
import numpy as np
import os
import sys
from path_config import load_paths, abs_wd

#External library locations live in paths.txt - edit there, not here
PATHS = load_paths()

#Path to dymola output directory of your choosing (relative to project root)
WD = "Output_6"
WD_abs = abs_wd(WD)


# Instantiate the Dymola interface and start Dymola
dymola = DymolaInterface()
print(dymola.DymolaVersion())

#open HYBRID with path to your HYBRID Library
#dymola.openModel(PATHS["HYBRID_PACKAGE"])
#open TRANSFORM
#dymola.openModel(PATHS["TRANSFORM_PACKAGE"])


#String of the model you wante to simulate
model_path = "Output_6/DrumBoiler2.mo"

model = Model(model_path)

# do read and modify the model
# refer to modelica_builder.model.Model class methods to see what's available
name = model.get_name()
model.set_name('New' + name)
model.edit_connect('levelSetPoint.y', 'feedback.u1', 'levelSetPoint_2.y', 'feedback.u1')


# save the result
model.save_as('Output_6/DrumBoiler3.mo')

#String of the model you wante to simulate
model_path_2 = "Output_6/DrumBoiler3.mo"


#Modelica String Paths of the variables you want to investigate - always leave "Time" as first variable
variables = ["Time","pressure.p","evaporator.V_l"]

#Open the model of interest
dymola.openModel(model_path_2)

dymola.openModel("NewDrumBoiler2")

#Set the Dymola working directory to where you want your dymola output
#This command just executes the string given in the dymola terminal so make sure you use speech marks not just apostrophes
dymola.ExecuteCommand('Modelica.Utilities.System.setWorkDirectory("'+ WD_abs +'")')

#Simulate the model - can specify start and end and either number of intervals of output interval (set other one to zero). Specify name of results file
result = dymola.simulateModel("NewDrumBoiler2", startTime=0, stopTime=300, numberOfIntervals=0, outputInterval=1, method="Esdirk45a",resultFile="PythonDymola")

#Make a Python dictionary to hold all the results base on variables in variables list
results = {}
for key in variables:
         results[key] = []

#read the .Mat file's size and then write the variables to a list
trajsize = dymola.readTrajectorySize(WD_abs + "/PythonDymola.mat")
signals=dymola.readTrajectory(WD_abs + "/PythonDymola.mat", variables, trajsize)

#add the result signals to the results dictonary
for i in range(0,len(variables),1):
    results[variables[i]].extend(signals[i])


def plot_variable(time_data, variable_data, xlabel, ylabel, title, filename):
    """
    Plot a single variable against time and save to file.

    Parameters:
    -----------
    time_data : list or array
        Time values for x-axis
    variable_data : list or array
        Variable values for y-axis
    xlabel : str
        Label for x-axis
    ylabel : str
        Label for y-axis
    title : str
        Plot title
    filename : str
        Filename to save the plot (e.g., 'output.png')
    """
    fig, ax = plt.subplots(figsize=(9, 6))
    ax.plot(time_data, variable_data, 'b.-')
    ax.grid(linestyle=':')
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.set_title(title)
    plt.tight_layout()
    plt.savefig(filename)
    plt.close()
    print(f"Plot saved to {filename}")


#plot the power
fig, ax1 = plt.subplots(figsize=(9, 6))
ax1.plot(results["Time"],results["pressure.p"],  'r.-')
ax1.grid(linestyle=':')
ax1.set_xlabel("Time / s")
ax1.set_ylabel("Pressure / Pa")
plt.savefig('Output_6/Pressure.png')

# Plot the drum boiler level using the plotting function
plot_variable(
    time_data=results["Time"],
    variable_data=results["evaporator.V_l"],
    xlabel="Time / s",
    ylabel="Liquid Volume / m³",
    title="Drum Boiler Level",
    filename="Output_6/DrumBoilerLevel.png"
)

print()


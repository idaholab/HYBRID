#Licensed under Apache 2.0 License.
#© 2020 Battelle Energy Alliance, LLC
#ALL RIGHTS RESERVED
#.
#Prepared by Battelle Energy Alliance, LLC
#Under Contract No. DE-AC07-05ID14517
#With the U. S. Department of Energy
#.
#NOTICE:  This computer software was prepared by Battelle Energy
#Alliance, LLC, hereinafter the Contractor, under Contract
#No. AC07-05ID14517 with the United States (U. S.) Department of
#Energy (DOE).  The Government is granted for itself and others acting on
#its behalf a nonexclusive, paid-up, irrevocable worldwide license in this
#data to reproduce, prepare derivative works, and perform publicly and
#display publicly, by or on behalf of the Government. There is provision for
#the possible extension of the term of this license.  Subsequent to that
#period or any extension granted, the Government is granted for itself and
#others acting on its behalf a nonexclusive, paid-up, irrevocable worldwide
#license in this data to reproduce, prepare derivative works, distribute
#copies to the public, perform publicly and display publicly, and to permit
#others to do so.  The specific term of the license can be identified by
#inquiry made to Contractor or DOE.  NEITHER THE UNITED STATES NOR THE UNITED
#STATES DEPARTMENT OF ENERGY, NOR CONTRACTOR MAKES ANY WARRANTY, EXPRESS OR
#IMPLIED, OR ASSUMES ANY LIABILITY OR RESPONSIBILITY FOR THE USE, ACCURACY,
#COMPLETENESS, OR USEFULNESS OR ANY INFORMATION, APPARATUS, PRODUCT, OR
#PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE WOULD NOT INFRINGE PRIVATELY
#OWNED RIGHTS.
"""
  Author:  A. S. Epiney
  Date  :  12/01/2016
"""

# This file contains the generation of the time dependent data for Renewable and electricity demand
import numpy as np
import pickle

# =====================================================================================================================
def _readMoreXML(self,xmlNode):
  self.ARMAPosPparams = {}
  for child in xmlNode:
    if child.tag == "ARMAPosP":
      # get verbosity if it exists
      if 'verbosity' in child.attrib:
        if isInt(child.attrib['verbosity']):
          self.ARMAPosPver = int(child.attrib['verbosity'])
        else:
          raise IOError("ARMA Post-processor ERROR (XML reading): 'verbosity' in 'ARMAPosP'  needs to be an integer'")
      else:
        self.ARMAPosPver = 100 # errors only
      if self.ARMAPosPver < 100:
        print "ARMA Post-processor INFO (XML reading): verbosity level: %s" %self.ARMAPosPver
      recursiveXmlReader(child, self.ARMAPosPparams)
# =====================================================================================================================

# =====================================================================================================================
def recursiveXmlReader(xmlNode, inDictionary):
  # treat tags
  # - - - - - - - - - - - - - - - - - - -
  xmlNodeName = xmlNode.tag
  if xmlNodeName in inDictionary.keys():
    raise IOError("ARMA Post-processor ERROR (XML reading): XML Tags need to be unique (cant be 'attr' or 'val'): %s" %xmlNodeName)
  inDictionary[xmlNodeName] = {'val':xmlNode.text,'attr':xmlNode.attrib}
  # recursion
  # - - - - - - - - - - - - - - - - - - -
  if len(list(xmlNode)) > 0:
    for child in xmlNode:
      recursiveXmlReader(child, inDictionary[xmlNodeName])
# =====================================================================================================================

# =====================================================================================================================
def isInt(str):
  try:
    int(str)
    return True
  except:
    return False
# =====================================================================================================================

# =====================================================================================================================
def isReal(str):
  try:
    float(str)
    return True
  except:
    return False
# =====================================================================================================================

# =====================================================================================================================
def initialize(self, runInfoDict, inputFiles):
  # check if needed XML inputs exist
  if 'ARMAPosP' not in self.ARMAPosPparams.keys():
    raise IOError("ARMA Post-processor ERROR (XML reading): <ARMAPosP> node is required")

  # check if Demand exists
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if 'Demand' not in self.ARMAPosPparams['ARMAPosP'].keys():
    raise IOError("ARMA Post-processor ERROR (XML reading): <Demand> node is required inside 'ARMAPosP'")
  if 'mean' not in self.ARMAPosPparams['ARMAPosP']['Demand']['attr']:
    raise IOError("ARMA Post-processor ERROR (XML reading): <Demand> requires attribute 'mean'")
  if self.ARMAPosPver < 2:
    print "ARMA Post-processor INFO (XML reading): Deamnd mean is called '%s' and the time series '%s'" %(self.ARMAPosPparams['ARMAPosP']['Demand']['attr']['mean'],self.ARMAPosPparams['ARMAPosP']['Demand']['val'])

  # check if Renewable exists
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  if 'Renewable' not in self.ARMAPosPparams['ARMAPosP'].keys():
    raise IOError("ARMA Post-processor ERROR (XML reading): <Renewable> node is required inside 'ARMAPosP'")
  if 'component' not in self.ARMAPosPparams['ARMAPosP']['Renewable']['attr']:
    raise IOError("ARMA Post-processor ERROR (XML reading): <Renewable> requires attribute 'component'")
  if self.ARMAPosPver < 2:
    print "ARMA Post-processor INFO (XML reading): Renewable component is called '%s' and the corresponding time series '%s'" %(self.ARMAPosPparams['ARMAPosP']['Renewable']['attr']['component'],self.ARMAPosPparams['ARMAPosP']['Renewable']['val'])

# =====================================================================================================================

# =====================================================================================================================
def run(self, Inputs):

  if self.ARMAPosPver < 1:
    print "ARMA Post-processor INFO (run): Inside ARMA Post-processor"

  # check if needed variables exist in input space
  #= = = = = = = = = = = = = = = = = = = = = = = = =
  # <Demand 'mean'>
  Demand_mean = self.ARMAPosPparams['ARMAPosP']['Demand']['attr']['mean']
  if Demand_mean not in Inputs:
    raise IOError("ARMA Post-processor ERROR (run): '%s' not in inputs (from RAVEN) of Post-Processor, but requested in input node <Demand> attribute 'component'" %(Demand_mean))
  # <Demand> Timeseries
  Demand_name = self.ARMAPosPparams['ARMAPosP']['Demand']['val']
  if Demand_name not in Inputs:
    raise IOError("ARMA Post-processor ERROR (run): '%s' not in inputs (from RAVEN) of Post-Processor, but requested in input node <Demand>" %(Demand_name))
  # <Renewable 'component'>_capacity
  Renewable_name_compo = self.ARMAPosPparams['ARMAPosP']['Renewable']['attr']['component']
  if Renewable_name_compo + "_capacity"  not in Inputs:
    raise IOError("ARMA Post-processor ERROR (run): '%s' not in inputs (from RAVEN) of Post-Processor, but requested in input node <Renewable> attribute 'component'" %(Renewable_name_compo + "_capacity"))
  # <Renewable> Timeseries
  Renewable_name = self.ARMAPosPparams['ARMAPosP']['Renewable']['val']
  if Renewable_name not in Inputs:
    raise IOError("ARMA Post-processor ERROR (run): '%s' not in inputs (from RAVEN) of Post-Processor, but requested in input node <Renewable>" %(Renewable_name))

# Treat Demand
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
  self.Demand # DEBUGG checking that it's here
  if self.ARMAPosPver < 2:
    print "ARMA Post-processor INFO (run): Treating Demand"
  setattr(self, Demand_name + "_time", Inputs[Demand_name])
  mean_demand = sum(getattr(self, Demand_name + "_time"))/len(getattr(self, Demand_name + "_time"))
  if self.ARMAPosPver < 1:
    print "                                Scaling factor for demand [W]  : %s" %Inputs[Demand_mean]
    print "                                Demand: %s" %getattr(self, Demand_name + "_time")
    print "                                Lenght of data    : %s" %len(getattr(self, Demand_name + "_time"))
  if self.ARMAPosPver < 2:
    print "                                Mean of data [W]  : %s" %mean_demand

# Treat Renewable
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
  if self.ARMAPosPver < 2:
    print "ARMA Post-processor INFO (run): Treating Renewable"
    print "                                WIND is currently used"
    print "                                The WIND model is coded in ARMAPosP.py"
  # Transform wind speed into energy
  # Wind to Turbine EWnergy relationship (for 1 wind turbine) [From Nuclear Hybrid Energy Systems - Regional Studies: West Texas & Northeastern Arizona, INL/EXT-15-34503 page 51]
  cut_in_speed   = 3  # m/s
  cut_out_speed  = 25 # m/s
  nominal_1turb  = 3600000 # W

  para_n = 0.35     # [%]    Conversion efficiency of the wind turbine
  para_r = 1.17682  # [g/m3] Density of the air at the site
  para_d = 90       # [m]    Diameter of the turbine blades

  if self.ARMAPosPver < 1:
    print "ARMA Post-processor INFO (run): Wind input => Energy output (1 turbine)"
  my_windEL = []
  for wind in Inputs[Renewable_name]:
    # cut-off
    if wind < cut_in_speed or wind > cut_out_speed:
      my_windEL.append(0.0)
    else:
      ren_curve = 0.5 * para_n * para_r * (wind**3) * (3.1415 * (para_d**2) / 4)
      my_windEL.append(min(nominal_1turb, ren_curve))
    if self.ARMAPosPver < 1:
      print "                          Wind, Energy: %s, %s" %(wind, my_windEL[-1])

  # scale the renewable production to the renewable capacity
  my_windELscale = my_windEL * ((Inputs[Renewable_name_compo + "_capacity"]/100.0 * mean_demand) / nominal_1turb)
  setattr(self, Renewable_name_compo + "_DYMO_productionEL", np.array(my_windELscale))
  if self.ARMAPosPver < 1:
    print "                                Renewable capacity [%%]: %s" %Inputs[Renewable_name_compo + "_capacity"]
    xxx = Inputs[Renewable_name_compo + "_capacity"]/100.0*mean_demand
    print "                                Renewable capacity [W]: %s" %xxx
    print "                                Lenght of data        : %s" %len(getattr(self, Renewable_name_compo + "_DYMO_productionEL"))
  if self.ARMAPosPver < 2:
    print "                                Mean of data [W]      : %s" %(sum(getattr(self, Renewable_name_compo + "_DYMO_productionEL"))/len(getattr(self, Renewable_name_compo + "_DYMO_productionEL")))

# NET DEMAND  sbstract excluded components from demand
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
  if self.ARMAPosPver < 2:
    print "ARMA Post-processor INFO (run): Computing Net demand => Removing '%s' from '%s' to compute NET demand" %(Renewable_name_compo, Demand_name + "_time")
  my_tempDEM = []
  if self.ARMAPosPver < 1:
    print "ARMA Post-processor INFO (run): '%s' capacity in [%%]: %s" %(Renewable_name_compo, getattr(self,Renewable_name_compo + "_capacity")[0])
    xxx = getattr(self,Renewable_name_compo + "_capacity")[0]/100.0 * mean_demand
    print "                                              in [W]: %s" %xxx
  for hour in range(0, len(getattr(self,Renewable_name_compo + "_DYMO_productionEL"))):
    # the utilisation is the minimum of the capcatity or the timeseries
    if getattr(self,Renewable_name_compo + "_DYMO_productionEL")[hour] != 0:
      if (getattr(self,Renewable_name_compo + "_DYMO_productionEL")[hour] -  getattr(self,Renewable_name_compo + "_capacity")[0]/100.0 * mean_demand)/getattr(self,Renewable_name_compo + "_DYMO_productionEL")[hour] >  1E-6:

        raise IOError("ARMA ERROR (run): Renewanle production (%s) bigger than capacity (%s) for hour %s" %(getattr(self,Renewable_name_compo + "_DYMO_productionEL")[hour], getattr(self,Renewable_name_compo + "_capacity")[0]/100.0*mean_demand, hour))
    my_tempDEM.append(getattr(self,Demand_name + "_time")[hour]-getattr(self,Renewable_name_compo + "_DYMO_productionEL")[hour]) # this may be negative => the battery may pick this up
    if self.ARMAPosPver < 1:
      print "ARMA Post-processor INFO (run): Time: %s, Exclude compo value: %s" %(hour, getattr(self,Renewable_name_compo + "_DYMO_productionEL")[hour])
      print "                                Demand: %s, Net demand: %s" %(getattr(self,Demand_name + "_time")[hour], my_tempDEM[hour])
  setattr(self, Demand_name + "_time" + "_net", np.array(my_tempDEM))

# Generate time_delta
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
  self.time_delta = self.Time[1] - self.Time[0]
  print 'DEBUG AE time delta', self.time_delta

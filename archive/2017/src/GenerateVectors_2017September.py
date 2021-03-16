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

# This is the Dymols interface PreProcessor. It transorms data from RAVEN into Dymola interface readable information.
import numpy as np

# =====================================================================================================================
def initialize(self, runInfoDict, inputFiles):
  pass


# =====================================================================================================================
# Make vectors out of a point set:
def run(self, Inputs):
  """
    generates vectors from pointsets
    Inputs  :
    Outputs :
  """
  debugprint = False

  Input_exist = True
  x = 1
  Compo_ls = []
  Time_ls = []
  Time = 0.0
  dt = self.time_delta[0] # FIXME why does this have to have [0]??
  while Input_exist:
    Compo_ev = "Demand_time_net_" + '{:04d}'.format(x)
    if debugprint:
      print "GenerateVectors INFO (run): Looking for %s in Inputs" %Compo_ev
    if Compo_ev in Inputs.keys():
      Compo_ls.extend(Inputs[Compo_ev])
      Time_ls.append(Time)
      x += 1
      Time += dt
    else:
      if x == 0:
        raise IOError("GenerateVectors ERROR (run): Asked to Pre-process vector Demand_time_net_ , but is not in inputs")
      else:
        if debugprint:
          print "GenerateVectors INFO (run): Found %s time entries for Demand_time_net" %(x)
      Input_exist = False
  setattr(self, "Demand_time_net", np.array(Compo_ls))
  setattr(self, "Time", np.array(Time_ls))
  if debugprint:
    print "Results of GenerateVectors:"
    print "  Demand_time_net"
    print " ",self.Demand_time_net
    print "  Time"
    print " ",self.Time
    print ''


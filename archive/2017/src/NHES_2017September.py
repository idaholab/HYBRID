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
  Date  :  XX/XX/20XX
"""

# This is a dymola pass throug
import numpy as np

# =====================================================================================================================
def initialize(self, runInfoDict, inputFiles):
  pass

# =====================================================================================================================
def run(self, Inputs):

  # generate time in seconds
  self.DYMOTime = np.linspace(0, self.Start_time[0] + self.DYMOLA_tot_time[0] - 1, self.Start_time[0] + self.DYMOLA_tot_time[0])
  dt = self.time_delta[0]

  # genreate needed power outputs
  BOP_DYMO_productionEL = []
  SES_DYMO_productionEL = []
  ES_DYMO_productionEL = []
  IP_DYMO_productionEL = []
  Grid_DYMO_productionEL = []
  IP_DYMO_productionBY = []
  production_coefficient = (self.IP_KG) / (self.IP_EL*1000000)    # 51.1452MW electric (and 18.4794MW thermal) produces 0.401461kg/s of H2  [kg/s/W]
  for seconds in self.DYMOTime :
    if seconds < self.Start_time :
      # fill with zeros before starting time
      BOP_DYMO_productionEL.append(0.0)
      SES_DYMO_productionEL.append(0.0)
      ES_DYMO_productionEL.append(0.0)
      IP_DYMO_productionEL.append(0.0)
      Grid_DYMO_productionEL.append(0.0)
      IP_DYMO_productionBY.append(0.0)
    else:
      ## OLD way, hard-coded to hours
      # which hour is this?
      #hour = int((seconds - self.Start_time)/3600)
      #time_in_hour = (seconds - self.Start_time) - hour * 3600
      #if len(self.Demand_time_net) < hour :

      ## NEW way, generic time units (still based on seconds, though, and assuming integer number of seconds)
      time_unit = int((seconds - self.Start_time)/dt)
      time_in_unit = (seconds - self.Start_time) - time_unit * dt
      if len(self.Demand_time_net) < time_unit :
        print "ERROR: No net demand generated for time unit %s, but dymola symulation" %time_unit
        quit() # bey bey without saying anything, nice!

      a = (self.BOP_SAMP_productionEL[time_unit+1] - self.BOP_SAMP_productionEL[time_unit]) / dt
      b = self.BOP_SAMP_productionEL[time_unit]
      BOP_DYMO_productionEL.append(a * time_in_unit + b)

      a = (self.SES_SAMP_productionEL[time_unit+1] - self.SES_SAMP_productionEL[time_unit]) / dt
      b = self.SES_SAMP_productionEL[time_unit]
      SES_DYMO_productionEL.append(a * time_in_unit + b)

      a = (self.ES_SAMP_productionEL[time_unit+1] - self.ES_SAMP_productionEL[time_unit]) / dt
      b = self.ES_SAMP_productionEL[time_unit]
      ES_DYMO_productionEL.append(a * time_in_unit + b)

      a = (self.IP_SAMP_productionEL[time_unit+1] - self.IP_SAMP_productionEL[time_unit]) / dt
      b = self.IP_SAMP_productionEL[time_unit]
      IP_DYMO_productionEL.append(-1.0 * (a * time_in_unit + b))

      Grid_DYMO_productionEL.append(-1.0 *(BOP_DYMO_productionEL[-1] + SES_DYMO_productionEL[-1] + ES_DYMO_productionEL[-1] + IP_DYMO_productionEL[-1]))

      # hydrogen production rate [kg/s]
      # ===================================================
      IP_DYMO_productionBY.append(production_coefficient * IP_DYMO_productionEL[-1] * -1.0)

  self.BOP_DYMO_productionEL = np.array(BOP_DYMO_productionEL)
  self.SES_DYMO_productionEL = np.array(SES_DYMO_productionEL)
  self.ES_DYMO_productionEL = np.array(ES_DYMO_productionEL)
  self.IP_DYMO_productionEL = np.array(IP_DYMO_productionEL)
  self.Grid_DYMO_productionEL = np.array(Grid_DYMO_productionEL)
  self.IP_DYMO_productionBY = np.array(IP_DYMO_productionBY)


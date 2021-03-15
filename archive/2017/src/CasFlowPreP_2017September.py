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

# This file contains the post processor to format and process data from the Dispatch output to the NPV model
import numpy as np
import math
import penalty_function as Penalty

# =====================================================================================================================
def initialize(self, runInfoDict, inputFiles):
  pass

# =====================================================================================================================
def run(self, Inputs):

  printdebug = False        # False=no debug printing, True=all debug printing

  start_time = self.Start_time # steady state time in seconds (should be set to 2 hours = 7200s for production calcs)
  # Find starttime index
  # =========
  for starthere in xrange(len(self.DYMOTime)) :
    if self.DYMOTime[starthere] > start_time :
      break
  if printdebug :
    print "Cash_Flow prep sharthere : %s" %starthere
  if starthere == len(self.DYMOTime) :
    print "ERROR Cash_Flow preprocessor... start time bigger output time from DYMOLA"

  # The modelica convention for power is for all components:
  # ===> to the compoennt negative (-)
  # <=== from the componet positive (+)

  # BOP
  # =========
  ELint = 0
#  print "BOP"
#  print self.BOP_DYMO_productionEL
  for i in xrange(starthere,len(self.BOP_DYMO_productionEL)) :
    ELint += self.BOP_DYMO_productionEL[i] * (self.DYMOTime[i] - self.DYMOTime[i-1])
  BOP_capafact = ELint/(float(self.BOP_capacity) * (self.DYMOTime[-1] - self.DYMOTime[starthere]))
  self.BOP_TOT_productionEL = BOP_capafact * float(self.BOP_capacity) * 8760
  if printdebug:
    print "DEBUGG, BOP ",  self.BOP_TOT_productionEL

  # ES
  # =========
  ELint = 0
#  print "ES"
#  print self.ES_DYMO_productionEL
  for i in xrange(starthere,len(self.ES_DYMO_productionEL)) :
    ELint += self.ES_DYMO_productionEL[i] * (self.DYMOTime[i] - self.DYMOTime[i-1])
  ES_capafact = ELint/(float(self.ES_capacity) * (self.DYMOTime[-1] - self.DYMOTime[starthere]))
  self.ES_TOT_productionEL = ES_capafact * float(self.ES_capacity) * 8760
  if printdebug:
    print "DEBUGG, ES  ",  self.ES_TOT_productionEL

  # SES
  # =========
  ELint = 0
#  print "SES"
#  print self.SES_DYMO_productionEL
  for i in xrange(starthere,len(self.SES_DYMO_productionEL)) :
    ELint += self.SES_DYMO_productionEL[i] * (self.DYMOTime[i] - self.DYMOTime[i-1])
  SES_capafact = ELint/(float(self.SES_capacity) * (self.DYMOTime[-1] - self.DYMOTime[starthere]))
  self.SES_TOT_productionEL = SES_capafact * float(self.SES_capacity) * 8760
  if printdebug:
    print "DEBUGG, SES  ",  self.SES_TOT_productionEL

  # IP
  # =========
  ELint = 0
  H2int = 0
#  print "IP"
#  print self.IP_DYMO_productionEL
  for i in xrange(starthere,len(self.IP_DYMO_productionEL)) :
    ELint += self.IP_DYMO_productionEL[i] * (self.DYMOTime[i] - self.DYMOTime[i-1])
    H2int += self.IP_DYMO_productionBY[i] * (self.DYMOTime[i] - self.DYMOTime[i-1])
  IP_capafact = ELint/(float(self.IP_capacity) * (self.DYMOTime[-1] - self.DYMOTime[starthere]))
  self.IP_TOT_productionEL = IP_capafact * float(self.IP_capacity) * 8760

  self.IP_TOT_revenueBY = H2int /(self.DYMOTime[-1] - self.DYMOTime[starthere]) * 8760 * 3600 * self.H2_price
  self.IP_TOT_productionBY = H2int /(self.DYMOTime[-1] - self.DYMOTime[starthere]) * 8760 * 3600
  if printdebug:
    print "DEBUGG, IP EL  ",  self.IP_TOT_productionEL
    print "DEBUGG, IP BY  ",  self.IP_TOT_revenueBY
    print "DEBUGG, IP rev BY  ",  self.IP_TOT_productionBY

  # The Industrial Process fixed O&M depend on the capacity factor of the plant
#  max_kg_year = (0.401461*3600) / ((51.1452 + 18.4794)*1000000) * self.IP_capacity * 8760
#  capacity_factor = Tot_proBY / max_kg_year
#  self.IPOMfix = 0.0618 * capacity_factor ** (-0.986) * Tot_proBY

  # some useful values for plootting
  #self.IP_capa_fact = capacity_factor
  #max_EL_year = self.BOP_capacity * 8760  # in Wh
  #self.BOP_capa_fact = Tot_proEL / max_EL_year

  # compute over and underproduction penalty
  # The modelica convention for power is for all components:
  # ===> to the compoennt negative (-)
  # <=== from the componet positive (+)

  # for the Switchyard (SY), this means that power to the SY, i.e. to the grid is negative (-)

  self.Imbalance_Price = 0.0
  dt = self.time_delta[0]
  time_unit = 0
  more_data = True
  self.cum_missed_demand = 0.0
  DEMAND_TOT_productionEL = 0.0
  while more_data:
    startindex = np.searchsorted(self.DYMOTime, start_time + time_unit * dt)[0]
    endindex = np.searchsorted(self.DYMOTime, start_time + (time_unit+1) * dt)[0]
    avgW = -1.0 * np.average(self.Grid_DYMO_productionEL[startindex:endindex]) # from SY, the power to grid is negative. (see comment above)
    # check if there is still demand for this time unit
    if len(self.Demand_time_net) < time_unit :
      print "ERROR: No net demand generated for time unit %s, but dymola symulation" %time_unit
      quit() # bey bey without saying anything, nice!
    DEMAND_TOT_productionEL += self.Demand_time_net[time_unit]
    missed_demand = self.Demand_time_net[time_unit] - avgW
    self.cum_missed_demand += missed_demand
    self.Imbalance_Price += Penalty.evaluate(missed_demand)
    time_unit += 1
    if endindex == len(self.DYMOTime) :
      more_data = False

  # scale to 1 year
  self.Imbalance_Price = -1.0 * self.Imbalance_Price / (self.DYMOTime[-1] - self.DYMOTime[starthere]) * 8760 * 3600 * self.Penalty_mult
  self.DEMAND_TOT_productionEL = DEMAND_TOT_productionEL / (self.DYMOTime[-1] - self.DYMOTime[starthere]) * 8760 * 3600
  if printdebug:
    print "DEBUGG, Imb Price  ",  self.Imbalance_Price
    print "DEBUGG, DEMAND_TOT_productionEL  ",  self.DEMAND_TOT_productionEL

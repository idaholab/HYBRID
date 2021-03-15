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

# =====================================================================================================================
def initialize(self, runInfoDict, inputFiles):
  pass

# =====================================================================================================================
def run(self, Inputs):

  #PriceH2 = 1.7   # $/kg   !!! The price is also hardcoded in dispatch.py

  # Revenues
  Tot_revEL  = 0.0
  Tot_proEL  = 0.0
  Tot_revBY  = 0.0
  Tot_proBY  = 0.0
  Tot_costEL = 0.0
  Tot_usedEL = 0.0
  for hour in xrange(len(self.Price)):
    Tot_revEL  += self.BOP_DYMO_productionEL[hour] * self.Price[hour]/1000000
    Tot_proEL  += self.BOP_DYMO_productionEL[hour]
    Tot_revBY  += self.IP_DYMO_productionBY[hour] * self.PriceH2
    Tot_proBY  += self.IP_DYMO_productionBY[hour]
    Tot_costEL += self.IP_DYMO_productionEL[hour] * self.Price[hour]/1000000
    Tot_usedEL += self.IP_DYMO_productionEL[hour]

  self.BOP_TOT_revenueEL = Tot_revEL
  self.IP_TOT_revenueBY = Tot_revBY
  self.IP_TOT_productionBY = Tot_proBY
  self.IP_TOT_costEL = Tot_costEL
  self.IP_TOT_usedEL = Tot_usedEL

  # The Industrial Process fixed O&M depend on the capacity factor of the plant
  max_kg_year = (0.401461*3600) / ((51.1452 + 18.4794)*1000000) * self.IP_capacity * 8760
  capacity_factor = Tot_proBY / max_kg_year
  self.IPOMfix = 0.0618 * capacity_factor ** (-0.986) * Tot_proBY  # Fit of table 5 economics report
#  print "IP capa %s " %self.IP_capacity
#  print "mak kg year %s" %max_kg_year
#  print "capacity_factor %s" %capacity_factor
#  print "self.IPOMfix  %s" %self.IPOMfix

  # some useful values for plootting
  self.IP_capa_fact = capacity_factor
  max_EL_year = self.BOP_capacity * 8760  # in Wh
  self.BOP_capa_fact = Tot_proEL / max_EL_year


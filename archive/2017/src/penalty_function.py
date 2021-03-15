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
  Date  :  08/19/2017
"""

# This file contains the penalty function for the missed demand

import numpy as np
import math


def evaluate(missed_demand): # Wh / hr
  missed_demandMWabs = np.absolute(missed_demand) / 1e6 # MWh
  max_imbalance_price = 400.0*missed_demandMWabs # based roughly on penalty for min LCoE of original function
  try:
    Imbalance_Price = np.array([12.0*1.0*missed_demandMWabs * 0.4699*math.exp(1.0141*missed_demandMWabs/12)]) #Missed demand penalty function from INL/EXT-17-41915 
  except OverflowError:
    print "Penalty function (evaluate) ERROR: System imbalance hits maximum!"
    Imbalance_Price = np.array([1e255])
 
  if Imbalance_Price > max_imbalance_price:
    Imbalance_Price = max_imbalance_price
  return Imbalance_Price
#

if __name__ == '__main__':
  import matplotlib.pyplot as plt
  numsamples = 10e3
  y = np.zeros(numsamples)
  xs = np.linspace(-300e6, 300e6, numsamples)
  for i,x in enumerate(xs):
    y[i] = evaluate(x)
  
  plt.plot(xs,y)
  plt.show()

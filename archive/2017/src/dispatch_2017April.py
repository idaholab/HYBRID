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
created on Wed March 29 2017
@author: A. Epiney
"""

# This file contains an external cost model of a nuclear-renewble hybrid energy system.

import numpy as np
import scipy.optimize as opt


def initialize(self, runInfoDict, inputFiles):

    pass

def myprofit(x, eff, Capacity_el, P_el, costfix_el, costvar_el, P_H2, costfix_H2, costvar_H2):   # x is the fraction of BOP capacity (in W electric or thermal, its the same) for H2 production
    # electricity produced in 1 h in [Wh]
    # ===================================================
    Wel   = (1-x) * Capacity_el * 1.0

    # hydrogen produced in 1 h in [kg]
    # ===================================================
    production_coefficient = (0.401461*3600) / (18.4794*1000000)    # 51.1452MW electric and 18.4794MW thermal produces 0.401461kg/s of H2  ==> production_coefficient should be in kgH2/h/W_thermal
    kgH2  =  x * (Capacity_el/eff) *  production_coefficient  * 1.0
    #             thermal energy      kgH2/h/W thermal energy   time
    # electricity need by the IP for this amount of thermal energy
    ELH2  = x * (Capacity_el/eff)  *   (51.1452/18.4794)               * 1.0
    #            thermal energy         electric energy/thermal energy   time 

    # profit
    profit = P_el * Wel - costfix_el - costvar_el * Wel + P_H2 * kgH2 - costfix_H2 - costvar_H2 * kgH2 - P_el * ELH2
    #        (    BOP cash flow                       ) + (   IP cash flow                             - cost of electricity bought by IP)
    return -1.0 * profit


def run(self, Inputs):
    

    debug_print = False

    # ------------------------------------------------------------------------------
    # initialize arrays to store the output variables.
    self.BOP_DYMO_productionEL = np.zeros(len(self.Price))
    self.BOP_DYMO_productionBY = np.zeros(len(self.Price))

    self.IP_DYMO_productionEL = np.zeros(len(self.Price))
    self.IP_DYMO_productionBY = np.zeros(len(self.Price))
    
    # ------------------------------------------------------------------------------
    # for each hour in the price profile, find optimium dispatch between BOP and IP

    for hour in xrange(len(self.Price)):
        # construct profit function for that hour
        # everything is experssed in power 

        eff         = 0.31                                               # Thermal efficienty of BOP

        P_el        = self.Price[hour]/1000000                           # price of electricity in $/Wh(electric)
        # The reactor is assumed to work at 100% all the time
        # => the differential of production 0% electricity or 100% electricity (marginal profit) is zero (for fixed and varia)
        costfix_el  = 0.0                                                # The fixed cost for producing electricity
        costvar_el  = 0.0                                                # The variable cost for producing 1Wh of electricity

        P_H2        = self.PriceH2                                       # Price of H2 in $/kg
        xmax        = 1.0                                                # Max fraction of BOP capacity (in W electric or thermal, its the same) for H2 production  (assume unlimited capacity of IP)
        # => the differential of production 0% H2 or 100% H2 (margial profit) is zero for the fixed cost
        costfix_H2  = 0.0                                                # The cost of producing H2
        costvar_H2  = 0.048                                              # The cost of producing 1kg of H2 (w/o electricity cost)

        # 1. Reactor: produce electricity or supply H2 plant with steam?
        # ===========================================================================================
        if debug_print:
          print "Dispatch (run): Next hour --------------------------------"

        # compare profit (for a given hour) for the reactor of producing ELECRICITY or providing STEAM
        profit_opt = opt.minimize_scalar(myprofit, bounds=[0,xmax], args=(eff, self.BOP_capacity, P_el, costfix_el, costvar_el, P_H2, costfix_H2, costvar_H2), method='bounded')
        if not profit_opt.success:
          raise IOError("Dispatch (run): optimiser did not find solution...")
        # the optimisation tries to find the oprtimal fraction of BOP capacity for H2 production. Since we compare marginal profit, the solution is always eighter x=1.0 or x=0.0. Intermediated values should not exist.
        if profit_opt.x > 0.01 and profit_opt.x < 0.99:
          print "Dispatch (run): The optimum for this hour is of IP: %s" %profit_opt.x
          raise IOError("Dispatch (run): optimiser solution is not 0.0 or 1.0. This should not happen. Please check your dispatch model")
        if debug_print:
          print "Dispatch (run): Electricity price for this hour is [$/Wh] : %s" %P_el
          print "Dispatch (run): The optimum for this hour is  (percent BOP for H2 production) : %s" %profit_opt.x

        # produce elecrtricity
        if profit_opt.x < 0.01:
          self.BOP_DYMO_productionEL[hour] = self.BOP_capacity  * 1.0  # in [Wh]
          self.IP_DYMO_productionBY[hour]  = 0.0                       # in [kg]
          IP_capacity_used = 0.0  # in W total 
          self.IP_DYMO_productionEL[hour] = 0.0 # in Wh
          if debug_print:
            print "Dispatch (run): Producing electricity only"
            print "Dispatch (run): The BOP  electricity  : %s" %self.BOP_DYMO_productionEL[hour]
            print "Dispatch (run): The H2 produced are   : %s" %self.IP_DYMO_productionBY[hour]
            print "Dispatch (run): The H2 electricity    : %s" %self.IP_DYMO_productionEL[hour]

        # provide steam
        else:
          # maximum steam possible according to IP capacity (in W total)
          IP_thermal_fraction = 18.4794/(51.1452 + 18.4794)
          max_steam = self.IP_capacity * IP_thermal_fraction # in [W]
          nuc_steam = min(max_steam, self.BOP_capacity/eff)   # in [W] thermal

          # Produce hydrogen
          production_coefficient = (0.401461*3600) / (18.4794*1000000)    # 51.1452MW electric and 18.4794MW thermal produces 0.401461kg/s of H2  ==> production_coefficient should be in kgH2/h/W_thermal
          self.IP_DYMO_productionBY[hour]  =  nuc_steam *      production_coefficient   * 1.0                       # in [kg]
          #                                   thermal energy   kgH2/h/W thermal energy    time
          # electricity need by the IP for this amount of thermal energy
          ELH2  = nuc_steam *            (51.1452/18.4794)               * 1.0
    #             thermal energy         electric energy/thermal energy   time
          # electricity produced by nuc (after providing steam to IP)
          ELnuc = (self.BOP_capacity/eff - nuc_steam) * eff
          if ELnuc >= ELH2:
            # in this case, Nuc provides all electricity for IP and sells the rest to the grid
            self.IP_DYMO_productionEL[hour] = 0.0 # in Wh
            IP_capacity_used = nuc_steam + ELH2  # in W total 
            self.BOP_DYMO_productionEL[hour] = (ELnuc - ELH2) * 1.0  # in [Wh]
          else:
            # in this case, Nuc provides part of the electricity (or none)  for the IP. The IP buys the rest of the electricity from the grid
            self.IP_DYMO_productionEL[hour] = (ELH2 - ELnuc) * 1.0  # in Wh
            IP_capacity_used = nuc_steam + ELH2  # in W total 
            self.BOP_DYMO_productionEL[hour] = 0.0  # in [Wh]
          if debug_print:
            print "Dispatch (run): Producing steam"
            print "Dispatch (run): The BOP  steam        : %s" %nuc_steam
            print "Dispatch (run): The BOP  electricity  : %s" %self.BOP_DYMO_productionEL[hour]
            print "Dispatch (run): The H2 produced are   : %s" %self.IP_DYMO_productionBY[hour]
            print "Dispatch (run): The H2 electricity    : %s" %self.IP_DYMO_productionEL[hour]


        # 2. H2 plant: Buy electricity from grid if there is leftover capacity?
        # ===========================================================================================
        if IP_capacity_used < self.IP_capacity:
          # buy electricity to produce more?
          # we assume that the electricity and thermal energy have the same efficienty for heating steam in the IP plant...  this is an OK assumption
          # check profit
          IP_capacity_left = self.IP_capacity - IP_capacity_used
          production_coefficient = (0.401461*3600) / ((51.1452+18.4794)*1000000)    # 51.1452MW electric and 18.4794MW thermal produces 0.401461kg/s of H2  ==> production_coefficient should be in kgH2/h/W_total
          H2_profit = IP_capacity_left * production_coefficient * 1.0   * (P_H2 - costvar_H2)  - costfix_H2  - IP_capacity_left * 1.0 * P_el
          #           energy             kg/h/W                   time    (price - cost)                     - electricity from grid cost
          if debug_print:
            print "Dispatch (run): IP profit for buying grid electricity : %s" %H2_profit
            print "Dispatch (run):                      IP_capacity_left : %s" %IP_capacity_left

          if H2_profit > 0.0:
            self.IP_DYMO_productionBY[hour] += IP_capacity_left * production_coefficient * 1.0
            self.IP_DYMO_productionEL[hour] += IP_capacity_left

            if debug_print:
              print "Dispatch (run): IP is buying grid electricity "
              print "Dispatch (run): IP_DYMO_productionBY: %s" %self.IP_DYMO_productionBY[hour]
              print "Dispatch (run): IP_DYMO_productionEL: %s" %self.IP_DYMO_productionEL[hour]

          # run 20 points to check
          #for i in xrange(20):
          #    x = i * xmax/19
          #    profit = -1.0 * myprofit(x, eff, self.BOP_capacity, P_el, costfix_el, costvar_el, P_H2, costfix_H2, costvar_H2) 
          #    print "x, profit : %s, %s" %(x, profit)


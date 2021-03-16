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
  Date  :  07/31/2017
"""

# This file contains the optimisation preconditioner based on marginal cost
import numpy as np
import xml.etree.ElementTree as ET
import Cash_Flow as NPV
import penalty_function as Penalty
import math


# =====================================================================================================================
def initialize(self,runInfoDict,inputFiles):
  # read the xml inputs from the NPV module
  notroot = ET.parse(file("../common_files/Cash_Flow_input.xml", 'r')).getroot()
  root = ET.Element('ROOT')
  root.append(notroot)
  dummy = NPV.CashFlow()
  dummy._readMoreXML(self, root)
  dummy.initialize(self,runInfoDict,inputFiles)


# =====================================================================================================================
# This will hopefully compute somethiung usefull
# Written by A. S. Epiney (1.8.2017)
# based on a simple dispatch rule (marginal cost plus battery as last resort)
def run(self, Inputs):
  """
    Preconditions the optimiser
    Inputs  :
    Outputs :
  """

  debugprint = False

  if debugprint:
    print "Inside Preconditioner Run"

  # initial battery charge
  bat_init = self.ES_capacity[0]
  # minimum IP
  IP_mini = 0.409737

  # dispatch rules
  # ===========================
  #  Since the reactor can not load follow, the energy bejont the powering of the IP (BOP-IP) must be dispatched as electricity
  #  Two scenarios exist:
  #  1. Net demand < BOP-IP
  #     BOP   : BOP-IP (minimum BOP)
  #     IP    : IP capacity
  #     SES   : 0
  #     ES    : charging to max THEN PENALTY
  #
  #  2. Net demand > BOP-IP
  #     BOP deploys BOP-IP
  #     =>  between BOP_capacity and BOP-IP, SES and BOP compete
  #      least marginal cost BOP (==> oppurtunity cost f not producing H2) and SES
  #     After BOP and SES deployed, Battery goes as last resort, THEN PENALTY

  # prepare needed data
  # ==================================
  N_hours = int(round(self.DYMOLA_tot_time / 3600)) + 1  # number of hours to analyse, i.e. lenght of dymola simulation         [h]
  Price_H2 = self.H2_price                               # Hydrogen price                                                       [$/kg]
  Pow2Capa_battery = self.Pow2Capa_battery               # Power/Capacity for battery     [W]/[Wh]                              [1/h]
  # BOP - IP
  BOP_eff = self.BOP_eff                                 # BOP thermal efficiency                                               [-]
  IP_EL = self.IP_EL                                     # IP nominal electricity usage                                         [MWel]
  IP_TH = self.IP_TH                                     # IP nominal steam usage                                               [MWth]
  IP_KG = self.IP_KG                                     # IP nominal H2 production                                             [kg/s]
  IP_th2el = IP_EL/IP_TH                                 # IP_EL MW_el are needed along with IP_TH MW_th                        [W_el/W_th]
  BOP_min = self.BOP_capacity[0] - (self.IP_capacity[0] + self.IP_capacity[0]/IP_th2el*BOP_eff)
  if BOP_min < 0:
    BOP_min = 0.0
  BOP_max = self.BOP_capacity[0] - (self.IP_capacity[0] + self.IP_capacity[0]/IP_th2el*BOP_eff) * IP_mini
  # margina cost BOP-IP
  # 1 W electric of the reactor => electric and steam
  IP_el_fract = IP_EL/(IP_EL + IP_TH * BOP_eff) # 1W of the reactor produces IP_el_fract W for the IP (and the associated steam)
  max_IP = (self.BOP_capacity[0] * IP_el_fract)/self.IP_capacity[0]   # if the IP is bigger than the Reactorm the max IP is capped by the reactor, i.e. the IP can not go to 1.0
  if max_IP > 1.0:
    max_IP = 1.0
  if max_IP < IP_mini:
    print "ERROR in marginal dispatch: max_IP < IP_mini"
    quit()
  IP_el2kg = (IP_KG*3600) / (IP_EL*1e6)         # IP_EL MW_el are needed to produce IP_KG  kg/s of H2                  [kg/h/W_el]
  H2 = IP_el_fract * IP_el2kg                   # W_el * kg/h/W_el  => [kg/h]
  Marginal_BOP = H2 * Price_H2                  # marginal to produce 1 more Wh
  # margina cost SES (O&M varia and fuel)
  Marginal_SES = -1.0 * (self.cashFlowParameters['Economics']['SES']['SES_OMperFuel']['alpha']['val'][-1] + self.cashFlowParameters['Economics']['SES']['SES_OMperProduction']['alpha']['val'][-1])

  if debugprint:
    print "Collect data"
    print "N_hours           : %s " %N_hours
    print "Price_H2          : %s " %Price_H2
    print "BOP_eff           : %s " %BOP_eff
    print "IP_EL             : %s " %IP_EL
    print "IP_TH             : %s " %IP_TH
    print "IP_KG             : %s " %IP_KG
    print "Pow2Capa_battery  : %s " %Pow2Capa_battery
    print "BOP_min           : %s " %BOP_min
    print "BOP_min  norm     : %s " %(BOP_min/self.BOP_capacity[0])
    print "Marginal_BOP      : %s " %Marginal_BOP
    print "Marginal_SES      : %s " %Marginal_SES
    print "SES capacity      : %s " %self.SES_capacity[0]
    print "ES capacity       : %s " %self.ES_capacity[0]
    print "IP capacity       : %s " %self.IP_capacity[0]

  BOP = np.zeros((N_hours, 1))
  SES = np.zeros((N_hours, 1))
  IP = np.zeros((N_hours, 1))
  ES = np.zeros((N_hours, 1))  # [battery energy in Wh]
  ESP = np.zeros((N_hours, 1))  # [battery poer in W]
  for t in range (0,N_hours):
    if debugprint:
      print "distribution for hour, : %s " %t
      print "NetD[t]  : %s" %self.Demand_time_net[t]
    # case Net demand < BOP_min
    if  self.Demand_time_net[t] < BOP_min:
      if debugprint:
        print "Net demand < BOP_min"
      BOP[t] = BOP_min/self.BOP_capacity[0]
      SES[t] = 0.0
      IP[t] = max_IP
      # absorb as much as we can with the battery
      ToBeAbsorbed = BOP_min - self.Demand_time_net[t]  #[pos]
      #maximum absorbtion per hour
      Bat_max = self.ES_capacity[0]*Pow2Capa_battery
      Absorbed = min(ToBeAbsorbed, Bat_max)
      #How much battery capacyty is left?
      if t == 0:
        battminus1 = bat_init
      else :
        battminus1 =  ES[t-1] * self.ES_capacity[0]
      AbsLeft = self.ES_capacity[0] - battminus1
      FinallyAbsorbed = min(Absorbed, AbsLeft)
      ES[t] = (battminus1  + FinallyAbsorbed)/self.ES_capacity[0]
      ESP[t] = battminus1/self.ES_capacity[0] - ES[t]

    # case Net demand > BOP_min
    else:
      if debugprint:
        print "Net demand > BOP_min"
      BOP[t] =  BOP_min/self.BOP_capacity[0]
      LeftDemand =  self.Demand_time_net[t] - BOP_min
      # compare marginal costs BOP vs SES
      if Marginal_SES <= Marginal_BOP:
        if debugprint:
          print "SES goes first"
        # SES goes first
        # ======================
        if LeftDemand <= self.SES_capacity[0] :
          if debugprint:
            print "all absorbed by SES"
          # all absorbed by SES
          SES[t] = LeftDemand / self.SES_capacity[0]
          IP[t] = max_IP
          LeftDemandBat = 0.0
        else :
          # not all absorbed by SES
          SES[t] = 1.0
          LeftDemandBOP = LeftDemand - self.SES_capacity[0]
          if LeftDemandBOP < (BOP_max - BOP_min):
            if debugprint:
              print "the reactor absorbs the rest"
            # the reactor absorbs the rest
            BOP[t] = BOP[t] + LeftDemandBOP/self.BOP_capacity[0]
            IP[t] = ((self.BOP_capacity[0] - BOP[t]*self.BOP_capacity[0])*IP_el_fract) / self.IP_capacity[0]
            LeftDemandBat = 0.0
          else :
            if debugprint:
              print "the reactor does not absorb all"
            # the reactor does not absorb all
            BOP[t] = BOP_max/self.BOP_capacity[0]
            IP[t] = IP_mini
            LeftDemandBat = LeftDemandBOP - (BOP_max - BOP_min)
      else :
        if debugprint:
          print "BOP goes first"
        # BOP goes first
        # ======================
        if LeftDemand <= (BOP_max - BOP_min):
          # all absorbed by BOP
          BOP[t] = BOP[t] + LeftDemand/self.BOP_capacity[0]
          IP[t] = ((self.BOP_capacity[0] - BOP[t]*self.BOP_capacity[0])*IP_el_fract) / self.IP_capacity[0]
          SES[t] = 0.0
          LeftDemandBat = 0.0
        else :
          # not all absorbed by BOP
          BOP[t] = BOP_max/self.BOP_capacity[0]
          IP[t] = IP_mini
          LeftDemandSES = LeftDemand - (BOP_max - BOP_min)
          if LeftDemandSES < self.SES_capacity[0] :
            # SES absorbs the rest
            SES[t] = LeftDemandSES / self.SES_capacity[0]
            LeftDemandBat = 0.0
          else :
            # not all absorbed by SES
            SES[t] = 1.0
            LeftDemandBat = LeftDemandSES - self.SES_capacity[0]
      # The battery discharges last
      if debugprint:
        print "LeftDemandBat : %s" %LeftDemandBat
      ToBedischarged = LeftDemandBat  # shold be a positive munber, otherwise something went wrong
      #maximum discharge per hour
      Bat_max = self.ES_capacity[0]*Pow2Capa_battery
      Discharged = min(ToBedischarged, Bat_max)
      #How much battery capacyty is left?
      if t == 0:
        battminus1 = bat_init
      else :
        battminus1 =  ES[t-1] * self.ES_capacity[0]
      AbsLeft = battminus1
      FinallyDischarged = min(Discharged, AbsLeft)
      ES[t] = (battminus1  - FinallyDischarged)/self.ES_capacity[0]
      ESP[t] = battminus1/self.ES_capacity[0] - ES[t]

    #  Add electricty used by the IP to the BOP
    BOP[t] = BOP[t] + (IP[t]*self.IP_capacity[0])/self.BOP_capacity[0]

    if debugprint:
      print "BOP   : %s" %BOP[t]
      print "IP    : %s" %IP[t]
      print "SES   : %s" %SES[t]
      print "ES    : %s" %ES[t]
      print "ES P  : %s" %ESP[t]

    # Store ref into the expected output variables
  if debugprint:
    print "pass back"
  for hour in range(1,N_hours + 1):
    if debugprint:
      print "Hour: %s " %hour
    # BOP
    BOP_name = 'BOP_' + str(hour).zfill(4)
    BOP_value = BOP[hour-1][0]
    if BOP_value > 1.0:
      print "Optimiser Preconditioner WARNING: Variable %s outside bounds: %s" %(BOP_name, BOP_value)
      BOP_value = 1.0
    if BOP_value < 0.0:
      print "Optimiser Preconditioner WARNING: Variable %s outside bounds: %s" %(BOP_name, BOP_value)
      BOP_value = 0.0
    setattr(self, BOP_name, np.array([BOP_value]))
    if debugprint:
      print "BOP   : %s" %getattr(self, BOP_name)
    # SES
    SES_name = 'SES_' + str(hour).zfill(4)
    SES_value = SES[hour-1][0]
    if SES_value > 1.0:
      print "Optimiser Preconditioner WARNING: Variable %s outside bounds: %s" %(SES_name, SES_value)
      SES_value = 1.0
    if SES_value < 0.0:
      print "Optimiser Preconditioner WARNING: Variable %s outside bounds: %s" %(SES_name, SES_value)
      SES_value = 0.0
    setattr(self, SES_name, np.array([SES_value]))
    if debugprint:
      print "SES   : %s" %getattr(self, SES_name)
    # ES
    ES_name = 'ES_' + str(hour).zfill(4)
    ES_value = ES[hour-1][0]
    if ES_value > 1.0:
      print "Optimiser Preconditioner WARNING: Variable %s outside bounds: %s" %(ES_name, ES_value)
      ES_value = 1.0
    if ES_value < 0.0:
      print "Optimiser Preconditioner WARNING: Variable %s outside bounds: %s" %(ES_name, ES_value)
      ES_value = 0.0
    setattr(self, ES_name, np.array([ES_value]))
    if debugprint:
      print "ES   : %s" %getattr(self, ES_name)
    # IP
    IP_name = 'IP_' + str(hour).zfill(4)
    IP_value = IP[hour-1][0]
    if IP_value > 1.0:
      print "Optimiser Preconditioner WARNING: Variable %s outside bounds: %s" %(IP_name, IP_value)
      IP_value = 1.0
    if IP_value < 0.0:
      print "Optimiser Preconditioner WARNING: Variable %s outside bounds: %s" %(IP_name, IP_value)
      IP_value = 0.0
    setattr(self, IP_name, np.array([IP_value]))
    if debugprint:
      print "IP   : %s" %getattr(self, IP_name)


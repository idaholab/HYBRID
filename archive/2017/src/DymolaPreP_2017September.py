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
def _readMoreXML(self,xmlNode):
  self.DYMPrePparams = {}
  for child in xmlNode:
    if child.tag == "DymolaPreP":
      # get verbosity if it exists
      if 'verbosity' in child.attrib:
        if isInt(child.attrib['verbosity']):
          self.DYMPrePver = int(child.attrib['verbosity'])
        else:
          raise IOError("Dymola Pre-processor ERROR (XML reading): 'verbosity' in 'DymolaPreP'  needs to be an integer'")
      else:
        self.DYMPrePver = 100 # errors only
      if self.DYMPrePver < 100:
        print "Dymola Pre-processor INFO (XML reading): verbosity level: %s" %self.DYMPrePver
      recursiveXmlReader(child, self.DYMPrePparams)
# =====================================================================================================================

# =====================================================================================================================
def recursiveXmlReader(xmlNode, inDictionary):
  # treat tags
  # - - - - - - - - - - - - - - - - - - -
  xmlNodeName = xmlNode.tag
  if xmlNodeName in inDictionary.keys():
    raise IOError("Dymola Pre-processor ERROR (XML reading): XML Tags need to be unique (cant be 'attr' or 'val'): %s" %xmlNodeName)
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
def initialize(self, runInfoDict, inputFiles):
  # check that we have read the inputs that we need
  # check if DymolaPreP exists
  # - - - - - - - - - - - - - - - - - - - - - - - - - -
  if 'DymolaPreP' not in self.DYMPrePparams.keys():
    raise IOError("Dymola Pre-processor ERROR (XML reading): 'DymolaPreP' node is required")

  # check if Components exists
  # - - - - - - - - - - - - - - - - - - - - - - - - - -
  if 'Components' not in self.DYMPrePparams['DymolaPreP'].keys():
    raise IOError("Dymola Pre-processor ERROR (XML reading): 'Components' node is required inside 'DymolaPreP'")

  self.DYMPrePparams['DymolaPreP']['Components']['val'] = self.DYMPrePparams['DymolaPreP']['Components']['val'].split()
  if self.DYMPrePver < 2:
    for Compo in self.DYMPrePparams['DymolaPreP']['Components']['val']:
      print "Dymola Pre-processor INFO (XML reading): Component to Pre-procsess: %s" %Compo

# =====================================================================================================================
# Make vectors out of the sampled utilisations:
#       RAVEN     =>  scalar utilisation for a given time discretisation, for each component
#       Dymola    <=  one vector containing utilisation time hystory for each component
def run(self, Inputs):
  """
    generates vectors from pointsets for Dymola for the components specified in <DymolaPreP>
    Inputs  :
    Outputs :
  """

#  self.Time1 # DEBUGG just checking we have it
#  self.time_dispatch = self.Time1[:-1]
  if self.DYMPrePver < 1:
    print "Dymola Pre-processor INFO (run): Inside Dymola Pre-processor"

  if self.DYMPrePver < 11:
    print "Dymola Pre-processor INFO (run): builiding BOP_XXXX from IP_XXXX"
  Input_exist = True
  x = 0
  while Input_exist:
    Compo_ev = "IP_" + '{:04d}'.format(x+1)
    Compo_BOP = "BOP_" + '{:04d}'.format(x+1)
    if self.DYMPrePver < 11:
      print "Dymola Pre-processor INFO (run): Looking for %s in Inputs" %Compo_ev
    if Compo_ev in Inputs.keys():
      IP_inp = Inputs[Compo_ev]
      newBOP = (self.BOP_capacity-(IP_inp*self.IP_capacity*self.IP_TH/self.IP_EL*self.BOP_eff))/self.BOP_capacity[0]
      if self.DYMPrePver < 11:
        print "Dymola Pre-processor INFO (run): Fiund input: %s" %IP_inp
        print "Dymola Pre-processor INFO (run): Corresponding BOP output: %s" %newBOP
      setattr(self, Compo_BOP, newBOP)
      Inputs[Compo_BOP] = newBOP
      x += 1
    else:
      if x == 0:
        raise IOError("Dymola Pre-processor ERROR (run): Asked to build BOP_XXXX from IP_XXXX, but IP_XXXX is not in inputs")
      else:
        if self.DYMPrePver < 11:
          print "Dymola Pre-processor INFO (run): Found %s time entries for componet IP" %x
      Input_exist = False


  for Compo in  self.DYMPrePparams['DymolaPreP']['Components']['val']:
    if self.DYMPrePver < 2:
      print "Dymola Pre-processor INFO (run): Pre-processing component: %s" %Compo
    Input_exist = True
    x = 0
    Compo_ls = []
    compo_mult = getattr(self, Compo.strip() + '_capacity')

    while Input_exist:
      Compo_ev = Compo.strip() + "_" + '{:04d}'.format(x+1)
      if self.DYMPrePver < 1:
        print "Dymola Pre-processor INFO (run): Looking for %s in Inputs" %Compo_ev
      if Compo_ev in Inputs.keys():
        Compo_ls.extend(Inputs[Compo_ev]*compo_mult)
        x += 1
      else:
        if x == 0:
          raise IOError("Dymola Pre-processor ERROR (run): Asked to Pre-process component %s, but is not in inputs" %Compo)
        else:
          if self.DYMPrePver < 2:
            print "Dymola Pre-processor INFO (run): Found %s time entries for componet %s" %(x,Compo)
        Input_exist = False
    setattr(self, Compo + "_SAMP_productionEL", np.array(Compo_ls))

  # change battery to power from capacvity
  temp = []
  for x in range(0, len(self.ES_SAMP_productionEL)):
    if x == 0:
      temp.append(self.ES_capacity[0] - self.ES_SAMP_productionEL[x])
    else:
      temp.append(self.ES_SAMP_productionEL[x-1] - self.ES_SAMP_productionEL[x])
  self.ES_SAMP_productionEL = np.asarray(temp)


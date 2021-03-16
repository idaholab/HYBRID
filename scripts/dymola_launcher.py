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
# Copyright 2017 Battelle Energy Alliance, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import sys
import os

print("sys.path", repr(sys.path))

class DymolaLauncher(object):
  """
    Dymola Launcher
  """
  def __init__(self, **kwargs):
    """
      This class is aimed to launch Dymola jobs
      via the python interface
      @ In, kwargs, dict, the dictionary of options
    """
    from dymola.dymola_interface import DymolaInterface
    # intialize dymola
    cwd = os.getcwd()
    if sys.platform.startswith("win"):
      print("trying to find dymola executable")
      found = None
      for item in sys.path:
        if item.endswith("dymola.egg"):
          found = item
      if found is not None:
        print("dymola found in: ",found)
        dymola_exe = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(found)))),"bin64","dymola.exe")
        print("dymola exe: ", dymola_exe)
        self.dymola = DymolaInterface(dymolapath=dymola_exe)
      else:
        print("dymola not found in",sys.path)
        self.dymola = DymolaInterface()
    else:
      self.dymola = DymolaInterface()
    self.workDir = kwargs.get("workingDir")
    if not os.path.isabs(self.workDir):
      self.workDir = os.path.join(cwd,self.workDir)
    print("swd", self.workDir, "cwd", cwd, "MODELICAPATH", os.environ.get("MODELICAPATH",""))
    self.silent = kwargs.get("silent")
    self.dymola.cd(self.workDir)
    self.dymola.experimentSetupOutput(events=False)
 
  def run(self, input):
    """
      Run the input file
      @ In, input, str, the input file to run
      @ Out, None
    """
    self.returnOut = self.dymola.RunScript(input, silent=self.silent)

  def getResultOutput(self):
    """
      Return the result
      @ In, None
      @ Out, outcome, tuple, outcome (result, returnCode, log)
    """
    if not self.returnOut:
      outcome = (None, -1, self.dymola.getLastErrorLog())
    else:
      outcome = (self.returnOut, 0, self.dymola.getLastErrorLog())
    print("result",outcome)
    return outcome
    
  def close(self):
    """
      Finalize dymola
      @ In, None
      @ Out, None
    """
    self.dymola.close()
  
if __name__ == '__main__':
  """
    This is the main driver for Dymola Launcher
  """
  options = {}
  options['silent'] = False
  if "-i" not in sys.argv:
    raise IOError("No -i option provided!")
  if "-wd" not in sys.argv:
    raise IOError("No -wd option provided!")
  for cnt, item in enumerate(sys.argv):
    if item.lower() == "silent":
      options['silent'] = True
    elif item.lower() == "-i":
      options['input'] = sys.argv[cnt+1]
    elif item.lower() == "-wd":
      options['workingDir'] = sys.argv[cnt+1]
  dm = DymolaLauncher(**options)
  dm.run(options['input'])
  outcome = dm.getResultOutput()
  if outcome[1] == -1:
    print('Dymola Run on input "'+options['input']+'" failed!')
    print('Log Error: \n '+outcome[2])
  else:
    print('Dymola Run on input "'+options['input']+'" Successfully run!')  
  dm.close()
  
 

  

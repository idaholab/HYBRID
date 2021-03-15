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
#!/usr/bin/env python
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

# This is a utility script to write the .hybridrc file for indicating the dymola path
# It takes the following command line arguments
# -p, the dymola installation directory
# to run the script use the following command:
#  python write_hybridrc.py path/to/dymola/python_interface
# @author: A. Alfonsi
# @date  : May 20th, 2020

import os
import sys
import argparse
import warnings

# set up command-line arguments
parser = argparse.ArgumentParser(prog="HYBRID Dymola Path Installer",
                                 description="Used to set the dymola path in this repository.")
parser.add_argument('-p', '--path', dest='dymola_path', action='append',
                    help='designate the path to the dymola installation.')
parser.add_argument('-modify-mos', '--modify-mos', dest='modify_mos',
                    help='modify dymola.mos?')
modify_mos = False
p = None
args = sys.argv[1:]
if args.count("-modify-mos") or args.count("--modify-mos"):
  modify_mos = True
  args.pop(args.index("-modify-mos") if "-modify-mos" in args else args.index("--modify-mos"))
if args.count("-p") or args.count("--path"):
  p = args.index("-p") if "-p" in args else args.index("--path")
  path = " ".join(args[p+1:]).replace('"','')
  if path.strip().startswith("/c/"):
    path = os.path.abspath(os.path.expanduser(path[2:]))
  if not path.endswith("dymola.egg"):
    path = os.path.join(path,"dymola.egg")

if p is None:
  print('ERROR: script must be called with as: write_hybridrc.py -p "path to dymola python_interface egg"')
  sys.exit(1)

#args = parser.parse_args()

if __name__ == '__main__':
  ### Design notes
  # "Installing" is actually just the process of registering the location of the dymola installation
  # save the current CWD and restore it after acting
  owd = os.getcwd()
  cwd = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
  os.chdir(cwd)
  # find the dymola.mos
  eggDir = os.path.dirname(path)
  pathToDymolaMos = os.path.join(eggDir,"..","..","..","insert","dymola.mos")
  eggFound = True
  if not os.path.exists(path):
    eggFound = False
    path = "INVALID:" + path
    warningMessage = '\n\nPATH to Dymola is not correct. "dymola.egg" has not been found at: ' + os.path.dirname(path) +'\n'
    warningMessage+= '.hybridrc file will be created but the DYMOLA_PATH will be set to INVALID. Please modify it manually!\n'
    warnings.warn(warningMessage)
  dymolaMosFound = True
  if (not os.path.exists(pathToDymolaMos) and modify_mos) or not modify_mos:
    dymolaMosFound = False
    if modify_mos:
      warningMessage = '\n\nPATH to Dymola is not correct. "dymola.mos" has not been found at: ' + os.path.dirname(pathToDymolaMos) +'\n'
    else:
      warningMessage = '\n\n--modify-mos is False (or not inputted).\n'
    warningMessage+= 'the "dymola.mos" file will need to be modified manually adding the following: \n'
    transform = os.path.abspath(os.path.expanduser(os.path.join(cwd,"TRANSFORM-Library","TRANSFORM","package.mo")))
    warningMessage = warningMessage+'openModel("'+transform.strip()+'")\n'
    nhes = os.path.abspath(os.path.expanduser(os.path.join(cwd,"NHES","package.mo")))
    warningMessage = warningMessage + 'openModel("'+nhes.strip()+'")\n'
    warnings.warn(warningMessage)
  pp = os.path.join(cwd,".hybridrc")
  path = path.replace("\\","/")
  with open(pp,"w") as hrc:
    hrc.write("DYMOLA_PATH = "+path+"\n")
    if not eggFound:
      print("dymola path IS **INVALID** and set to : " + path)
    else:
      print("dymola path set to : " + path)

  if dymolaMosFound and modify_mos:
    # modify the dymola.mos
    lines = []
    found = {"transform-library":False, "nhes":False}
    # lets try to see if we can open the file
    dymolaMosOpenable = True
    try:
      fo = open(pathToDymolaMos, "r")
      fo.close()
    except:
      dymolaMosOpenable = False
    
    if dymolaMosOpenable:
      with open(pathToDymolaMos, "r") as dymolaMos:
        print('Found "dymola.mos" file:')
        modified = False
        # parse line by line
        for cnt, line in enumerate(dymolaMos.readlines()):
          if line.strip().startswith("openModel"):
            if "transform-library" in line.lower():
              found["transform-library"] = True
            elif "nhes" in line.lower():
              found["nhes"] = True
          lines.append(line)
          print(line)
      if not found["transform-library"] or not found["nhes"]:
        modified = True
      if not found["transform-library"]:
        transform = os.path.abspath(os.path.expanduser(os.path.join(cwd,"TRANSFORM-Library","TRANSFORM","package.mo")))
        lines.append('openModel("'+transform.strip()+'")\n')
      if not found["nhes"]:
        nhes = os.path.abspath(os.path.expanduser(os.path.join(cwd,"NHES","package.mo")))
        lines.append('openModel("'+nhes.strip()+'")\n')
      if modified:
        dymolaMosModifiable = True
        try:
          fo = open(pathToDymolaMos, "w")
          fo.close()
        except:
          dymolaMosModifiable = False
        if dymolaMosModifiable:
          print('Modified "dymola.mos" file as following:')
          with open(pathToDymolaMos, "w") as dymolaMos:
            for line in lines:
              dymolaMos.write(line)
              print(line)
        else:
          # not possible to be modified
          warningMessage = '\n\n"dymola.mos" failed to open in WRITE mode (it is not possible to modify it)\n'
          warningMessage+= 'the "dymola.mos" file will need to be modified manually adding the following: \n'
          transform = os.path.abspath(os.path.expanduser(os.path.join(cwd,"TRANSFORM-Library","TRANSFORM","package.mo")))
          warningMessage = warningMessage+'openModel("'+transform.strip()+'")\n'
          nhes = os.path.abspath(os.path.expanduser(os.path.join(cwd,"NHES","package.mo")))
          warningMessage = warningMessage + 'openModel("'+nhes.strip()+'")\n'
          warnings.warn(warningMessage)
    else:
      # failed to open
      warningMessage = '\n\n"dymola.mos" failed to open at: ' + os.path.dirname(pathToDymolaMos) +'\n'
      warningMessage+= 'the "dymola.mos" file will need to be modified manually adding the following: \n'
      transform = os.path.abspath(os.path.expanduser(os.path.join(cwd,"TRANSFORM-Library","TRANSFORM","package.mo")))
      warningMessage = warningMessage+'openModel("'+transform.strip()+'")\n'
      nhes = os.path.abspath(os.path.expanduser(os.path.join(cwd,"NHES","package.mo")))
      warningMessage = warningMessage + 'openModel("'+nhes.strip()+'")\n'
      warnings.warn(warningMessage)
  if dymolaMosFound and eggFound:
    print('INSTALLATION COMPLETED! dymola.egg and dymola.mos HAVE BEEN FOUND AND MODIFIED!')
  elif not dymolaMosFound and eggFound and modify_mos:
    print('INSTALLATION PARTIALLY COMPLETED! dymola.egg HAS BEEN FOUND but dymola.mos must be MANUALLY modified (Check Warnings above)!')
  else:
    print('INSTALLATION **FAILED**! Check Warnings above!')

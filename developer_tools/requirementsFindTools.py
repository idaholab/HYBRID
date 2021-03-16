#Licensed under Apache 2.0 License.
#© 2021 Battelle Energy Alliance, LLC
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
"""
 Created on Feb 10, 2021
 Methods to retrieve requirements
 @ adapted from RAVEN module createRegressionTestDocumentation
 @author: alfoa
"""
from glob import glob
import os
from collections import OrderedDict

def findRequirementTests(startDir = None):
  """
    This method returns a dictionary of framework tests (i.e. the ones with an
    extension and listed in the "tests" files) that have a REQUIREMENTS tag
    @ In, startDir, str, optional, the start directory
    @ Out, requirementDict, dict,  dict of file name + requirement ids
                                      ({'fileName':[Req1,Req2,etc]})
  """
  __testInfoList = []
  requirementDict = OrderedDict()
  startDir = os.path.abspath(os.path.join(os.path.dirname(__file__),'../') if startDir is None else startDir)
  for dirr,_,_ in os.walk(startDir):
    __testInfoList.extend(glob(os.path.join(dirr,"tests")))
  for testInfoFile in __testInfoList:
    if ('moose' in testInfoFile.split(os.sep)
        or 'raven' in testInfoFile.split(os.sep)
        or 'TRANSFORM-Library' in testInfoFile.split(os.sep)
        or not os.path.isfile(testInfoFile)):
      continue
    fileObject = open(testInfoFile,"r+")
    fileLines = fileObject.readlines()
    fileObject.close()
    dirName = os.path.dirname(testInfoFile)
    start = False
    fileName = None
    for line in fileLines:
      ll = line.strip()
      if ll.startswith("[.") and "[../]" not in ll:
        start = True
        fileName = None
        reqs = None
      if "[../]" in ll:
        start = False
        # we can check if the req got
        if fileName is not None and reqs is not None:
          requirementDict[fileName] = reqs
      if start and 'REQUIREMENT' in ll.upper():
        reqs = ll.upper().replace('REQUIREMENT',"").replace("#","").replace(":","")
        reqs = [req.strip() for req in reqs.split()]
      if start and ll.startswith("input"):
        fileName = line.split("=")[-1].replace("'", "").replace('"', '').rstrip().strip()
        fileName = os.path.join(dirName,fileName)
  return requirementDict








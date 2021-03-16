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
 This file is a tuned version of the module already
 in RAVEN with the same name
 @author: alfoa
"""
import os
from glob import glob
import inspect
import xml.etree.ElementTree as ET
import copy
import sys
from collections import OrderedDict, defaultdict
#add raven tools
sys.path.append(os.path.join(os.path.dirname(__file__),'../','raven','developer_tools'))
# import utility functions
import readRequirementsAndCreateLatex as readRequirements
from requirementsFindTools import findRequirementTests

def contructRequirementMapWithTests(requirementDict):
  """
    Method to construct the link between requirements' ids and tests
    @ In, requirementDict, dict, the requirement dictionary
    @ Out, reqDictionary, dict, the requirement mapping ({'req id':[test1,test2,etc]})
  """
  reqDictionary = defaultdict(list)
  for testName,req in requirementDict.items():
    for reqId in req:
      reqDictionary[reqId.strip()].append(testName)
  return reqDictionary

def createLatexFile(reqDictionary,reqDocument,outputLatex):
  """
    Method to write a section containing the requirement matrix in LateX
    @ In, reqDictionary, dict, the requirement mapping ({'req id':[test1,test2,etc]})
    @ In, reqDocument, tuple, (app name, the requirement dictionary)
    @ In, outputLatex, string, the output latex file
    @ Out, None
  """
  app, allGroups = reqDocument
  fileObject = open(outputLatex,"w+")
  fileObject.write(" \\section{"+app.strip().upper()+":SYSTEM REQUIREMENTS} \n")
  fileObject.write(" \\subsection{Requirements Traceability Matrix} \n")
  fileObject.write(" This section contains all of the requirements, requirements' description, and \n")
  fileObject.write(" requirement test cases. The requirement tests are automatically tested for each \n")
  fileObject.write(" CR (Change Request) by the CIS (Continuous Integration System). \n")
  fileObject.write(" \\newcolumntype{b}{X} \n")
  fileObject.write(" \\newcolumntype{s}{>{\\hsize=.5\\hsize}X} \n")

  for group, groupDict in allGroups.items():
    fileObject.write(" \\subsubsection{"+group.strip()+"} \n")
    for reqSetName,reqSet in groupDict.items():
      # create table here
      fileObject.write("\\begin{tabularx}{\\textwidth}{|s|s|b|} \n")
      fileObject.write("\\hline \n")
      fileObject.write("\\textbf{Requirment ID} & \\textbf{Requirment Description} & \\textbf{Test(s)}  \\\ \hline \n")
      fileObject.write("\\hline \n")
      ravenPath =    os.path.realpath(os.path.join(os.path.realpath(__file__) ,"..","..",".."))
      for reqName,req in reqSet.items():
        requirementTests = reqDictionary.get(reqName)
        if requirementTests is None:
          source = req.get("source")
          if source is not None:
            requirementTests = source
        requirementTests = [] if requirementTests is None else requirementTests
        for i in range(len(requirementTests)):
          requirementTests[i] = str(i+1) + ")" + requirementTests[i].replace(ravenPath,"").replace("_","\_").strip()
        fileObject.write(" \\hspace{0pt}"+reqName.strip()+" & \\hspace{0pt}"+req['description']+" & \\hspace{0pt}"+ ' '.join(requirementTests)+" \\\ \hline \n")
        fileObject.write("\\hline \n")
      fileObject.write("\\caption*{"+reqSetName.strip()+"}\n")
      fileObject.write("\\end{tabularx} \n")
  fileObject.write("\\end{document}")
  fileObject.close()


if __name__ == '__main__':
  try:
    index = sys.argv.index("-i")
    requirementFile = sys.argv[index+1].strip()
  except ValueError:
    raise ValueError("Not found command line argument -i")
  try:
    index = sys.argv.index("-o")
    outputLatex = sys.argv[index+1].strip()
  except ValueError:
    raise ValueError("Not found command line argument -o")

  reqDocument = readRequirements.readRequirementsXml(requirementFile)
  requirementDict = findRequirementTests()
  reqDictionary = contructRequirementMapWithTests(requirementDict)
  createLatexFile(reqDictionary,reqDocument,outputLatex)

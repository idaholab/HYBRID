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
from __future__ import division, print_function, absolute_import
import sys,os,re
import difflib
import diffUtils as DU

class HYBRIDTextDiff:
  """
    TextDiff is used for comparing purely text files
  """
  def __init__(self, testDir, outFile,**kwargs):
    """ Create a TextDiff class
    testDir: the directory where the test takes place
    outFile: the files to be compared.  They will be in testDir + outFile
               and testDir + gold + outFile
    args: other arguments that may be included:
          - 'comment': indicates the character or string that should be used to denote a comment line
    """
    self.__outFile = outFile
    self.__messages = ""
    self.__same = True
    self.__testDir = testDir
    self.__options = kwargs
    if self.__options.get('numeric','false').lower() in ['true','t','1']:
      self.__numeric = True
    else:
      self.__numeric = False

  def diff(self):
    """ Run the comparison.
    returns (same,messages) where same is true if all the txt files are the
    same, and messages is a string with all the differences.
    """
    # read in files
    commentSymbol = self.__options['comment']
    for outfile in self.__outFile:
      testFilename = os.path.join(self.__testDir,outfile)
      goldFilename = os.path.join(self.__testDir, 'gold', outfile)
      if not os.path.exists(testFilename):
        self.__same = False
        self.__messages += 'Test file does not exist: '+testFilename
      elif not os.path.exists(goldFilename):
        self.__same = False
        self.__messages += 'Gold file does not exist: '+goldFilename
      else:
        filesRead = True
        try:
          testFile = open(testFilename)
          testLines = [line.split(commentSymbol,1)[0].strip() if len(commentSymbol) > 0 else line for line in testFile]
          testLines = [line for line in testLines if len(line) > 0]
          testFile.close()
        except Exception as e:
          self.__same = False
          self.__messages += "Error reading " + testFilename + ":" + str(e) + " "
          filesRead = False
        try:
          goldFile = open(goldFilename)
          goldLines = [line.split(commentSymbol,1)[0].strip() if len(commentSymbol) > 0 else line for line in goldFile]
          goldLines = [line for line in goldLines if len(line) > 0]
          goldFile.close()
        except Exception as e:
          self.__same = False
          self.__messages += "Error reading " + goldFilename + ":" + str(e) + " "
          filesRead = False

        if filesRead:
          diff = list(difflib.unified_diff(testLines,goldLines))
          if len(diff):
            if self.__numeric:
              deletions = [ line for line in diff if line.startswith('-')][1:] #entry 0 is the '+++', '---' lines
              additions = [ line for line in diff if line.startswith('+')][1:]
              if len(deletions) != len(additions):
                self.__same = False
                self.__messages += "Different number of deletions and additions"
              for i in range(len(deletions)):
                delLine = deletions[i].strip()[1:] #entry 0 is +/-, but not part of the number
                addLine = additions[i].strip()[1:]
                same,msg = DU.compareStringsWithFloats(addLine, delLine,
                                                       relTol        = self.__options.get('rel_err',1e-10),
                                                       zeroThreshold = self.__options['zero_threshold'],
                                                       removeUnicodeIdentifier = True)
                if not same:
                  self.__same = False
                  self.__messages += msg
                  break
            else:
              self.__same = False
              separator = "\n"+" "*4
              self.__messages += "Mismatch between "+testFilename+" and "+goldFilename+separator
              self.__messages += separator.join(diff[2:8]) + separator+'...' + "\n" #truncation prevents too much output

    if '[' in self.__messages or ']' in self.__messages:
      self.__messages = self.__messages.replace('[','(')
      self.__messages = self.__messages.replace(']',')')
    return (self.__same,self.__messages)

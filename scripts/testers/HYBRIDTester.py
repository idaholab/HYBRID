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
from Tester import Tester
import os
import subprocess
import sys
import warnings

from HYBRIDTextDiff import HYBRIDTextDiff
from DymolaMatDiffer import DymolaMatDiffer
# Set this outside the class because the framework directory is constant for
#  each instance of this Tester, and in addition, there is a problem with the
#  path by the time you call it in __init__ that causes it to think its absolute
#  path is somewhere else
# Be aware that if this file changes its location, this variable should also be
#  changed.
myDir = os.path.dirname(os.path.realpath(__file__))
BIN_DIR = os.path.abspath(os.path.join(myDir, '..'))

class HYBRIDTester(Tester):

  @staticmethod
  def get_valid_params():
    params = Tester.get_valid_params()
    params.add_required_param('input',"The input file to use for this test.")
    params.add_required_param('workingDir',"The working directory")
    #params.add_param('executable','',"Name of compiled executable to run.")
    params.add_param('output','',"List of output files that the input should create.")
    params.add_param('text','',"List of text files to check.")
    params.add_param('dymola_mats','',"List of text files to check.")
    params.add_param('numeric_text','',"List of text files with relative numbers to check.")
    params.add_param('comment','asdfghjkl',"Characters after which entries should be ignored in text checks.")
    params.add_param('rel_err','','Relative Error for csv files or floats in xml ones')
    params.add_param('required_executable','','Skip test if this executable is not found')
    params.add_param('zero_threshold',sys.float_info.min*4.0,'it represents the value below which a float is considered zero (XML comparison only)')
    return params

  def get_command(self):
    """
      Return the command this test will run.
      @ In, None
      @ Out, get_command, string, command to run
    """
    return "python " + self.launcher + ' -i ' + self.specs['input'] + ' -wd ' + self.specs.get ('workingDir',".")

  def __init__(self, name, params):
    Tester.__init__(self, name, params)
    self.output_files = self.specs['output'      ].split(" ") if len(self.specs['output'      ]) > 0 else []
    self.text_files   = self.specs['text'        ].split(" ") if len(self.specs['text'        ]) > 0 else []
    self.ntext_files  = self.specs['numeric_text'].split(" ") if len(self.specs['numeric_text']) > 0 else []
    self.dymola_mats  = self.specs['dymola_mats'].split(" ") if len(self.specs['dymola_mats']) > 0 else []
    self.required_executable = self.specs['required_executable']
    self.launcher = os.path.join(BIN_DIR,"dymola_launcher.py")
    self.outputStep, self.stopTime = None, None
    # in the directory containing the input, we read the .mos file for
    # identifying the stats of the test files
    if self.specs['input'].strip().endswith(".mos"):
      with open(os.path.join(self.specs['test_dir'],self.specs['input']),"r") as mosObj:
        numberOfIntervals, outputInterval = None, None
        for line in mosObj.readlines():
          if line.lower().startswith("simulatemodel"):
            for el in line.split(","):
              if el.strip().lower().startswith("stoptime"):
                self.stopTime = float(el.strip().split("=")[-1])
              elif el.strip().lower().startswith("numberofintervals"):
                numberOfIntervals = int(el.strip().split("=")[-1])
              elif el.strip().lower().startswith("outputinterval"):
                outputInterval = float(el.strip().split("=")[-1])
            break
        # check which info have been found
        if not self.stopTime and (not numberOfIntervals and not outputInterval):
          warnings.warn('In .mos file {} "simulateModel" keyword, "stopTime"' \
          ', "outputInterval" and "numberOfIntervals" not found'.format(self.specs['input'].strip()))
        elif self.stopTime and (not numberOfIntervals and not outputInterval):
          warnings.warn('In .mos file {} "simulateModel" keyword, ' \
          'neither "outputInterval" nor "numberOfIntervals" have been found'.format(self.specs['input'].strip()))
        else:
          self.outputStep = outputInterval if outputInterval else self.stopTime/ numberOfIntervals
  def check_runnable(self):
    return (True, '')

  def prepare(self):
    if self.specs['output'].strip() != '':
      self.check_files = [os.path.join(self.specs['test_dir'],filename)  for filename in self.specs['output'].split(" ")]
    else:
      self.check_files = []
    for filename in self.ntext_files + self.dymola_mats + self.get_differ_remove_files():
      if os.path.exists(filename):
        os.remove(filename)

  def process_results(self, output):
    return self.rawProcessResults(output)

  def rawProcessResults(self, output):
    missing = []
    for filename in self.check_files:
      if not os.path.exists(filename):
        missing.append(filename)

    if len(missing) > 0:
      self.set_fail('CWD '+os.getcwd()+' Expected files not created '+" ".join(missing))
      return

    #numerical text
    if len(self.ntext_files) or len(self.text_files):
      ntextOpts = {'zero_threshold': float(self.specs['zero_threshold']), 'numeric': 'True', 'comment':self.specs['comment']}
      if 'rel_err' in self.specs.keys() and len(self.specs['rel_err']) > 0:
        ntextOpts['rel_err'] = float(self.specs['rel_err'])
      dymolaMatDiff = HYBRIDTextDiff(self.specs['test_dir'], self.ntext_files, **ntextOpts)
      (same, messages) = ntextDiff.diff()
      if not same:
        self.set_diff(messages)
        return
    # text
    if len(self.text_files):
      ntextOpts = {'zero_threshold': float(self.specs['zero_threshold']), 'numeric': 'False', 'comment':self.specs['comment']}
      textDiff = HYBRIDTextDiff(self.specs['test_dir'], self.text_files, **ntextOpts)
      (same, messages) = textDiff.diff()
      if not same:
        self.set_diff(messages)
        return
    #dymola mat
    if len(self.dymola_mats):
      ntextOpts = {'zero_threshold': float(self.specs['zero_threshold']), 'comment':self.specs['comment']}
      if 'rel_err' in self.specs.keys() and len(self.specs['rel_err']) > 0:
        ntextOpts['rel_err'] = float(self.specs['rel_err'])
      ntextOpts['outputStep'] = self.outputStep
      ntextOpts['stopTime'] = self.stopTime
      for dymolaMatFile in self.dymola_mats:
        dymolaMatDiff = DymolaMatDiffer(self.specs['test_dir'], dymolaMatFile, **ntextOpts)
        (same, messages) = dymolaMatDiff.diff()
        if not same:
          self.set_diff(messages)
          return
    self.set_success()
    return


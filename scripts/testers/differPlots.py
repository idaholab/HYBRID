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
import os
import numpy as np
from scipy.signal import correlate
import DymolaMatDiffer
    
class DifferPlots(DymolaMatDiffer.DymolaMatDiffer):
  '''
  Finds differences between mat files so plots of the differences can be viewed.
  '''
  def __init__(self, testDir, outFile, **kwargs):
    '''
      Create a DifferPlots object
      @ In, testDir, string, the directory where the test takes place
      @ In, outFile, string, the files to be compared.  They will be in testDir + outFile
      and testDir + gold + outFile
      @ In, kwargs, other arguments that may be included:
      - 'comment': indicates the character or string that should be used to denote a comment line
      @ Out, None
    '''
    super().__init__(testDir, outFile, **kwargs)
    self.tols = {
      'l2dist': 0.05,
      'maxDiff': 1e-3,
      'meanWeight': 1,
      'stdvWeight': 1,
      'corrWeight': 1,
      'weighted': 0.4
      }
    self.showInList = False
            
  def meanDiff(self, var):
    '''
      Calculates the relative difference in the means of two variables.
      @ In, None
      @ Out, None
    '''
    mean = self.testVars[var].mean
    stdGold = self.goldVars[var].stdv
    meanGold = self.goldVars[var].mean
    denom = max(abs(meanGold), stdGold)
    if denom == 0:
      meanDif = mean!=0
    else:
      meanDif = abs((mean - meanGold) / denom)
    self.goldVars[var].compVals['meanDiff'] = meanDif
    
  def stdvDiff(self, var):
    '''
      Calculates the relative difference in the standard deviations of two variables.
      @ In, None
      @ Out, None
    '''
    std = self.testVars[var].stdv
    stdGold = self.goldVars[var].stdv
    meanGold = self.goldVars[var].mean
    denom = max(abs(meanGold), stdGold)
    if denom == 0:
      stdDif = std!=0
    else:
      stdDif = abs((std - stdGold) / denom)
    self.goldVars[var].compVals['stdvDiff'] = stdDif
            
  def euclidDistance(self, var):
    '''
      Calculates the euclidean distance between two variables.
      @ In, None
      @ Out, None
    '''
    denom = max(abs(self.goldVars[var].mean), self.goldVars[var].stdv)
    if denom == 0:
      distl2 = self.testVars[var].mean!=0 or self.testVars[var].stdv!=0
      self.goldVars[var].compVals['distl2'] = distl2
             
    else:
      distl2 = np.linalg.norm(self.testVars[var].timeSeries - self.goldVars[var].timeSeries) / (len(self.testVars[var].timeSeries) * denom)
      self.goldVars[var].compVals['distl2'] = distl2
    
  def crossCor(self, var):
    '''
      Calculates the maximum value of the normalized cross correlation between two variables.
      @ In, None
      @ Out, None
    '''
    std = self.testVars[var].stdv
    mean = self.testVars[var].mean
    stdGold = self.goldVars[var].stdv
    meanGold = self.goldVars[var].mean
    timeSeries = self.testVars[var].timeSeries
    timeSeriesGold = self.goldVars[var].timeSeries
    if std != 0 and stdGold!=0:
      a = (timeSeries - mean) / (std * len(timeSeries))
      b = (timeSeriesGold - meanGold) / (stdGold)
      corr = correlate(a,b)
      self.goldVars[var].compVals['crosscorrDiff'] = abs(max(corr) - 1)
    else:
      self.goldVars[var].compVals['crosscorrDiff'] = 0
               
  def computeComparisons(self):
    '''
      Computes comparisons by calling all comparison calculations.
      @ In, None
      @ Out, None
    '''
    for var in self.commonVars:
      self.testVars[var].mean = np.mean(self.testVars[var].timeSeries, dtype = np.float64)
      self.testVars[var].stdv = np.std(self.testVars[var].timeSeries, dtype = np.float64)
      self.goldVars[var].mean = np.mean(self.goldVars[var].timeSeries, dtype = np.float64)
      self.goldVars[var].stdv = np.std(self.goldVars[var].timeSeries, dtype = np.float64)
      self.euclidDistance(var)
      self.meanDiff(var)
      self.stdvDiff(var)
      self.maxDiff(var)
      self.crossCor(var)
    
  def checkEuclidean(self):
    '''
      Checks if the euclidean distance between variables is within the set tolerance.
      @ In, None
      @ Out, differ, set, contains all variables that do not meet the Euclidean distance criteria
    '''
    differ = set()
    for var in self.commonVars:
      if self.goldVars[var].compVals['distl2'] > self.tols['l2dist']:
        differ.add(var)
    return differ
    
  def checkWeighted(self):
    '''
      Computes a weighted sum of deviation of cross correlation from unity,
      relative difference in means, and relative difference in standard devation.
      Compares this to a set tolerance.
      @ In, None
      @ Out, differ, contains all variables that do not meet weighted sum criteria
    '''
    differ = set()
    for var in self.commonVars:
      meanDif = self.goldVars[var].compVals['meanDiff']
      stdvDif = self.goldVars[var].compVals['stdvDiff']
      corrDif = self.goldVars[var].compVals['stdvDiff']
      weightedDif = self.tols['meanWeight'] * meanDif + self.tols['stdvWeight'] * stdvDif + self.tols['corrWeight'] * corrDif
      if weightedDif > self.tols['weighted']:
        differ.add(var)
    return differ
            
  def checkTol(self, comparisons, union=True):
    '''
      Calls the tolerance functions for each comparion applied.
      Combines multiple types of comparisons applied simultaneously.
      @ In, comparisons, list, which comparisons to apply
      @ In, union, bool, if set True, count any variables as passed if at least
        one comparison is passed. Else count failed if at least one comparsion failed.
      @ Out, None
    '''
    self.differVars.clear()
    comparisonChecks = {
      'l2Dist': self.checkEuclidean,
      'weighted': self.checkWeighted,
      'maxDiff': self.checkMaxDiff 
      }
    if len(comparisons):
      for count, comparison in enumerate(comparisons):
        differ = comparisonChecks[comparison]()
        if count == 0:
          self.differVars = differ
        elif not union: #case where if any comparison is passed it is considered passed
          self.differVars = self.differVars.union(differ)
        else: #case where if any test is comparison it is considered failed
          self.differVars = self.differVars.intersection(differ)
    else:
      self.differVars = set()
    if len(self.differVars):
      self._same = False
    
  def diff(self):
    '''
      Compares the test file with the reference files.
      Loops over all reference files in gold folder.
      @ In, None
      @ Out, self._same, bool, whether the test matches with any of the reference files
      @ Out, self._message, string, message to show if files do not match
    '''
    self.load(isTest=True, file=os.path.join(self.testDir, self._outFile))
    if not self._same:
      return self._same, self._message
    goldFiles = os.listdir(self._goldDir)
    goldFiles = list(filter(lambda x: '.mat' in x, goldFiles))
    passedSetTimes= []
    for goldFile in goldFiles:
      self._same = True
      self._message = ''
      self.load(isTest = False, file=os.path.join(self._goldDir, goldFile))
      if not self._same:
        continue
      self.setTimes()
      if not self._same and goldFile == goldFiles[-1]:
        if len(passedSetTimes):
          self._same, self._message = True, ''
          goldFile = passedSetTimes[-1]
          self.load(isTest=False, file=os.path.join(self._goldDir, goldFile))
          self.setTimes()
          self.compareVariables()
          self.computeComparisons()
          self.checkTol(comparisons=['maxDiff'])
          if not self._same:
            self.showInList = True
          return self._same, self._message
        else:
          continue
      elif not self._same:
        continue
      else:
        passedSetTimes.append(goldFile)
      self.compareVariables()
      self.computeComparisons()
      self.checkTol(comparisons = ['maxDiff'])
      if self._same:
        return self._same, self._message
    return self._same, self._message
        
  









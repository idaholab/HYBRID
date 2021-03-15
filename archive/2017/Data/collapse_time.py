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
from numpy import genfromtxt, array, isnan, savetxt
import argparse
import os

# PYTHON SCRIPT TO COLLAPSE TIME SERIES
# date        : 15.02.2017 
# written by  : A. Epiney 
# written for : PYTHON 2.6.9

#     Notes
#     -----
#     Error handling is not complete
#     for help run 'python collapse_time.py -h'

# function definitions
# ====================

# read and process input arguments
# ================================
inp_par = argparse.ArgumentParser(description = 'Rescale csv data')
inp_par.add_argument('-i', nargs=1, required=True, help='Input file name', metavar='inp_file')
inp_par.add_argument('-o', nargs=1, required=True, help='Output file name', metavar='out_file')
inp_par.add_argument('-collapse', type=int, nargs=1, required=True, help='How namy data should be collapsed?', metavar='collapse')

inp_opt  = inp_par.parse_args()

# check input consistency
print '\033[1m' + "====================================================================" + '\033[0m'
print '\033[1m' + "-------------- Input checker ---------------------------------------" + '\033[0m'
# -i
# check if file exists
print " -- Input file            : " + inp_opt.i[0]
if not os.path.exists(inp_opt.i[0]) :
  print '\033[91m' + "***  ERROR: input file " + inp_opt.i[0] + " does not exist.. " + '\033[0m'
  print '\033[1m' + "====================================================================" + '\033[0m'
  quit ()
print " -- Output file           : " + inp_opt.o[0]
if os.path.exists(inp_opt.o[0]) :
  print '\033[91m' + "***  ERROR: output file " + inp_opt.o[0] + " does already exist.. " + '\033[0m'
  print '\033[1m' + "====================================================================" + '\033[0m'
  quit ()
# collapse
print " -- # of data to collapse : " + str(inp_opt.collapse[0])
print '\033[1m' + "-------------- Input checker finished ------------------------------" + '\033[0m'
print '\033[1m' + "====================================================================" + '\033[0m'


print '\033[1m' + "====================================================================" + '\033[0m'
print '\033[1m' + "--------------Run collapsing ---------------------------------------" + '\033[0m'
# read data
myd = genfromtxt(inp_opt.i[0], delimiter=',')
# collapse data
temp_out = []
coll = inp_opt.collapse[0]
for line in range(len(myd)): 
  if isnan(myd[line][0]):
    print '\033[1m' + "- Element " + str(line) + " is not a number (header?) => skipped "   + '\033[0m'
    continue
  # new collapsing starts
  if coll == inp_opt.collapse[0]:
    time_temp = myd[line][0]
    sumdat = 0.0
  # summ data
  sumdat += myd[line][1]
  coll -= 1
  # collapsing finished
  if coll == 0:
    coll = inp_opt.collapse[0]
    temp_out.append([time_temp, sumdat/inp_opt.collapse[0]])
savetxt(inp_opt.o[0], array(temp_out), delimiter=',')
print '\033[1m' + "--------------End collapsing ---------------------------------------" + '\033[0m'
print '\033[1m' + "====================================================================" + '\033[0m'


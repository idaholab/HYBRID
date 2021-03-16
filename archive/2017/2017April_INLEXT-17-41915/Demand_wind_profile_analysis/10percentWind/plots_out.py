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
from numpy import genfromtxt, array, mean, sqrt, var, copy
import matplotlib.pyplot as plt
#from mpl_toolkits.mplot3d import Axes3D

# Set some global stuff for the plots
# - - - - - - - - - - - - - - - - - - - - - -

font = {'family'  : 'sans-serif',
        'style'   : 'normal',
        'variant' : 'normal',
        'weight'  : 'normal',
        'size'    :  16}
plt.rc('font', **font)

# X axis
# 1 month
xlimites1 = [0, 2.6e6]
# 1 year
xlimites2 = [0, 3.153e7]

# Fix y-axis? (False=autoadjust y-axis, True=use range indicvated in 'labels' below)
fixy = True
# save figures as png?
savefigures = False
# - - - - - - - - - - - - - - - - - - - - - -

# Do some preparatory stuff
# ===========================================================================================

# read data
myd = genfromtxt('point_dump.csv', delimiter=',')
with open('point_dump.csv', 'r') as f:
  fline = f.readline().strip().split(',')

# find time
print fline
Time = fline.index("Time1")
print "Time index is : %s" %Time

# generate normalisation values 
# find means
name    ='Demand_time_mean'
namenet ='Demand_time_mean_net'
meanvar    = fline.index(name)
meanvarnet = fline.index(namenet)
print "Time index of  %s is : %s" %(name,meanvar)
print "Time index of %s is : %s" %(namenet,meanvarnet)
avg    = mean(myd[1:,meanvar])
avgnet = mean(myd[1:,meanvarnet])
print "Time mean of %s is : %s" %(name,avg)
print "Time mean of %s is : %s" %(namenet,avgnet)
toavg    = copy(myd[1:,meanvar])
toavgnet = copy(myd[1:,meanvarnet])

# === Make the plots  ===
# ===========================================================================================

for plotthis in ['Demand_time_variance', 'Demand_time_mean', 'Demand_time_percentile_5', 'Demand_time_percentile_95', 'Demand_time_percentile_0.001', 'Demand_time_percentile_99.999','Demand_time_percentile_1', 'Demand_time_percentile_99']:

  # define labels: plotthis : ['plot y axis label', 'plot save name', 'y axis range (if fixy=True above)']
  labels = {'Demand_time_variance': ['Sigma', 'Sigma', [0,0.3]],
           'Demand_time_mean': ['Demand', 'Demand', [0.5,1.5]],
           'Demand_time_percentile_5': ['5th percentile','Percentile_5', [0.2,1.2]],
           'Demand_time_percentile_95': ['95th percentile', 'Percentile_95',[0.8,1.8]],
           'Demand_time_percentile_0.001': ['0.001th percentile', 'Percentile_0.001',[0.0,1.1]],
           'Demand_time_percentile_99.999': ['99.999th percentile', 'Percentile_99.999',[0.8,2.3]],
           'Demand_time_percentile_1': ['1st percentile', 'Percentile_1',[0.0,1.2]],
           'Demand_time_percentile_99': ['99th percentile', 'Percentile_99',[0.8,2.0]]
            }

# find the guy
  name    = plotthis
  namenet = plotthis + "_net"
  plotvar    = fline.index(name)
  plotvarnet = fline.index(namenet)
  print "Time index plotvar %s is : %s" %(name,plotvar)
  print "Time index plotvar %s is : %s" %(namenet,plotvarnet)

# compute Sigmas
  if plotthis == 'Demand_time_variance':
    print "Sigma of     Demand : %s"  %(sqrt(mean(myd[1:,plotvar]))/avg)
    print "Sigma of Net Demand : %s"  %(sqrt(mean(myd[1:,plotvarnet]))/avgnet)

    # normalise with global means
    mydn1_d = []
    myd_in = copy(myd)
    for l in myd_in:
      l[plotvar] = sqrt(l[plotvar])/avg
      l[plotvarnet] = sqrt(l[plotvarnet])/avgnet
      mydn1_d.append(l)
    mydn1_d = array(mydn1_d)

    # normalise step by step with time dependent mean
    mydn1_s = []
    i = -1
    myd_in = copy(myd)
    for l in myd_in:
      l[plotvar] = sqrt(l[plotvar])/toavg[i]
      l[plotvarnet] = sqrt(l[plotvarnet])/toavgnet[i]
      mydn1_s.append(l)
      i += 1
    mydn1_s = array(mydn1_s)

# compute mean and precentilles
  else:
    mydn1_d = []
    myd_in = copy(myd)
    for l in myd_in:
      l[plotvar] = l[plotvar]/avg 
      l[plotvarnet] = l[plotvarnet]/avgnet
      mydn1_d.append(l)
    mydn1_d = array(mydn1_d)

    # normalise step by step with time dependent mean
    mydn1_s = []
    i = -1
    myd_in = copy(myd)
    for l in myd_in:
      l[plotvar] = l[plotvar]/toavg[i]
      l[plotvarnet] = l[plotvarnet]/toavgnet[i]
      mydn1_s.append(l)
      i += 1
    mydn1_s = array(mydn1_s)


# make the plots
# 1.   Year
# 1.1  Norm with global means
  fig = plt.figure()
  ax = fig.add_subplot(111)
  scat1 = plt.plot(mydn1_d[1:,Time], mydn1_d[1:,plotvar],    label='Demand')
  scat2 = plt.plot(mydn1_d[1:,Time], mydn1_d[1:,plotvarnet], label='Net Demand')
  labx = plt.xlabel('Time [s]')
  laby = plt.ylabel(labels[plotthis][0])
  leg = ax.legend(loc='upper right')
  axx = ax.set_xlim(xlimites2)
  if fixy == True:
    ayy = ax.set_ylim(labels[plotthis][2])
  if savefigures == True:
    fig.savefig('Year_Global_' + labels[plotthis][1] + '.png')
# 1.1  Norm with time dep means
  fig = plt.figure()
  ax = fig.add_subplot(111)
  scat1 = plt.plot(mydn1_s[1:,Time], mydn1_s[1:,plotvar],    label='Demand')
  scat2 = plt.plot(mydn1_s[1:,Time], mydn1_s[1:,plotvarnet], label='Net Demand')
  labx = plt.xlabel('Time [s]')
  laby = plt.ylabel(labels[plotthis][0])  
  leg = ax.legend(loc='upper right')
  axx = ax.set_xlim(xlimites2)
  if fixy == True:
    ayy = ax.set_ylim(labels[plotthis][2])
  if savefigures == True:
    fig.savefig('Year_TimeDep_' + labels[plotthis][1] + '.png')
# 2.   Month
# 1.1  Norm with global means
  fig = plt.figure()
  ax = fig.add_subplot(111)
  scat1 = plt.plot(mydn1_d[1:,Time], mydn1_d[1:,plotvar],    label='Demand')
  scat2 = plt.plot(mydn1_d[1:,Time], mydn1_d[1:,plotvarnet], label='Net Demand')
  labx = plt.xlabel('Time [s]')
  laby = plt.ylabel(labels[plotthis][0]) 
  leg = ax.legend(loc='upper right')
  axx = ax.set_xlim(xlimites1)
  if fixy == True:
    ayy = ax.set_ylim(labels[plotthis][2])
  if savefigures == True:
    fig.savefig('Month_Global_' + labels[plotthis][1] + '.png')
# 1.1  Norm with time dep means
  fig = plt.figure()
  ax = fig.add_subplot(111)
  scat1 = plt.plot(mydn1_s[1:,Time], mydn1_s[1:,plotvar],    label='Demand')
  scat2 = plt.plot(mydn1_s[1:,Time], mydn1_s[1:,plotvarnet], label='Net Demand')
  labx = plt.xlabel('Time [s]')
  laby = plt.ylabel(labels[plotthis][0])
  leg = ax.legend(loc='upper right')
  axx = ax.set_xlim(xlimites1)
  if fixy == True:
    ayy = ax.set_ylim(labels[plotthis][2])
  if savefigures == True:
    fig.savefig('Month_TimeDep_' + labels[plotthis][1] + '.png')

# for interactive mode
if not savefigures:
  plt.show()


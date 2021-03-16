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

lfontsize= 9

# X axis
# 1 month
xlimites1 = [0, 30]
# 1 year
xlimites2 = [0, 365]

fixy = True
savefigures = True
# - - - - - - - - - - - - - - - - - - - - - -

# Do some preparatory stuff
# ===========================================================================================

# read data
# put path to files here
filename1 = '10percentWind/point_dump.csv'
filename2 = '20percentWind/point_dump.csv'
filename3 = '30percentWind/point_dump.csv'
filename4 = '40percentWind/point_dump.csv'
filename5 = '50percentWind/point_dump.csv'

myd1 = genfromtxt(filename1, delimiter=',')
myd2 = genfromtxt(filename2, delimiter=',')
myd3 = genfromtxt(filename3, delimiter=',')
myd4 = genfromtxt(filename4, delimiter=',')
myd5 = genfromtxt(filename5, delimiter=',')
with open(filename1, 'r') as f:
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
avg    = mean(myd1[1:,meanvar])
avgnet1 = mean(myd1[1:,meanvarnet])
avgnet2 = mean(myd2[1:,meanvarnet])
avgnet3 = mean(myd3[1:,meanvarnet])
avgnet4 = mean(myd4[1:,meanvarnet])
avgnet5 = mean(myd5[1:,meanvarnet])
print "Time mean of %s is : %s" %(name,avg)
print "Time mean of %s is : %s" %(namenet,avgnet1)
print "Time mean of %s is : %s" %(namenet,avgnet2)
print "Time mean of %s is : %s" %(namenet,avgnet3)
print "Time mean of %s is : %s" %(namenet,avgnet4)
print "Time mean of %s is : %s" %(namenet,avgnet5)

toavg     = copy(myd1[1:,meanvar])
toavgnet1 = copy(myd1[1:,meanvarnet])
toavgnet2 = copy(myd2[1:,meanvarnet])
toavgnet3 = copy(myd3[1:,meanvarnet])
toavgnet4 = copy(myd4[1:,meanvarnet])
toavgnet5 = copy(myd5[1:,meanvarnet])

#print "Hallo debug"
#print toavgnet5


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
    print "Sigma of     Demand : %s"  %(sqrt(mean(myd1[1:,plotvar]))/avg)
    print "Sigma of Net Demand : %s"  %(sqrt(mean(myd1[1:,plotvarnet]))/avgnet1)
    print "Sigma of Net Demand : %s"  %(sqrt(mean(myd2[1:,plotvarnet]))/avgnet2)
    print "Sigma of Net Demand : %s"  %(sqrt(mean(myd3[1:,plotvarnet]))/avgnet3)
    print "Sigma of Net Demand : %s"  %(sqrt(mean(myd4[1:,plotvarnet]))/avgnet4)
    print "Sigma of Net Demand : %s"  %(sqrt(mean(myd5[1:,plotvarnet]))/avgnet5)

    print "Sigma1 of     Demand : %s"  %(mean(sqrt(myd1[1:,plotvar]))/avg)
    print "Sigma1 of Net Demand : %s"  %(mean(sqrt(myd1[1:,plotvarnet]))/avgnet1)
    print "Sigma1 of Net Demand : %s"  %(mean(sqrt(myd2[1:,plotvarnet]))/avgnet2)
    print "Sigma1 of Net Demand : %s"  %(mean(sqrt(myd3[1:,plotvarnet]))/avgnet3)
    print "Sigma1 of Net Demand : %s"  %(mean(sqrt(myd4[1:,plotvarnet]))/avgnet4)
    print "Sigma1 of Net Demand : %s"  %(mean(sqrt(myd5[1:,plotvarnet]))/avgnet5)

    # normalise with global means
    mydn1_d = []
    myd1_in = copy(myd1)
    for l in myd1_in:
      l[plotvar] = sqrt(l[plotvar])/avg 
      l[plotvarnet] = sqrt(l[plotvarnet])/avgnet1
      mydn1_d.append(l)
    mydn1_d = array(mydn1_d)
    mydn2_d = []
    myd2_in = copy(myd2)
    for l in myd2_in:
      l[plotvar] = sqrt(l[plotvar])/avg 
      l[plotvarnet] = sqrt(l[plotvarnet])/avgnet2
      mydn2_d.append(l)
    mydn2_d = array(mydn2_d)
    mydn3_d = []
    myd3_in = copy(myd3)
    for l in myd3_in:
      l[plotvar] = sqrt(l[plotvar])/avg 
      l[plotvarnet] = sqrt(l[plotvarnet])/avgnet3
      mydn3_d.append(l)
    mydn3_d = array(mydn3_d)
    mydn4_d = []
    myd4_in = copy(myd4)
    for l in myd4_in:
      l[plotvar] = sqrt(l[plotvar])/avg 
      l[plotvarnet] = sqrt(l[plotvarnet])/avgnet4
      mydn4_d.append(l)
    mydn4_d = array(mydn4_d)
    mydn5_d = []
    myd5_in = copy(myd5)
    for l in myd5_in:
      l[plotvar] = sqrt(l[plotvar])/avg 
      l[plotvarnet] = sqrt(l[plotvarnet])/avgnet5
      mydn5_d.append(l)
    mydn5_d = array(mydn5_d)
    # normalise step by step with time dependent mean
    mydn1_s = []
    i = -1
    myd1_in = copy(myd1)
    for l in myd1_in:
      l[plotvar] = sqrt(l[plotvar])/toavg[i]
      l[plotvarnet] = sqrt(l[plotvarnet])/toavgnet1[i]
      mydn1_s.append(l)
      i += 1
    mydn1_s = array(mydn1_s)
    mydn2_s = []
    i = -1
    myd2_in = copy(myd2)
    for l in myd2_in:
      l[plotvar] = sqrt(l[plotvar])/toavg[i]
      l[plotvarnet] = sqrt(l[plotvarnet])/toavgnet2[i]
      mydn2_s.append(l)
      i += 1
    mydn2_s = array(mydn2_s)
    mydn3_s = []
    i = -1
    myd3_in = copy(myd3)
    for l in myd3_in:
      l[plotvar] = sqrt(l[plotvar])/toavg[i]
      l[plotvarnet] = sqrt(l[plotvarnet])/toavgnet3[i]
      mydn3_s.append(l)
      i += 1
    mydn3_s = array(mydn3_s)
    mydn4_s = []
    i = -1
    myd4_in = copy(myd4)
    for l in myd4_in:
      l[plotvar] = sqrt(l[plotvar])/toavg[i]
      l[plotvarnet] = sqrt(l[plotvarnet])/toavgnet4[i]
      mydn4_s.append(l)
      i += 1
    mydn4_s = array(mydn4_s)
    mydn5_s = []
    i = -1
    myd5_in = copy(myd5)
    for l in myd5_in:
      l[plotvar] = sqrt(l[plotvar])/toavg[i]
      l[plotvarnet] = sqrt(l[plotvarnet])/toavgnet5[i]
      mydn5_s.append(l)
      i += 1
    mydn5_s = array(mydn5_s)
# compute mean and precentilles
  else:
    mydn1_d = []
    myd1_in = copy(myd1)
    for l in myd1_in:
      l[plotvar] = l[plotvar]/avg 
      l[plotvarnet] = l[plotvarnet]/avgnet1
      mydn1_d.append(l)
    mydn1_d = array(mydn1_d)
    mydn2_d = []
    myd2_in = copy(myd2)
    for l in myd2_in:
      l[plotvar] = l[plotvar]/avg 
      l[plotvarnet] = l[plotvarnet]/avgnet2
      mydn2_d.append(l)
    mydn2_d = array(mydn2_d)
    mydn3_d = []
    myd3_in = copy(myd3)
    for l in myd3_in:
      l[plotvar] = l[plotvar]/avg 
      l[plotvarnet] = l[plotvarnet]/avgnet3
      mydn3_d.append(l)
    mydn3_d = array(mydn3_d)
    mydn4_d = []
    myd4_in = copy(myd4)
    for l in myd4_in:
      l[plotvar] = l[plotvar]/avg 
      l[plotvarnet] = l[plotvarnet]/avgnet4
      mydn4_d.append(l)
    mydn4_d = array(mydn4_d)
    mydn5_d = []
    myd5_in = copy(myd5)
    for l in myd5_in:
      l[plotvar] = l[plotvar]/avg 
      l[plotvarnet] = l[plotvarnet]/avgnet5
      mydn5_d.append(l)
    mydn5_d = array(mydn5_d)

    # normalise step by step with time dependent mean
    mydn1_s = []
    i = -1
    myd1_in = copy(myd1)
    for l in myd1_in:
      l[plotvar] = l[plotvar]/toavg[i]
      l[plotvarnet] = l[plotvarnet]/toavgnet1[i]
      mydn1_s.append(l)
      i += 1
    mydn1_s = array(mydn1_s)
    mydn2_s = []
    i = -1
    myd2_in = copy(myd2)
    for l in myd2_in:
      l[plotvar] = l[plotvar]/toavg[i]
      l[plotvarnet] = l[plotvarnet]/toavgnet2[i]
      mydn2_s.append(l)
      i += 1
    mydn2_s = array(mydn2_s)
    mydn3_s = []
    i = -1
    myd3_in = copy(myd3)
    for l in myd3_in:
      l[plotvar] = l[plotvar]/toavg[i]
      l[plotvarnet] = l[plotvarnet]/toavgnet3[i]
      mydn3_s.append(l)
      i += 1
    mydn3_s = array(mydn3_s)
    mydn4_s = []
    i = -1
    myd4_in = copy(myd4)
    for l in myd4_in:
      l[plotvar] = l[plotvar]/toavg[i]
      l[plotvarnet] = l[plotvarnet]/toavgnet4[i]
      mydn4_s.append(l)
      i += 1
    mydn4_s = array(mydn4_s)
    mydn5_s = []
    i = -1
    myd5_in = copy(myd5)
    for l in myd5_in:
      l[plotvar] = l[plotvar]/toavg[i]
      l[plotvarnet] = l[plotvarnet]/toavgnet5[i]
      mydn5_s.append(l)
      i += 1
    mydn5_s = array(mydn5_s)

# make the plots

# change time do days
  mydn1_d[1:,Time] = mydn1_d[1:,Time]/86400
  mydn2_d[1:,Time] = mydn2_d[1:,Time]/86400
  mydn3_d[1:,Time] = mydn3_d[1:,Time]/86400
  mydn4_d[1:,Time] = mydn4_d[1:,Time]/86400
  mydn5_d[1:,Time] = mydn5_d[1:,Time]/86400
  mydn1_s[1:,Time] = mydn1_s[1:,Time]/86400
  mydn2_s[1:,Time] = mydn2_s[1:,Time]/86400
  mydn3_s[1:,Time] = mydn3_s[1:,Time]/86400
  mydn4_s[1:,Time] = mydn4_s[1:,Time]/86400
  mydn5_s[1:,Time] = mydn5_s[1:,Time]/86400


# 1.   Year
# 1.1  Norm with global means
  fig = plt.figure()
  ax = fig.add_subplot(111)
  scat1 = plt.plot(mydn1_d[1:,Time], mydn1_d[1:,plotvar],    label='Demand')
  scat2 = plt.plot(mydn1_d[1:,Time], mydn1_d[1:,plotvarnet], label='Net Demand (10% wind penetration (installed))')
  scat2 = plt.plot(mydn2_d[1:,Time], mydn2_d[1:,plotvarnet], label='Net Demand (20% wind penetration (installed))')
  scat2 = plt.plot(mydn3_d[1:,Time], mydn3_d[1:,plotvarnet], label='Net Demand (30% wind penetration (installed))')
  scat2 = plt.plot(mydn4_d[1:,Time], mydn4_d[1:,plotvarnet], label='Net Demand (40% wind penetration (installed))')
  scat2 = plt.plot(mydn5_d[1:,Time], mydn5_d[1:,plotvarnet], label='Net Demand (50% wind penetration (installed))')
  labx = plt.xlabel('Time [d]')
  laby = plt.ylabel(labels[plotthis][0])
  leg = ax.legend(loc='best', fontsize=lfontsize)
  axx = ax.set_xlim(xlimites2)
  if fixy == True:
    ayy = ax.set_ylim(labels[plotthis][2])
  if savefigures == True:
    fig.savefig('Year_Global_' + labels[plotthis][1] + '.png')
# 1.1  Norm with time dep means
  fig = plt.figure()
  ax = fig.add_subplot(111)
  scat1 = plt.plot(mydn1_s[1:,Time], mydn1_s[1:,plotvar],    label='Demand')
  scat2 = plt.plot(mydn1_s[1:,Time], mydn1_s[1:,plotvarnet], label='Net Demand (10% wind penetration (installed))')
  scat2 = plt.plot(mydn2_s[1:,Time], mydn2_s[1:,plotvarnet], label='Net Demand (20% wind penetration (installed))')
  scat2 = plt.plot(mydn3_s[1:,Time], mydn3_s[1:,plotvarnet], label='Net Demand (30% wind penetration (installed))')
  scat2 = plt.plot(mydn4_s[1:,Time], mydn4_s[1:,plotvarnet], label='Net Demand (40% wind penetration (installed))')
  scat2 = plt.plot(mydn5_s[1:,Time], mydn5_s[1:,plotvarnet], label='Net Demand (50% wind penetration (installed))')
  labx = plt.xlabel('Time [d]')
  laby = plt.ylabel(labels[plotthis][0])  
  leg = ax.legend(loc='best', fontsize=lfontsize)
  axx = ax.set_xlim(xlimites2)
  if fixy == True:
    ayy = ax.set_ylim(labels[plotthis][2])
  if savefigures == True:
    fig.savefig('Year_TimeDep_' + labels[plotthis][1] + '.png')

  # make some special plots
  if plotthis == 'Demand_time_percentile_99.999': 
    fig = plt.figure()
    ax = fig.add_subplot(111)
    scat1 = plt.plot(mydn1_d[1:,Time], mydn1_d[1:,plotvar],    label='Demand')
    labx = plt.xlabel('Time [d]')
    laby = plt.ylabel(labels[plotthis][0])
    leg = ax.legend(loc='best', fontsize=lfontsize)
    axx = ax.set_xlim(xlimites2)
    if fixy == True:
      ayy = ax.set_ylim(labels[plotthis][2])
    if savefigures == True:
      fig.savefig('Year_Global_demandonly' + labels[plotthis][1] + '.png')
    fig = plt.figure()
    ax = fig.add_subplot(111)
    scat2 = plt.plot(mydn5_d[1:,Time], mydn5_d[1:,plotvarnet], label='Net Demand (50% wind penetration (installed))')
    labx = plt.xlabel('Time [d]')
    laby = plt.ylabel(labels[plotthis][0])
    leg = ax.legend(loc='best', fontsize=lfontsize)
    axx = ax.set_xlim(xlimites2)
    if fixy == True:
      ayy = ax.set_ylim(labels[plotthis][2])
    if savefigures == True:
      fig.savefig('Year_Global_50percentonly' + labels[plotthis][1] + '.png')


# chaneg x axis to february for monthly plots
  mydn1_d[1:,Time] = mydn1_d[1:,Time] - 31.0
  mydn2_d[1:,Time] = mydn2_d[1:,Time] - 31.0
  mydn3_d[1:,Time] = mydn3_d[1:,Time] - 31.0
  mydn4_d[1:,Time] = mydn4_d[1:,Time] - 31.0
  mydn5_d[1:,Time] = mydn5_d[1:,Time] - 31.0

# 2.   Month
# 1.1  Norm with global means
  fig = plt.figure()
  ax = fig.add_subplot(111)
  scat1 = plt.plot(mydn1_d[1:,Time], mydn1_d[1:,plotvar],    label='Demand')
  scat2 = plt.plot(mydn1_d[1:,Time], mydn1_d[1:,plotvarnet], label='Net Demand (10% wind penetration (installed))')
  scat2 = plt.plot(mydn2_d[1:,Time], mydn2_d[1:,plotvarnet], label='Net Demand (20% wind penetration (installed))')
  scat2 = plt.plot(mydn3_d[1:,Time], mydn3_d[1:,plotvarnet], label='Net Demand (30% wind penetration (installed))')
  scat2 = plt.plot(mydn4_d[1:,Time], mydn4_d[1:,plotvarnet], label='Net Demand (40% wind penetration (installed))')
  scat2 = plt.plot(mydn5_d[1:,Time], mydn5_d[1:,plotvarnet], label='Net Demand (50% wind penetration (installed))')
  labx = plt.xlabel('Time [d]')
  laby = plt.ylabel(labels[plotthis][0]) 
  leg = ax.legend(loc='best', fontsize=lfontsize)
  axx = ax.set_xlim(xlimites1)
  if fixy == True:
    ayy = ax.set_ylim(labels[plotthis][2])
  if savefigures == True:
    fig.savefig('Month_Global_' + labels[plotthis][1] + '.png')
# 1.1  Norm with time dep means
  fig = plt.figure()
  ax = fig.add_subplot(111)
  scat1 = plt.plot(mydn1_s[1:,Time], mydn1_s[1:,plotvar],    label='Demand')
  scat2 = plt.plot(mydn1_s[1:,Time], mydn1_s[1:,plotvarnet], label='Net Demand (10% wind penetration (installed))')
  scat2 = plt.plot(mydn2_s[1:,Time], mydn2_s[1:,plotvarnet], label='Net Demand (20% wind penetration (installed))')
  scat2 = plt.plot(mydn3_s[1:,Time], mydn3_s[1:,plotvarnet], label='Net Demand (30% wind penetration (installed))')
  scat2 = plt.plot(mydn4_s[1:,Time], mydn4_s[1:,plotvarnet], label='Net demand (40% wind penetration (installed))')
  scat2 = plt.plot(mydn5_s[1:,Time], mydn5_s[1:,plotvarnet], label='Net Demand (50% wind penetration (installed))')
  labx = plt.xlabel('Time [d]')
  laby = plt.ylabel(labels[plotthis][0])
  leg = ax.legend(loc='best', fontsize=lfontsize)
  axx = ax.set_xlim(xlimites1)
  if fixy == True:
    ayy = ax.set_ylim(labels[plotthis][2])
  if savefigures == True:
    fig.savefig('Month_TimeDep_' + labels[plotthis][1] + '.png')

# for interactive mode
if not savefigures:
  plt.show()


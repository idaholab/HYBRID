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
from numpy import genfromtxt, array
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from os import getcwd, path

# Set some global attributes fro the plots
font = {'family'  : 'sans-serif',
        'style'   : 'normal',
        'variant' : 'normal',
        'weight'  : 'normal',
        'size'    :  16}
plt.rc('font', **font)


#prepaere data
myd = genfromtxt('dumpAll.csv', delimiter=',')
mydn = myd

#read Optimisation data
# path to optimisation data
opt_where = './'
# uncoment next 2 lines if Optimisation data is in a different directory than the grid data
#opthere = getcwd().split('/')
#opt_where = opt_where + '/' + opthere[-2] + '/' + opthere[-1] + '/'

x = list(mydn[1:,0])
y = list(mydn[1:,5])
c = list(mydn[1:,1])
s = [20]*len(mydn[1:,0])

if path.isfile(opt_where + '1.25/dumpCSV_0.csv'):
  mydOPT1 = genfromtxt(opt_where + '1.25/dumpCSV_0.csv', delimiter=',')
  x = x + [mydOPT1[-1,0]]
  y = y + [mydOPT1[-1,1]]
  c = c + [1.25]
  s = s + [75] 

if path.isfile(opt_where + '1.5/dumpCSV_0.csv'):
  mydOPT2 = genfromtxt(opt_where + '1.5/dumpCSV_0.csv', delimiter=',')
  x = x + [mydOPT2[-1,0]]
  y = y + [mydOPT2[-1,1]]
  c = c + [1.5]
  s = s + [75] 

if path.isfile(opt_where + '1.75/dumpCSV_0.csv'):
  mydOPT3 = genfromtxt(opt_where + '1.75/dumpCSV_0.csv', delimiter=',')
  x = x + [mydOPT3[-1,0]]
  y = y + [mydOPT3[-1,1]]
  c = c + [1.75]
  s = s + [75] 

if path.isfile(opt_where + '2.0/dumpCSV_0.csv'):
  mydOPT4 = genfromtxt(opt_where + '2.0/dumpCSV_0.csv', delimiter=',')
  x = x + [mydOPT4[-1,0]]
  y = y + [mydOPT4[-1,1]]
  c = c + [2.0]
  s = s + [75] 

if path.isfile(opt_where + '3.0/dumpCSV_0.csv'):
  mydOPT5 = genfromtxt(opt_where + '3.0/dumpCSV_0.csv', delimiter=',')
  x = x + [mydOPT5[-1,0]]
  y = y + [mydOPT5[-1,1]]
  c = c + [3.0]
  s = s + [75] 

# make the plot
# ========================

# ==== IRR ===============
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
scat = ax.scatter3D(x, c, y, c=c, label="H2 price [$/kg]", marker='o', s=s)
labx = ax.set_xlabel('IP capacity [W]')
laby = ax.set_ylabel('H2 price [$/kg]')
labz = ax.set_zlabel('IRR []')
cbar = fig.colorbar(scat)
cbar.set_label('H2 price [$/kg]')
fig.savefig('IRR_3D_scatter.png')

# 2d projections
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(x, y, c=c, marker='o', s=s)
labx = plt.xlabel('IP capacity [W]')
laby = plt.ylabel('IRR []')
cbar = plt.colorbar(scast1)
cbar.set_label('H2 price [$/kg]')
fig.savefig('IRR_Capacity_projection.png')

# 2d projections
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(c, y, c=x, marker='o', s=s)
labx = plt.xlabel('H2 price [$/kg]')
laby = plt.ylabel('IRR []')
cbar = plt.colorbar(scast1)
cbar.set_label('IP capacity [W]')
fig.savefig('IRR_H2price_projection.png')

# ==== plot capacty factors ===============
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
scat = ax.scatter3D(mydn[1:,0], mydn[1:,1], mydn[1:,7], c=mydn[1:,1], label="IRR", marker='o', s=s)
labx = ax.set_xlabel('IP capacity [W]')
laby = ax.set_ylabel('H2 price [$/kg]')
labz = ax.set_zlabel('IP capacity factor []')
cbar = fig.colorbar(scat)
cbar.set_label('H2 price [$/kg]')
fig.savefig('IPfact_3D_scatter.png')

# 2d projections
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(mydn[1:,0], mydn[1:,7], c=mydn[1:,1], marker='o', s=s)
labx = plt.xlabel('IP capacity [W]')
laby = plt.ylabel('IP capacity factor []')
cbar = plt.colorbar(scast1)
cbar.set_label('H2 price [$/kg]')
fig.savefig('IPfact_Capacity_projection.png')

# 2d projections
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(mydn[1:,1], mydn[1:,7], c=mydn[1:,0], marker='o', s=s)
labx = plt.xlabel('H2 price [$/kg]')
laby = plt.ylabel('IP capacity factor []')
cbar = plt.colorbar(scast1)
cbar.set_label('IP capacity [W]')
fig.savefig('IPfact_H2price_projection.png')

# ==== plot PI ===============
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
scat = ax.scatter3D(mydn[1:,0], mydn[1:,1], mydn[1:,10], c=mydn[1:,1], label="IRR", marker='o', s=s)
labx = ax.set_xlabel('IP capacity [W]')
laby = ax.set_ylabel('H2 price [$/kg]')
labz = ax.set_zlabel('PI []')
cbar = fig.colorbar(scat)
cbar.set_label('H2 price [$/kg]')
fig.savefig('PI_3D_scatter.png')

# 2d projections
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(mydn[1:,0], mydn[1:,10], c=mydn[1:,1], marker='o', s=s)
labx = plt.xlabel('IP capacity [W]')
laby = plt.ylabel('IP capacity factor []')
cbar = plt.colorbar(scast1)
cbar.set_label('H2 price [$/kg]')
fig.savefig('PI_Capacity_projection.png')

# 2d projections
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(mydn[1:,1], mydn[1:,10], c=mydn[1:,0], marker='o', s=s)
labx = plt.xlabel('H2 price [$/kg]')
laby = plt.ylabel('PI []')
cbar = plt.colorbar(scast1)
cbar.set_label('IP capacity [W]')
fig.savefig('PI_H2price_projection.png')

plt.show()



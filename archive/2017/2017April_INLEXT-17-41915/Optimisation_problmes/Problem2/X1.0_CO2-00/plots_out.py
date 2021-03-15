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

# =============== change here !!! =================
X = 1.0
# ==================================================

#prepaere data
myd = genfromtxt('dumpAll.csv', delimiter=',')
mydn = myd

#read Optimisation data
# path to optimisation data
opt_where = './'
# uncoment next 2 lines if Optimisation data is in a different directory than the grid data
#opthere = getcwd().split('/')
#opt_where = opt_where + '/' + opthere[-2] + '/' + opthere[-1] + '/'

x = list(mydn[1:,0])       # IP capacity
y = list(mydn[1:,2])       # BOP capacity
z = list(mydn[1:,1])       # H2 price
c = list(mydn[1:,12])      # NPV
s = [20]*len(mydn[1:,0])   

if path.isfile(opt_where + '1.25/dumpCSV_0.csv'):
  mydOPT1 = genfromtxt(opt_where + '1.25/dumpCSV_0.csv', delimiter=',')
  BOP_capex = mydOPT1[-1,2] * mydOPT1[-1,0]
  IP_capex = mydOPT1[-1,2] - BOP_capex
  BOP_capacity = (BOP_capex/4510000000)**(1/0.64) * 1100000000
  IP_capacity = (IP_capex/153000000)**(1/X) * 231000000
  x = x + [IP_capacity]
  y = y + [BOP_capacity]
  c = c + [mydOPT1[-1,1]]
  z = z + [1.21052631579]
  s = s + [75] 

if path.isfile(opt_where + '1.5/dumpCSV_0.csv'):
  mydOPT1 = genfromtxt(opt_where + '1.5/dumpCSV_0.csv', delimiter=',')
  BOP_capex = mydOPT1[-1,2] * mydOPT1[-1,0]
  IP_capex = mydOPT1[-1,2] - BOP_capex
  BOP_capacity = (BOP_capex/4510000000)**(1/0.64) * 1100000000
  IP_capacity = (IP_capex/153000000)**(1/X) * 231000000
  x = x + [IP_capacity]
  y = y + [BOP_capacity]
  c = c + [mydOPT1[-1,1]]
  z = z + [1.52631578947]
  s = s + [75] 

if path.isfile(opt_where + '1.75/dumpCSV_0.csv'):
  mydOPT1 = genfromtxt(opt_where + '1.75/dumpCSV_0.csv', delimiter=',')
  BOP_capex = mydOPT1[-1,2] * mydOPT1[-1,0]
  IP_capex = mydOPT1[-1,2] - BOP_capex
  BOP_capacity = (BOP_capex/4510000000)**(1/0.64) * 1100000000
  IP_capacity = (IP_capex/153000000)**(1/X) * 231000000
  x = x + [IP_capacity]
  y = y + [BOP_capacity]
  c = c + [mydOPT1[-1,1]]
  z = z + [1.73684210526]
  s = s + [75] 

if path.isfile(opt_where + '2.0/dumpCSV_0.csv'):
  mydOPT1 = genfromtxt(opt_where + '2.0/dumpCSV_0.csv', delimiter=',')
  BOP_capex = mydOPT1[-1,2] * mydOPT1[-1,0]
  IP_capex = mydOPT1[-1,2] - BOP_capex
  BOP_capacity = (BOP_capex/4510000000)**(1/0.64) * 1100000000
  IP_capacity = (IP_capex/153000000)**(1/X) * 231000000
  x = x + [IP_capacity]
  y = y + [BOP_capacity]
  c = c + [mydOPT1[-1,1]]
  z = z + [2.05263157895]
  s = s + [75] 

if path.isfile(opt_where + '3.0/dumpCSV_0.csv'):
  mydOPT1 = genfromtxt(opt_where + '3.0/dumpCSV_0.csv', delimiter=',')
  BOP_capex = mydOPT1[-1,2] * mydOPT1[-1,0]
  IP_capex = mydOPT1[-1,2] - BOP_capex
  BOP_capacity = (BOP_capex/4510000000)**(1/0.64) * 1100000000
  IP_capacity = (IP_capex/153000000)**(1/X) * 231000000
  x = x + [IP_capacity]
  y = y + [BOP_capacity]
  c = c + [mydOPT1[-1,1]]
  z = z + [3.0]
  s = s + [75] 


# make the plot
# ========================

# 3d scatter
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
scat = ax.scatter3D(x, y, z, c=c, label="NPV", s=s)
labx = ax.set_xlabel('IP capacity [W]')
laby = ax.set_ylabel('Nuc capacity [W]')
laby = ax.set_zlabel('H2 price [$/kg]')
#labz = ax.set_zlabel('Battery capacity [kW]')
cbar = fig.colorbar(scat)
cbar.set_label('NPV [$]')
fig.savefig('3D_scatter_price.png')

# 3d scatter
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
scat = ax.scatter3D(x, y, c, c=z, label="NPV", s=s)
labx = ax.set_xlabel('IP capacity [W]')
laby = ax.set_ylabel('Nuc capacity [W]')
labz = ax.set_zlabel('NPV [$]')
cbar = fig.colorbar(scat)
cbar.set_label('H2 price [$/kg]')
fig.savefig('3D_scatter_NPV.png')


# make plots for fixed H2 price

H2_price = 1.21052631579 
x_p = []
y_p = []
z_p = []
c_p = []
s_p = []
for i in range(len(x)):
  if z[i] == H2_price:
    x_p.append(x[i])  # IP capacity
    y_p.append(y[i])  # BOP capacity
    c_p.append(c[i])  # NPV
    s_p.append(s[i])  # Marker
# 3d fro fixed H2 price
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(x_p, y_p, c=c_p, s=s_p)
labx = plt.xlabel('IP capacity [W]')
laby = plt.ylabel('Nuc capacity [W]')
cbar = plt.colorbar(scast1)
cbar.set_label('NPV [$]')
fig.savefig('2d_h2_1.25.png')

H2_price = 1.52631578947 
x_p = []
y_p = []
z_p = []
c_p = []
s_p = []
for i in range(len(x)):
  if z[i] == H2_price:
    x_p.append(x[i])  # IP capacity
    y_p.append(y[i])  # BOP capacity
    c_p.append(c[i])  # NPV
    s_p.append(s[i])  # Marker
# 3d fro fixed H2 price
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(x_p, y_p, c=c_p, s=s_p)
labx = plt.xlabel('IP capacity [W]')
laby = plt.ylabel('Nuc capacity [W]')
cbar = plt.colorbar(scast1)
cbar.set_label('NPV [$]')
fig.savefig('2d_h2_1.5.png')

H2_price = 1.73684210526
x_p = []
y_p = []
z_p = []
c_p = []
s_p = []
for i in range(len(x)):
  if z[i] == H2_price:
    x_p.append(x[i])  # IP capacity
    y_p.append(y[i])  # BOP capacity
    c_p.append(c[i])  # NPV
    s_p.append(s[i])  # Marker
# 3d fro fixed H2 price
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(x_p, y_p, c=c_p, s=s_p)
labx = plt.xlabel('IP capacity [W]')
laby = plt.ylabel('Nuc capacity [W]')
cbar = plt.colorbar(scast1)
cbar.set_label('NPV [$]')
fig.savefig('2d_h2_1.75.png')

H2_price = 2.05263157895
x_p = []
y_p = []
z_p = []
c_p = []
s_p = []
for i in range(len(x)):
  if z[i] == H2_price:
    x_p.append(x[i])  # IP capacity
    y_p.append(y[i])  # BOP capacity
    c_p.append(c[i])  # NPV
    s_p.append(s[i])  # Marker
# 3d fro fixed H2 price
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(x_p, y_p, c=c_p, s=s_p)
labx = plt.xlabel('IP capacity [W]')
laby = plt.ylabel('Nuc capacity [W]')
cbar = plt.colorbar(scast1)
cbar.set_label('NPV [$]')
fig.savefig('2d_h2_2.png')

H2_price = 3.0
x_p = []
y_p = []
z_p = []
c_p = []
s_p = []
for i in range(len(x)):
  if z[i] == H2_price:
    x_p.append(x[i])  # IP capacity
    y_p.append(y[i])  # BOP capacity
    c_p.append(c[i])  # NPV
    s_p.append(s[i])  # Marker
# 3d fro fixed H2 price
fig = plt.figure()
ax = fig.add_subplot(111)
scast1 = plt.scatter(x_p, y_p, c=c_p, s=s_p)
labx = plt.xlabel('IP capacity [W]')
laby = plt.ylabel('Nuc capacity [W]')
cbar = plt.colorbar(scast1)
cbar.set_label('NPV [$]')
fig.savefig('2d_h2_3.png')


plt.show()



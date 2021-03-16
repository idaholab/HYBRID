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
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import matplotlib.colors as colors
#from mpl_toolkits.mplot3d import Axes3D
import pandas as pd
import seaborn as sb
import xarray as xr
import sys

# Set some global attributes fro the plots
font = {'family'  : 'sans-serif',
        'style'   : 'normal',
        'variant' : 'normal',
        'weight'  : 'normal',
        'size'    :  8}
plt.rc('font', **font)


def plotall():
  import Cases
  cases = Cases.load()
  gmin = sys.float_info.max
  gmax = -sys.float_info.max
  #prep results file
  resfile = file('results_summary.csv','w')
  resfile.writelines('H2 Price, WindPen, Min LCoE, demand, SES, ES, IP, Max LCoE, demand, SES, ES, IP\n')
  for r in cases['ren']:
    for h in cases['h2']:
      case = 'h{}_r{}'.format(h,r)
      scase = 'H2 Price ${},  Wind Pen {}%'.format(int(h*100)/100.0,r)
      dmin,dmax = plot(case,scase,resfile)
      gmin = min((gmin,dmin))
      gmax = max((gmax,dmax))
      print ''
      #break
    #break
  print 'global minimum:',gmin
  print 'global maximum:',gmax

def plot(case,scase,resfile,plots='trellis'):
  print 'Plotting case',scase
  #prepaere data
  try:
    myd = pd.read_csv('printGRID_{}.csv'.format(case))
  except:
    print 'Failed to read',case
    return
  # AARON FIXME check these dictionary names are your variable names (likely no change needed)
  myd['IP_capacity'   ] *= 1e-6 #to MW
  myd['SES_capacity'  ] *= 1e-6 #to MW
  myd['ES_capacity'   ] *= 1e-6 #to MW
  myd['scaling_demand'] *= 1e-3 #to MW
  myd['NPV_mult'      ] *= 1e6  #to $/MWh

  # find independent data
  demands = sorted(list(set(myd['scaling_demand'])))
  sess    = sorted(list(set(myd['SES_capacity'])))
  ess     = sorted(list(set(myd['ES_capacity'])))
  ips     = sorted(list(set(myd['IP_capacity'])))
  # set up structure
  empty = np.zeros([len(demands),len(sess),len(ess),len(ips)])
  data = xr.DataArray(empty,coords=[('demand',demands),('SES',sess),('ES',ess),('IP',ips)])#,dims=['demand','SES','ES','IP'])
  #fill data
  for row in range(myd.shape[0]):
    row = myd.iloc[row]
    d,s,_,e,i,_,l = row
    loc = {'demand':demands.index(row['scaling_demand']),
           'SES'   :sess.index(row['SES_capacity']),
           'ES'    :ess.index(row['ES_capacity']),
           'IP'    :ips.index(row['IP_capacity'])}
    # failed, need index not value # data[{'demand':d,'SES':s,'ES':e,'IP':i}] = l
    data[loc] = l

  minspot = data.where(data==data.min(),drop=True)
  if minspot.size>1:
    minspot = minspot[0,0,0,0]
  dmin = float(data.min())
  maxspot = data.where(data==data.max(),drop=True)
  if maxspot.size>1:
    maxspot = maxspot[0,0,0,0]
  dmax = float(data.max())
  h2 = float(scase.split(',')[0].split('$')[1])
  r = int(scase.split('Pen')[1].strip(' %'))
  print "  The case minimum is:",dmin
  print minspot
  print "  The case maximum is:",dmax
  print maxspot
  resstr = ','.join(['{}']*12).format(h2,r,
                          dmin,
                          float(minspot['demand']),float(minspot['SES']),float(minspot['ES']),float(minspot['IP']),
                          dmax,
                          float(maxspot['demand']),float(maxspot['SES']),float(maxspot['ES']),float(maxspot['IP']))
  resstr += '\n'
  resfile.writelines(resstr)

  # AARON FIXME set the min and max for the color scheme
  datamin = 50
  datamax = 300

  if plots == 'trellis':
    #XARRAY DATA ARRAY FACETGRID
    p = data.plot.pcolormesh(figsize=(12,8),x='ES',y='SES',col='IP',row='demand',cmap='RdBu_r',vmin=datamin,vmax=datamax)
    # set bins for labels, so we don't crowd axis labels
    plt.locator_params(axis='y',nbins=5)
    plt.locator_params(axis='x',nbins=5)
    # adjust spacing
    plt.subplots_adjust(top=0.85,left=0.05,right=0.99,bottom=0.05,wspace=0.05,hspace=0.05)
    # titles and meta-axis labels
    fig = plt.gcf()
    title = 'Case: {}\nMajor Axes (MW): {} (top), {} (right,)\nSub Axes (MW): {} (left), {} (bottom)'.format(scase,'IP Capacity','Demand','SES Capacity','ES Capacity')
    fig.suptitle(title,size=12)
    p.set_titles(template='{value}')#,row_template='{value}')
    fig.text(0.45,0.88,'IP Capacity',size=10,horizontalalignment='center')
    fig.text(0.825,0.5,'Demand',size=10,verticalalignment='center',rotation=-90)
    # add and remove colorbar so we can get the correct instance of it
    p.cbar.remove()
    p.add_colorbar()
    # set colorbar limits, label
    p.cbar.set_clim(vmin=datamin,vmax=datamax)
    p.cbar.set_label('LCoE ($/MWh)',size=10,rotation=-90,verticalalignment='center',horizontalalignment='center')
    # set meta axis labels
    for j in range(len(demands)):
      i = len(ess)-1
      ax = p.axes[j][i]
      annos = [child for child in ax.get_children() if isinstance(child,matplotlib.text.Annotation)]
      for a in annos:
        if a.get_text().startswith('demand'):
          a.set_text(a.get_text().split('=')[1].strip())
    # save the figure
    plt.savefig(case+'.png',dpi=fig.dpi)

  # for Cristian
  elif plots == '4d':
    if case != 'h1.75_r200':
      return dmin,dmax
    from mpl_toolkits.mplot3d import Axes3D
    from itertools import product
    for ses in data['SES']:
      fig = plt.figure()
      ax = fig.add_subplot(111,projection='3d')
      points = list(product(data['demand'],data['IP'],data['ES']))
      dat = np.zeros((len(points),4))
      for p,(d,i,e) in enumerate(points):
        dat[p,0] = d
        dat[p,1] = i
        dat[p,2] = e
        dat[p,3] = float(data.loc[{'demand':d,'IP':i,'ES':e,'SES':ses}])
      img = ax.scatter(dat[:,0],dat[:,1],dat[:,2],c=dat[:,3])
      cbar = fig.colorbar(img)
      cbar.set_clim(vmin=datamin,vmax=datamax)
      cbar.set_label('LCoE ($/MWh)')
      ax.set_xlabel('Net Demand')
      ax.set_ylabel('IP Capacity')
      ax.set_zlabel('ES Capacity')
      plt.title('{}, SES {}: LCoE'.format(scase,int(ses)))
      plt.savefig(case+'ses{}_4d.png'.format(int(ses)),dpi=fig.dpi)

  return dmin,dmax



if __name__=='__main__':
  plotall()
  plt.show()
  print 'Done.'



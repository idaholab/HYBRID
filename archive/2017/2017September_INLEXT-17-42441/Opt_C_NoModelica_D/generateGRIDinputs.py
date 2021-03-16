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
import shutil

import Cases
cases = Cases.load()

basefile = 'HYBRun_noModelica_C_RrR.xml'

base = file(basefile).read()
baseQ = file('qsub_base.sh').read()


i = 1
for dem in cases['dem']:
  for SES in cases['SES']:
    for IP in cases['IP']:
      for ES in cases['ES']:
        for H2 in cases['H2']:
          for Win in cases['Win']:
            
            print "Generating case: "
            print "       demand: %s" %dem
            print "          SES: %s" %SES
            print "           IP: %s" %IP 
            print "           ES: %s" %ES 
            print "           H2: %s" %H2 
            print "          Win: %s" %Win 

            # make folde
            foldername = 'dem' + str(dem) + '_SES' + str(SES) + '_IP' + str(IP) + '_ES' + str(ES) + '_H2-' + str(H2) + '_win' + str(Win)
            print "  in folder: %s: " %foldername  
            if os.path.exists(foldername):
              print "ERROR: This folder already exuists... something wrong? ==> exiting.."
              quit()
            else:
              os.makedirs(foldername)

            # copy everything into folder
            print "  copiing files "
            for f in os.listdir("."):
              if os.path.isfile(f):
                shutil.copyfile(f, foldername +'/' + f)

            # change input
            print "  changing input file"
            newfile = base.replace("REPLACE_demand", str(dem)).replace("REPLACE_SES", str(SES)).replace("REPLACE_IP",str(IP)).replace("REPLACE_ES",str(ES)).replace("REPLACE_renewable",str(Win)).replace("REPLACE_renewabl1",str(Win+0.1)).replace("REPLACE_h2price",str(H2))
            file(foldername + '/' + basefile , 'w').write(newfile)

            # change 
            print "  changing qsub file"
            newfileQ = baseQ.replace("CASE", "CASE_" + str(i))
            file(foldername + '/qsub.sh', 'w').write(newfileQ)
            i += 1


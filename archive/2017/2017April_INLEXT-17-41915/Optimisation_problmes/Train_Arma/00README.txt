   
Prince Data
========================================
collapse data to hourly
  python collapse_time.py -i EES2012.csv -o  EES2012_collapsed.csv -collapse 12
  The collapse tool can be found in the 'Data' directory

Train ARMA
========================================
The ARMA's for the prioce is then trained with:$
raven_framework HYBRun_trainARMA.xml$





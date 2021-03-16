
This folder contains the historical (electricity demand, wind, etc) data 
collected from various websites to be used in the different Cash Flow calculations.

Electricity Demand
========================================
ERCOT
= = = = =
Data in ERCOT/ercotWestDemand_201*_RAVEN.csv for years 2011 to 2015 (hourly resolution)
http://www.ercot.com/gridinfo/load/load_hist/

Wind
========================================
NREL Site 03247
= = = = = = = = = = =
Data in NREL/SITE_03247_200*_RAVEN.csv for years 2004 to 2006 (10 minute resulution)
http://www.nrel.gov/electricity/transmission/eastern_wind_dataset.html
==> the 10 minute resolution can be averaged to hourly data using
python ./collapse_time.py -i SITE_03247_2004_RAVEN.csv -o SITE_03247_2004_RAVEN_coll.csv  -collapse 6

Price Data
========================================
MISO
= = = = =
https://www.misoenergy.org/Library/MarketReports/Pages/ArchivedAnnualReal-TimeLMP5-Min.aspx
The followinf files have been downloaded:
   201201_5MIN_LMP_zip.zip
   201204_5MIN_LMP_zip.zip
   201207_5MIN_LMP_zip.zip
   201210_5MIN_LMP_zip.zip
   201301_5MIN_LMP_zip.zip
   201304_5MIN_LMP_zip.zip
   201307_5MIN_LMP_zip.zip
   201310_5MIN_LMP_zip.zip
   201202_5MIN_LMP_zip.zip
   201205_5MIN_LMP_zip.zip
   201208_5MIN_LMP_zip.zip
   201211_5MIN_LMP_zip.zip
   201302_5MIN_LMP_zip.zip
   201305_5MIN_LMP_zip.zip
   201308_5MIN_LMP_zip.zip
   201311_5MIN_LMP_zip.zip
   201203_5MIN_LMP_zip.zip
   201206_5MIN_LMP_zip.zip
   201209_5MIN_LMP_zip.zip
   201212_5MIN_LMP_zip.zip
   201303_5MIN_LMP_zip.zip
   201306_5MIN_LMP_zip.zip
   201309_5MIN_LMP_zip.zip
   201312_5MIN_LMP_zip.zip

unzip data
  e.g. unzip 201201_5MIN_LMP_zip.zip etc.

extract regions we need
  grep EES 2012*.CSV > EES2012.csv
  => remove not needed data 
  grep EES 2013*.CSV > EES2013.csv
  => remove not needed data




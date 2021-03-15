
How to run this
===============================================

1. Train ARMA's for Wind and Demand
   => Follow Train_Arma/00README.txt

2. Run data generation
   The inputs in 10percentWind are for 100MW installed wind capacity (The average demand is 1GW => this input corresponds to 10% wind penetration).
   => inputs for other penetrations can be generates by changing "capacities_distrib" in the input production_ARMA_evaluations1.
   Runnig 'raven_framework production_ARMA_evaluations1.xml' will generate 10k samples and save them in a database in directory '1'.
   100 inputs need to be genertaed (change the HDF5 directory="1") and run to generate 1 mio runs.

3. Run statistics
   two files are provided, one for 500k statistics and for the full million.
   They can be run with
   raven_framework production_statistics_500k.xml
   raven_framework production_statistics.xml

4. Make plots
   -- !!This script is not maintained!! -- 
   This scripts was working with the original RAVEN in/outputs at the time when is was checked in.
   Only the regression tests (folderds ending in _TEST) are guaranteed to work. Changes in these tests might breack
   the proper functioning of helper scripts.
   ==> Reverting the repository (and associated RAVEN submodule) to the time when the script was checked in will
       reinstate its functionality.
   -- !!This script is not maintained!! -- 

   The statistics will produce a .csv containing all the statistics asked for.
   The file plots_out.py in the subdirectory 10percentWind just plots the 100MW (10% wind) curves (for scoping).
   The file production_plots.py in this directory plots all wind penetrations together.
   Run with 
   python production_plots.py

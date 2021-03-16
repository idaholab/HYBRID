#!/bin/bash
#PBS -N 22_CASE
#PBS -P nst
#PBS -l select=4:ncpus=24
#PBS -l walltime=70:0:0
#PBS -j oe

module load pbs
module load raven-devel-gcc

cd $PBS_O_WORKDIR

../../raven/raven_framework HYBRun_noModelica_C_RrR.xml | tee out.log

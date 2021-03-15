#!/bin/bash
#PBS -N 1_CASE
#PBS -P nst
#PBS -l select=1:ncpus=1
#PBS -l walltime=100:0:0
#PBS -j oe

module load pbs
module load raven-devel-gcc

cd $PBS_O_WORKDIR

~/project6/raven1/raven_framework HYBRun_noModelica_C_RrR.xml | tee out.log

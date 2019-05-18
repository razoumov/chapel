#!/bin/bash
#SBATCH --time=00:05:00   # walltime in d-hh:mm or hh:mm:ss format
#SBATCH --mem-per-cpu=1000   # in MB
#SBATCH --output=baseSolver.out

#./baseSolver -nl 1 --rows=30 --cols=30 --niter=2000
./baseSolver -nl 1 --rows=650 --cols=650 --niter=9500 --tolerance=0.002
# ./baseSolver -nl 1 --rows=2000 --cols=2000 --niter=9500 --tolerance=0.002

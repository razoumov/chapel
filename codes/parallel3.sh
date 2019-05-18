#!/bin/bash
#SBATCH --time=03:00:00   # walltime in d-hh:mm or hh:mm:ss format
#SBATCH --mem-per-cpu=1000   # in MB
#SBATCH --nodes=4
#SBATCH --cpus-per-task=2
#SBATCH --output=parallel3.out

#./parallel3 -nl 4 --rows=30 --cols=30 --niter=2000
./parallel3 -nl 4 --rows=650 --cols=650 --niter=9500 --tolerance=0.002
# ./parallel3 -nl 4 --rows=2000 --cols=2000 --niter=9500 --tolerance=0.002

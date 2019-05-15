#!/bin/bash
#SBATCH --time=03:00:00   # walltime in d-hh:mm or hh:mm:ss format
#SBATCH --mem-per-cpu=1000   # in MB
#SBATCH --nodes=4
#SBATCH --cpus-per-task=2
#SBATCH --output=parallel3.out
./parallel3 -nl 4 --rows=650 --cols=650 --niter=9000 --tolerance=0.002

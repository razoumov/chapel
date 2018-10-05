#!/bin/bash
#SBATCH --ntasks=2   # number of MPI tasks
#SBATCH --cpus-per-task=2   # number of cores per task
#SBATCH --time=00:10:00   # maximum walltime
srun -N2 ./hello -nl 2

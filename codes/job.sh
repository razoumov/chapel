#!/bin/bash
#SBATCH --ntasks=4   # number of MPI tasks
#SBATCH --cpus-per-task=6   # number of cores per task
#SBATCH --time=00:10:00   # maximum walltime
#SBATCH --account=def-razoumov-ac
srun ./hello -nl 4

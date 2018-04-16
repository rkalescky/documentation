#!/bin/bash
#SBATCH -J matlab            # job name
#SBATCH -o matlab_%a-%A.out  # output file name
#SBATCH --array=1-46         # array range
#SBATCH -p htc               # queue
#SBATCH --mem=7G             # memory requirement

module purge
module load matlab

args=`head -${SLURM_ARRAY_TASK_ID} numbers.txt | tail -1`
matlab -nojvm -nodisplay -nosplash -r "example(${args}),quit"


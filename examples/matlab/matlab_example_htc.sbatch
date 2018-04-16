#!/bin/bash
#SBATCH -J matlab.         # job name
#SBATCH -o matlab_%j.out   # output file name
#SBATCH -p htc             # queue
#SBATCH --mem=7G           # memory requirement

module purge
module load matlab

matlab -nojvm -nodisplay -nosplash -r <example_input_file.m>


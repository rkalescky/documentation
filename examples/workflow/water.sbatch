#!/bin/bash
#SBATCH -J water
#SBATCH -o water_%j.out
#SBATCH -p htc
#SBATCH -c 1
#SBATCH --mem=6G

module purge
module load psi4

#Files to copy to $SCRATCH for the job
start_files=("water.dat") 

#Files to copy from $SCRATCH after the job
end_files=("water.out" "water.fchk")

#Setup temporary job directory in $SCRATCH
job_directory="${SCRATCH}/${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir ${job_directory}
lfs setstripe -c 1 ${job_directory}

#Set application-specific scratch location
export PSI_SCRATCH=${job_directory}

#Copy files to the temporary job directory
cp -a ${start_files[@]} ${job_directory}/

#Change to the temporary job directory
cd ${job_directory}

#Run the calculation
psi4 water.dat

#Copy needed files back to directory from which the job was submitted
job_files_directory="${SLURM_SUBMIT_DIR}/${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir ${job_files_directory}
cp -a ${end_files[@]} ${job_files_directory}/

#Delete the temporary job directory
rm -rf ${job_directory}


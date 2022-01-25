#!/bin/bash
#$ -l mem_free=25G
#$ -l h_vmem=25G
#$ -l h_rt=360:00:00
#$ -cwd
#$ -j y
#$ -R y
#$ -t 1:121
module load conda_R
Rscript ndviadj.R $SGE_TASK_ID

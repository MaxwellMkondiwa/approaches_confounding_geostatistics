#!/bin/bash
#$ -l h_vmem=25G
#$ -l mem_free=25G
#$ -pe local 1
#$ -l h_rt=360:00:00
#$ -cwd
#$ -j y
#$ -R y
module load conda_R
Rscript unadj_full.R

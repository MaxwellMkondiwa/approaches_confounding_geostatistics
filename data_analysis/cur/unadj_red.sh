#!/bin/bash
#$ -l h_vmem=10G
#$ -l mem_free=10G
#$ -pe local 8
#$ -l h_rt=360:00:00
#$ -cwd
#$ -j y
#$ -R y
module load conda_R
Rscript unadj_red.R

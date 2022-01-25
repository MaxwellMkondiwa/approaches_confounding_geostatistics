#!/bin/bash
#$ -l mem_free=25G
#$ -l h_vmem=25G
#$ -l h_rt=360:00:00
#$ -cwd
#$ -j y
#$ -R y
module load conda_R
Rscript ndviadj_full.R

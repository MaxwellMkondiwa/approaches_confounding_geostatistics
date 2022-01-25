#!/bin/bash
#$ -l mem_free=40G
#$ -l h_vmem=40G
#$ -l h_rt=360:00:00
#$ -cwd
#$ -j y
#$ -R y
module load conda_R
Rscript analysis_spline.R

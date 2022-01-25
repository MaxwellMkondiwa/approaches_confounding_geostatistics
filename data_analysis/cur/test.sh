#!/bin/bash
#$ -l h_vmem=17.5G
#$ -l mem_free=17.5G
#$ -l h_rt=360:00:00
#$ -cwd
#$ -j y
#$ -R y
module load conda_R
Rscript test.R

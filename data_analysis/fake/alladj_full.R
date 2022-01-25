library(tidyverse)
library(boot)

source('bart_est.R')

dat = readRDS('dat_bart_norm.rds') 

dat.temp = readRDS('dat_bart.rds')
scale = sd(dat.temp$pm25)

est = bart_est(dat, shift=1/scale, ind=1:nrow(dat))
#est = boot(dat, bart_est, shift=-1, R=120, ncpus=8, parallel='multicore')

saveRDS(est, 'alladj_full_est.rds')

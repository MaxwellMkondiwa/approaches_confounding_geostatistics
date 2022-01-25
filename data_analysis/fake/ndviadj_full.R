library(tidyverse)
library(boot)

source('bart_est.R')

dat = readRDS('dat_bart_norm.rds') %>% select(-c(lat, lon))

dat.temp = readRDS('dat_bart.rds')
scale = sd(dat.temp$pm25)

est = bart_est(dat, shift=1/scale, ind=1:nrow(dat))
#est = boot(dat, bart_est, shift=-1, R=120, ncpus=8, parallel='multicore')

saveRDS(est, 'ndviadj_full_est.rds')

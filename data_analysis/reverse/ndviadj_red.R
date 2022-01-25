library(tidyverse)
library(boot)

source('bart_est.R')

dat = readRDS('dat_bart.rds') %>% select(-c(lat, lon)) %>% filter(pm25 > 22.5)

est = boot(dat, bart_est, shift=1, R=120, ncpus=5, parallel='multicore')

saveRDS(est, 'ndviadj_red_est.rds')

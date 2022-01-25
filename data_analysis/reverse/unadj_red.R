library(tidyverse)
library(boot)

source('bart_est.R')

dat = readRDS('dat_bart.rds') %>% select(-c(lat, lon, ndvi)) %>% filter(pm25 > 22.5)

est = boot(dat, bart_est, shift=1, ncpus = 5, R = 120, parallel='multicore')

saveRDS(est, 'unadj_red_est.rds')

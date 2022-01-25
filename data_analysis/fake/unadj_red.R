library(tidyverse)
library(boot)

source('bart_est.R')

dat.temp = readRDS('dat_bart.rds')
scale = sd(dat.temp$pm25)
loc = mean(dat.temp$pm25)

dat = readRDS('dat_bart_norm.rds') %>% select(-c(lat, lon, ndvi)) %>% filter(pm25 > (22.5-loc)/scale)

est = boot(dat, bart_est, shift=1/scale, ncpus = 5, R = 120, parallel='multicore')

saveRDS(est, 'unadj_red_est.rds')

library(tidyverse)
library(boot)

source('bart_est.R')

dat = readRDS('dat_bart.rds') %>% select(-c(ndvi)) %>% filter(pm25 > 22.5)

est = boot(dat, bart_est, shift= 1, R=120, parallel='multicore', ncpus = 5)

saveRDS(est, 'spatialadj_red_est.rds')

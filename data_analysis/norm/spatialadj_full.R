library(tidyverse)
library(boot)

source('bart_est.R')

dat = readRDS('dat_bart_norm.rds') %>% select(-c(ndvi)) 

dat.temp = readRDS('dat_bart.rds')
scale = sd(dat.temp$pm25)

est = bart_est(dat, shift=-1/scale, ind=1:nrow(dat))
saveRDS(est, 'spatialadj_full_est.rds')

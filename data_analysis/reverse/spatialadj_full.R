library(tidyverse)
library(boot)

source('bart_est.R')

dat = readRDS('dat_bart.rds') %>% select(-c(ndvi)) 
est =  bart_est(dat, shift= 1)

saveRDS(est, 'spatialadj_full_est.rds')

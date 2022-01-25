library(tidyverse)
library(boot)

source('bart_est.R')

dat = readRDS('dat_bart.rds') %>% select(-c(lat, lon, ndvi)) 

#est = bart_est(dat, ind = 1:nrow(dat), shift =-1)

est = bart_est(dat, shift=1)

saveRDS(est, 'unadj_full_est.rds')

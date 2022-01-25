library(tidyverse)
library(boot)

source('bart_est.R')

dat = readRDS('dat_bart.rds') %>% select(-c(lat, lon))

est =  bart_est(dat, shift=1)

saveRDS(est, 'ndviadj_full_est.rds')

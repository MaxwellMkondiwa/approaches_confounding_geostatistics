dat = readRDS('dat_bart_norm.rds')

dat$pm25 = dat$pm25+rnorm(nrow(dat))

saveRDS(dat, 'dat_bart_norm.rds')

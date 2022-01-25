library(mgcv)
library(dplyr)

dat =readRDS('dat_bart_norm.rds')
newdata = mutate(dat, pm25=pm25+.3)

mod1 = gam(bw~s(pm25)+s(lat,lon), data=dat)
mod2 = gam(bw~s(pm25,lat,lon), data=dat)

mean(predict(mod1, newdata)) - mean(dat$bw)
mean(predict(mod2, newdata)) - mean(dat$bw)

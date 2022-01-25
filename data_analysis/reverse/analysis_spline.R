library(mgcv)
library(dplyr)
library(magrittr)

shift = -1

dat = readRDS('out.rds')@data %>% dplyr::filter(natCA_DBirWt < 9999) %>% mutate(CA_MEduc = as.factor(CA_MEduc), 
  kotl_index = as.factor(kotl_index),  race_eth = as.factor(race_eth))

#unadj
mumod = gam(natCA_DBirWt ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
             CA_MEduc + parity + race_eth + s(pm25),   data = dat)
mu.fitted = predict(mumod, dat)
mu.fitted.shift = predict(mumod, data.frame(dat %>% mutate(pm25 = pm25 + shift)))

pimod = lm(pm25 ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
             CA_MEduc + parity + race_eth,   data = dat)
resid = pimod$resid
d_mod = density(resid)

dens_est = function(dat.temp) approx(d_mod$x, d_mod$y, 
                                     dat$pm25 - predict(pimod, dat.temp))$y

lambda = function(dat.temp) dens_est(dat.temp %>% mutate(pm25 = pm25-shift))/dens_est(dat.temp)

comp_model = lm(dat$natCA_DBirWt ~ lambda(dat) + offset(mu.fitted)+0)
gamma_hat = coef(comp_model)

est_unadj_full = mean(mu.fitted.shift + gamma_hat*lambda(dat %>% mutate(pm25 = pm25+shift)), na.rm=T)-mean(dat$natCA_DBirWt, na.rm=T)



#spatial adjust
mumod = gam(natCA_DBirWt ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
              CA_MEduc + parity + race_eth + s(pm25) + s(X.x, Y.y),   data = dat)
mu.fitted = predict(mumod, dat)
mu.fitted.shift = predict(mumod, data.frame(dat %>% mutate(pm25 = pm25 + shift)))

pimod = gam(pm25 ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
             CA_MEduc + parity + race_eth + s(X.x, Y.y),   data = dat)
resid = pimod$resid
d_mod = density(resid)

dens_est = function(dat.temp) approx(d_mod$x, d_mod$y, 
                                     dat$pm25 - predict(pimod, dat.temp))$y

lambda = function(dat.temp) dens_est(dat.temp %>% mutate(pm25 = pm25-shift))/dens_est(dat.temp)

comp_model = lm(dat$natCA_DBirWt ~ lambda(dat) + offset(mu.fitted)+0)
gamma_hat = coef(comp_model)

est_spatial_full = mean(mu.fitted.shift + gamma_hat*lambda(dat %>% mutate(pm25 = pm25+shift)), na.rm=T)-mean(dat$natCA_DBirWt, na.rm=T)


#confounder adjust
mumod = gam(natCA_DBirWt ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
              CA_MEduc + parity + race_eth + s(pm25) +NAIP_2020_NDVI._California,   data = dat)
mu.fitted = predict(mumod, dat)
mu.fitted.shift = predict(mumod, data.frame(dat %>% mutate(pm25 = pm25 + shift)))

pimod = gam(pm25 ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
              CA_MEduc + parity + race_eth + NAIP_2020_NDVI._California,   data = dat)
resid = pimod$resid
d_mod = density(resid)

dens_est = function(dat.temp) approx(d_mod$x, d_mod$y, 
                                     dat$pm25 - predict(pimod, dat.temp))$y

lambda = function(dat.temp) dens_est(dat.temp %>% mutate(pm25 = pm25-shift))/dens_est(dat.temp)

comp_model = lm(dat$natCA_DBirWt ~ lambda(dat) + offset(mu.fitted)+0)
gamma_hat = coef(comp_model)

est_greenspace_full = mean(mu.fitted.shift + gamma_hat*lambda(dat %>% mutate(pm25 = pm25+shift)), na.rm=T)-mean(dat$natCA_DBirWt, na.rm=T)



#above exposure threshold
dat.red = filter(dat, pm25 >22.5)

#unadj
mumod = gam(natCA_DBirWt ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
              CA_MEduc + parity + race_eth + s(pm25),   data = dat.red)
mu.fitted = predict(mumod, dat.red)
mu.fitted.shift = predict(mumod, data.frame(dat.red %>% mutate(pm25 = pm25 + shift)))

pimod = lm(pm25 ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
             CA_MEduc + parity + race_eth,   data = dat.red)
resid = pimod$resid
d_mod = density(resid)

dens_est = function(dat.red.temp) approx(d_mod$x, d_mod$y, 
                                         dat.red$pm25 - predict(pimod, dat.red.temp))$y

lambda = function(dat.red.temp) dens_est(dat.red.temp %>% mutate(pm25 = pm25-shift))/dens_est(dat.red.temp)

comp_model = lm(dat.red$natCA_DBirWt ~ lambda(dat.red) + offset(mu.fitted)+0)
gamma_hat = coef(comp_model)

est_unadj_red = mean(mu.fitted.shift + gamma_hat*lambda(dat.red %>% mutate(pm25 = pm25+shift)), na.rm=T)-mean(dat.red$natCA_DBirWt, na.rm=T)


#spatial adjust
mumod = gam(natCA_DBirWt ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
              CA_MEduc + parity + race_eth + s(pm25) + s(X.x, Y.y),   data = dat.red)
mu.fitted = predict(mumod, dat.red)
mu.fitted.shift = predict(mumod, data.frame(dat.red %>% mutate(pm25 = pm25 + shift)))

pimod = gam(pm25 ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
              CA_MEduc + parity + race_eth + s(X.x, Y.y),   data = dat.red)
resid = pimod$resid
d_mod = density(resid)

dens_est = function(dat.red.temp) approx(d_mod$x, d_mod$y, 
                                         dat.red$pm25 - predict(pimod, dat.red.temp))$y

lambda = function(dat.red.temp) dens_est(dat.red.temp %>% mutate(pm25 = pm25-shift))/dens_est(dat.red.temp)

comp_model = lm(dat.red$natCA_DBirWt ~ lambda(dat.red) + offset(mu.fitted)+0)
gamma_hat = coef(comp_model)

est_spatial_red = mean(mu.fitted.shift + gamma_hat*lambda(dat.red %>% mutate(pm25 = pm25+shift)), na.rm=T)-mean(dat.red$natCA_DBirWt, na.rm=T)


#confounder adjust
mumod = gam(natCA_DBirWt ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
              CA_MEduc + parity + race_eth + s(pm25) +NAIP_2020_NDVI._California,   data = dat.red)
mu.fitted = predict(mumod, dat.red)
mu.fitted.shift = predict(mumod, data.frame(dat.red %>% mutate(pm25 = pm25 + shift)))

pimod = gam(pm25 ~ natCA_DMAge + natCA_DMAge^2 + natCA_CSex + kotl_index +
              CA_MEduc + parity + race_eth + NAIP_2020_NDVI._California,   data = dat.red)
resid = pimod$resid
d_mod = density(resid)

dens_est = function(dat.red.temp) approx(d_mod$x, d_mod$y, 
                                         dat.red$pm25 - predict(pimod, dat.red.temp))$y

lambda = function(dat.red.temp) dens_est(dat.red.temp %>% mutate(pm25 = pm25-shift))/dens_est(dat.red.temp)

comp_model = lm(dat.red$natCA_DBirWt ~ lambda(dat.red) + offset(mu.fitted)+0)
gamma_hat = coef(comp_model)

est_greenspace_red = mean(mu.fitted.shift + gamma_hat*lambda(dat.red %>% mutate(pm25 = pm25+shift)), na.rm=T)-mean(dat.red$natCA_DBirWt, na.rm=T)


save.image('ests_spline.Rdata')

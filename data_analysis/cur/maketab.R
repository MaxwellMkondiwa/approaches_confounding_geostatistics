library(xtable)
options(digits=3)
tab = data.frame(Model = c('UF', 'UT', 'NF', 'NT', 'SF', 'ST', 'AF', 'AT'), Estimate = rep(NA, 8))

est = list()

est$UF = readRDS('unadj_full_est.rds')
est$UT = readRDS('unadj_red_est.rds')
est$NF = readRDS('ndviadj_full_est.rds')
est$NT = readRDS('ndviadj_red_est.rds')
est$SF = readRDS('spatialadj_full_est.rds')
est$ST = readRDS('spatialadj_red_est.rds')
est$AF = readRDS('alladj_full_est.rds')
est$AT = readRDS('alladj_red_est.rds')

for(mod in c('UF', 'UT', 'NF', 'NT', 'SF', 'ST', 'AF', 'AT')){
	
	i = which(tab$Model == mod)


	if(grepl('T', mod)){
	res = est[mod][[1]]
	point = res$t0
	se = sd(res$t)
	

	tab[i, 2] = paste0(formatC(point,1, format='f'), ' (', formatC(point - 1.96*se, 1, format='f'), ', ', formatC(point + 1.96*se, 1, format='f'), ')')}
	else{
   tab[i,2] = formatC(est[mod][[1]], 1, format='f')
 }
	
	  out = xtable(tab, digits=3)

     print(out, file = 'tab.txt', include.rownames=F)

}


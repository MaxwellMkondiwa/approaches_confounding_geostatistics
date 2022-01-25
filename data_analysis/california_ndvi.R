library(RColorBrewer)
library(magrittr)
library(rgdal)
library(gtools)

ndvi = read.csv('NDVI_Block_CA_2013.csv')
ndvi$GEOID10 = paste0('0', ndvi$blockid10)

shape = readOGR('tl_2017_06_tabblock10.shp')

dat= merge(ndvi, shape@data, by='GEOID10')
dat$ndvi_q = quantcut(dat$NDVI, q=5)

ord = match(shape@data$GEOID10, dat$GEOID10)

shape@data = dat[ord,]

rgPal = colorRampPalette(c('red','green'))

shape@data$color = rgPal(5)[shape@data$ndvi_q]

#low = levels(cut(shape@data$NDVI,breaks=20))[1] %>% toString()
#high = levels(cut(shape@data$NDVI,breaks=20))[20] %>% toString()

#print(table(shape@data$color))

jpeg(file="california_ndvi.jpeg")
plot(shape, col = shape@data$color, border=NA)
#legend('topright', legend=c(low, high), col = c('red','green'))
dev.off()

save.image('california_ndvi.Rdata')

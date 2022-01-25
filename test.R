for(size in c('large', 'small')){
  if (size == 'large') jmax = 250 else jmax = 500
  
  for(method in c('bart_double', 'bart_single', 'gsem', 'RSR', 'rf', 'spatial_plus', 'spline3', 'spline_interaction', 'spline_double')){
  
    for(i in 1:6){
      for(j in 1:jmax){
        if(!file.exists(file.path(paste0(size, '_sample_parallel'), method, paste0('sim',i,'_', j, '.rds')))) print(c(size, method, i, j))
      }
    }
    i=7
    for(j in 1:jmax){
        if(!file.exists(file.path(paste0(size, '_sample_parallel'), method, paste0('sim',i,'_', j, '.rds'))) & !grepl('double', method) ) print(c(size, method, i, j))
      }
  
  }


}

for(size in c('large', 'small')){
  if (size == 'large') jmax = 250 else jmax = 500
  
 for(method in c('gp3', 'gp3_double', 'spline', 'svc_mle')){
  if (size == 'large' & method !='spline') next
    for(i in 1:6){
      for(j in 1:jmax){
        if(!file.exists(file.path(paste0(size, '_sample'), method, paste0('sim',i,'_', j, '.rds')))) print(c(size, method, i, j))
      }
    }
    i=7
    for(j in 1:jmax){
        if(!file.exists(file.path(paste0(size, '_sample'), method, paste0('sim',i,'_', j, '.rds'))) & !grepl('double', method) ) print(c(size, method, i, j))
      }
  
  }


}


for(size in c('large', 'small')){
  if (size == 'large') jmax = 250 else jmax = 500
  
  for(method in c('gp')){
  
    for(i in 1:6){
      for(j in 1:jmax){
        if(!file.exists(file.path(paste0(size, '_sample_gp'), method, paste0('sim',i,'_', j, '.rds')))) print(c(size, method, i, j))
      }
    }
    i=7
    for(j in 1:jmax){
        if(!file.exists(file.path(paste0(size, '_sample_gp'), method, paste0('sim',i,'_', j, '.rds'))) & !grepl('double', method) ) print(c(size, method, i, j))
      }
  
  }


}

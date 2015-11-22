library(DBI)
library(RPostgreSQL)
library(iterpc)

source("AddFeatures.R")

bestmodels <- readRDS("BestModels.rds")

modelresults <- list()

for(analysis.id in 1:12){
  pars <- ParamsFromID(analysis.id)
  
  test <- data.frame(getall(iterpc(pars$possibleRange,pars$number.drawn)))
  
  cn <- vector(mode = "character", length = pars$number.drawn)
  for(i in 1:pars$number.drawn){
    cn[i] <- paste('n',as.character(i),sep = '')
  }
  
  colnames(test) <- cn
  
  test <- AddFeatures(test,pars$possibleRange)
  
  modelfit <- bestmodels[[analysis.id]]
  modelresults[[analysis.id]] <-  predict(modelfit,test)
  print(analysis.id)
}

saveRDS(modelresults,"ModelResults.rds")






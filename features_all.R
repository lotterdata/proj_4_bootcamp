library(DBI)
library(RPostgreSQL)
library(iterpc)

analysis.id <- 3

pars <- ParamsFromID(analysis.id)

test <- data.frame(getall(iterpc(pars$possibleRange,pars$number.drawn)))

cn <- vector(mode = "character", length = pars$number.drawn)
for(i in 1:pars$number.drawn){
  cn[i] <- paste('n',as.character(i),sep = '')
}

colnames(test) <- cn

for(i in 1:pars$possibleRange){
  ft = paste('f', as.character(i), sep = '')
  test[[ft]] = apply(test[,1:pars$number.drawn],1,function(x) SetFlag(x,i))
}

test$gap.sd <- apply(test[,1:pars$number.drawn],1,gap.sd)
test$drawsum <- apply(test[,1:pars$number.drawn],1,sum)
test$range <- test[,pars$number.drawn] - test[,1]

modelfit <- readRDS("BestModels.rds")[[analysis.id]]
test2 <- predict(modelfit,test)
test$expected <- rep(0,nrow(test))

getMatchEst <- function(x){
  return(test2[LexPos(x,43,5)])
}

GetAvgPrize <- function(x){
  gm <- GenerateMatches(x,43,3)
  return(mean(apply(gm,1,getMatchEst)))
}




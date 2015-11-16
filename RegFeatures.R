library(DBI)
library(RPostgreSQL)
library(dplyr)

RegFeatures <- function(game, possibleRange){

  gap.sd <- function(x){
    temp <- x[2:length(x)] - x[1:length(x)-1] 
    return(sd(temp))
  }
  
  SetFlag <- function(x,n){
    return(as.numeric(any(x == n)))
  }  
  
  drv <- dbDriver("PostgreSQL")
  con <- dbConnect(drv, host = 'localhost', dbname = 'lotterydata')
  sql.text <- paste("select * from", game)
  res <- dbSendQuery(con,sql.text)
  temp <- fetch(res,-1)
  dbClearResult(res)
  dbDisconnect(con)
  
  features <- select(temp,matches('^n.|drawdate'))
  ncol.orig <- ncol(features)
  for(i in 1:(possibleRange)){
    ft = paste('f', as.character(i), sep = '')
    features[[ft]] = apply(features[,2:ncol.orig],1,function(x) SetFlag(x,i))
  }
  features$gap.sd <- apply(features[,2:ncol.orig],1,gap.sd)
  features$drawsum <- apply(features[,2:ncol.orig],1,sum)
  features$range <- features[,ncol.orig ] - features[,2]

  return(features)
}
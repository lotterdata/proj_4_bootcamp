library(DBI)
library(RPostgreSQL)
library(dplyr)

gap.sd <- function(x){
  temp <- x[2:length(x)] - x[1:length(x)-1] 
  return(sd(temp))
}

SetFlag <- function(x,n){
  temp <- FALSE
  for(i in 1:length(x)){
    temp <- temp | (x[[i]] == n)
  }
  as.numeric(temp)
}

RegFeatures <- function(table){
  drv <- dbDriver("PostgreSQL")
  con <- dbConnect(drv, host = 'localhost', dbname = 'lotterydata')
  sql.text <- paste("select * from", table)
  res = dbSendQuery(con,sql.text)
  temp <- fetch(res,-1)
  dbClearResult(res)
  sql.text <- paste("select matrix1_size from game_info where game_table_name = \'", table,"\'", sep = '')
  res = dbSendQuery(con,sql.text)
  possibleRange <- fetch(res,1)[[1]]
  dbClearResult(res)
  dbDisconnect(con)
  features <- select(temp,matches('^n.|drawdate'))
  number.drawn <- ncol(features) - 1
  for(i in 1:(possibleRange-1)){
    ft = paste('f',as.character(i), sep = '')
    features[[ft]] = apply(features[,2:(number.drawn+1)],1,function(x) SetFlag(x,i))
  }
  features$gap.sd <- apply(features[,2:(number.drawn+1)],1,gap.sd)
  features$drawsum <- apply(features[,2:(number.drawn+1)],1,sum)
  features$range <- features[,(number.drawn+1)] - features[,2]

  return(features)
}
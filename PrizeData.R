library(DBI)
library(RPostgreSQL)
library(dplyr)

PrizeData <- function(game){
  drv <- dbDriver("PostgreSQL")
  con <- dbConnect(drv, host = 'localhost', dbname = 'lotterydata')
  sql.text <- paste("select min_date from game_info where game_table_name = \'", game,"\'",sep='')
  res <- dbSendQuery(con,sql.text)
  min.date <- as.character(fetch(res,1)[[1]])
  dbClearResult(res)
  sql.text <- paste("select * from ", game," where drawdate >= \'",min.date,"\'",sep='')
  res = dbSendQuery(con,sql.text)
  temp <- fetch(res,-1)
  dbClearResult(res)
  dbDisconnect(con)
  prizes <- select(temp,matches('^w.|^p.|drawdate'))
  return(prizes)
}
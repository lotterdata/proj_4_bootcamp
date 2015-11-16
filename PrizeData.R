library(DBI)
library(RPostgreSQL)
library(dplyr)

PrizeData <- function(game, min.date, max.date, prize, restriction){
  drv <- dbDriver("PostgreSQL")
  con <- dbConnect(drv, host = 'localhost', dbname = 'lotterydata')
  select.text = paste("select drawdate, ", prize," from ", game, sep='')
  where.text = paste(" where drawdate >= \'",min.date, 
                     "\' and drawdate <= \'", max.date,
                     "\' and ",restriction, sep='')
  sql.text = paste(select.text, where.text)
  res = dbSendQuery(con,sql.text)
  prizes <- fetch(res,-1)
  dbClearResult(res)
  dbDisconnect(con)
  return(prizes)
}
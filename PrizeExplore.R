library(DBI)
library(RPostgreSQL)
library(dplyr)


ExplorePrizes <- function(game,prize){
  drv <- dbDriver("PostgreSQL")
  con <- dbConnect(drv, host = 'localhost', dbname = 'lotterydata')
  sql.text <- paste("select date_part('year',drawdate)+date_part('month',drawdate)/12.0 as month, avg(",prize,") from",game,
                    "group by date_part('year',drawdate)+date_part('month',drawdate)/12.0",
                    "order by date_part('year',drawdate)+date_part('month',drawdate)/12.0")
  res <- dbSendQuery(con,sql.text)
  prize.data <- fetch(res,-1)
  dbDisconnect(con)
  plot(prize.data$month,prize.data$avg,
       type = 'n',
       xlab = "Month",
       ylab = "Average Prize")
  lines(prize.data$month,prize.data$avg)
  return(prize.data)
}
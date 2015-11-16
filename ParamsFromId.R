library(DBI)
library(RPostgreSQL)

ParamsFromID <- function(id){
  drv <- dbDriver("PostgreSQL")
  con <- dbConnect(drv, host = 'localhost', dbname = 'lotterydata')
  
  sql.text <- paste("select * from game_analyses where id = ", as.character(id))
  res <- dbSendQuery(con,sql.text)
  temp <- fetch(res,1)
  dbClearResult(res)
  
  sql.text <- paste("select min_date, 
                    matrix1_size,
                    number_drawn,
                    prize_granularity from game_info where game_table_name = \'", 
                    temp$game,"\'", sep = '')
  res = dbSendQuery(con,sql.text)
  temp2 <- fetch(res,1)
  temp$min.date <- as.character(temp2[[1]]) 
  temp$possibleRange <- temp2[[2]]
  temp$number.drawn <- temp2[[3]]
  temp$granularity <- temp2[[4]]
  dbClearResult(res)
  
  dbDisconnect(con)
  return(temp)
}
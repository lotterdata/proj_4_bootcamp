library(DBI)
library(RPostgreSQL)

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host = 'localhost', dbname = 'lotterydata')

best <- list()

for(i in 1:12){
  sql.text <- paste('select results_file from models where id = 
                    (select model_id from best_per_analysis where analysis_id = ',
                    as.character(i),
                    ')',
                    sep='')
  res <- dbSendQuery(con,sql.text)
  test <- fetch(res,1)
  dbClearResult(res)
  filename = test[[1]]
  temp <- readRDS(filename)
  best[[i]] <- temp[[i]]
}

dbDisconnect(con)

saveRDS(best,"BestModels.rds")
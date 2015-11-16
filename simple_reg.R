library(DBI)
library(RPostgreSQL)
library(dplyr)
library(caret)

source("GetDataFromId.R")

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host = 'localhost', dbname = 'lotterydata')

for(i in 1:12){
  temp <- GetDataFromID(i, "2015-07-31")
  pars <- temp$pars
  model.data <- temp$model.data
  rm(temp) 
  
  set.seed(0)
  intrain <- createDataPartition(y = model.data[[pars$prize]],
                                 p = 0.75,
                                 list = FALSE)
  training <- model.data[intrain,]
  testing <- model.data[-intrain,]
  modelfit <- train(training[[pars$prize]] ~ drawsum + range + gap.sd, 
                    data = training, method = "lm")
  predictions <- predict(modelfit, newdata = testing)
  predictions <- pars$granularity*round(predictions/pars$granularity)
  rmse <- mean((testing[[pars$prize]] - predictions)^2)^0.5
  sql.text <- paste("insert into model_results values(",
                    as.character(i), ", ",
                    "'Simple Regression', ",
                    as.character(rmse), ")",
                    sep = '')
  dbSendQuery(con,sql.text)
}

dbDisconnect(con)


library(DBI)
library(RPostgreSQL)
library(dplyr)
library(caret)

source("GetDataFromId.R")

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host = 'localhost', dbname = 'lotterydata')

model_id <- 1
sql.text <- paste("select * from models where id = ", as.character(model_id), sep = '')
res <- dbSendQuery(con,sql.text)
model.pars <- fetch(res,1)
dbClearResult(res)

results <- list()

for(i in 1:12){
  temp <- GetDataFromID(i, "2015-07-31")
  pars <- temp$pars
  model.data <- temp$model.data
  rm(temp)
  model.data <- model.data[,c(seq(2,pars$possibleRange+pars$number.drawn-1),
                              ncol(model.data)-3,
                              ncol(model.data))]
  
  set.seed(0)
  intrain <- createDataPartition(y = model.data[[pars$prize]],
                                 p = 0.75,
                                 list = FALSE)
  training <- model.data[intrain,]
  testing <- model.data[-intrain,]
  
  modelfit <- train(training[[pars$prize]] ~ ., 
                    data = training[,-ncol(training)], method = "glmnet",
                    trControl = trainControl(method = "cv", number = 5)
                    )
  results[[i]] <- modelfit
  
  predictions <- predict(modelfit,newdata = testing)
  predictions <- pars$granularity*round(predictions/pars$granularity)
  rmse <- mean((testing[[pars$prize]] - predictions)^2)^0.5
  print(i)
  print(modelfit$bestTune)
  print(rmse)
  sql.text <- paste("insert into model_results values(",
                    as.character(i), ", ",
                    as.character(model_id), ", ",
                    as.character(rmse), ")",
                    sep = '')
  dbSendQuery(con,sql.text)
}

dbDisconnect(con)

saveRDS(results,model.pars$results_file)
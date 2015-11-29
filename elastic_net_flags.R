library(DBI)
library(RPostgreSQL)
library(dplyr)
library(caret)

source("GetDataFromId.R")

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host = 'localhost', dbname = 'lotterydata')

###################################################################
# Enter model id here.                                            #
# This assumes the corresponding row in the 'models' table exists.#
###################################################################
model_id <- 11

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
  model.data <- model.data[,c(seq(pars$number.drawn+2,pars$possibleRange+pars$number.drawn),
                              ncol(model.data))]
  
  set.seed(0)
  intrain <- createDataPartition(y = model.data[[pars$prize]],
                                 p = 0.75,
                                 list = FALSE)
  training <- model.data[intrain,]
  testing <- model.data[-intrain,]
  
  ###############################################################
  # Edit the following line according to the model being tested #           
  ###############################################################
  
  alpha <- seq(0,1,0.05)
  lambda <- c(0.001,0.2,.001)
  elas.grid <- expand.grid(alpha = alpha, lambda = lambda)
  
  modelfit <- train(training[[pars$prize]] ~ ., 
                    data = training[,-ncol(training)], method = "glmnet",
                    trControl = trainControl(method = "cv", number = 5),
                    tuneGrid = elas.grid
  )
  
  results[[i]] <- modelfit
  
  predictions <- predict(modelfit, newdata = testing)
  predictions <- pars$granularity*round(predictions/pars$granularity)
  rmse <- mean((testing[[pars$prize]] - predictions)^2)^0.5
  print(rmse)
  sql.text <- paste("insert into model_results values(",
                    as.character(i), ", ",
                    as.character(model_id), ", ",
                    as.character(rmse), ")",
                    sep = '')
  #dbSendQuery(con,sql.text)
}

dbDisconnect(con)

#saveRDS(results,model.pars$results_file)


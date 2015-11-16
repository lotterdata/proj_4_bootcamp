
for(i in 2:2){
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
  
  alpha <- seq(0,1,by=0.25)
  lambda <- c(10^-2,10^-1,1,10,1e2,1e3,1e4)
  
  tuneGrid <- expand.grid(alpha = alpha,lambda = lambda)
  trControl <- trainControl(method = "cv", number = 5)
  modelfit <- train(training[[pars$prize]] ~ ., 
                    data = training[,-ncol(training)], method = "glmnet")
  
  predictions <- predict(modelfit,newdata = testing)
  predictions <- pars$granularity*round(predictions/pars$granularity)
  print(modelfit$bestTune$alpha)
  #print(mean((predictions - testing[[pars$prize]])^2)^0.5)
}


modelfit <- readRDS("BestModels.rds")[[2]]

test <- GetDataFromID(2,"2015-10-31","2015-08-01")
qwert <- test$model.data

predictions <- predict(modelfit, newdata = qwert)
library(DBI)
library(RPostgreSQL)
library(dplyr)

source("ParamsFromId.R")
source("RegFeatures.R")
source("PrizeData.R")

GetDataFromID <- function(id){
  pars <- ParamsFromID(id)
  features <- RegFeatures(pars$game,pars$possibleRange)
  prizes <- PrizeData(pars$game,pars$min.date,"2015-07-31",
                      pars$prize,pars$restriction)
  model.data <- inner_join(features,prizes,by="drawdate")
  temp <- list()
  temp$pars <- pars
  temp$model.data <- model.data
  return(temp)
}
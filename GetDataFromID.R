library(DBI)
library(RPostgreSQL)
library(dplyr)

source("ParamsFromId.R")
source("RegFeatures.R")
source("PrizeData.R")

GetDataFromID <- function(id,max.date,min.date = NULL){
  pars <- ParamsFromID(id)
  features <- RegFeatures(pars$game,pars$possibleRange)
  min.date = ifelse(is.null(min.date),pars$min.date,min.date)
  prizes <- PrizeData(pars$game,min.date,max.date,
                      pars$prize,pars$restriction)
  model.data <- inner_join(features,prizes,by="drawdate")
  temp <- list()
  temp$pars <- pars
  temp$model.data <- model.data
  return(temp)
}
source("LexPos.R")

GetEstimate <- function(x,results,N,k){
  return(results[LexPos(x,N,k)])
}
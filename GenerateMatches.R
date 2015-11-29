
library(iterpc)

GenerateMatches <- function(x,N,m){
  k <- length(x)
  neg.x <- seq(1:N)[-x]
  matching <- iterpc(k,m, labels=x)
  not.matching <- iterpc(N-k,k-m, labels=neg.x)
  matching <- getall(matching)
  not.matching <- getall(not.matching)
  answer <- matrix(nrow = nrow(matching)*nrow(not.matching), ncol = k)
  counter = 1
  for(i in 1:nrow(matching))
      for(j in 1:nrow(not.matching)){
        answer[counter,] <- sort(c(matching[i,],not.matching[j,]))
        counter <- counter + 1
      }
   return(answer) 
}
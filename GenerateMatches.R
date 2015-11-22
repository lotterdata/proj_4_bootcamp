library(itertools)
library(iterpc)
library(iterators)

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
#   answer <- data.frame(answer)
#   cn <- vector(mode = "character", length = k)
#   for(i in 1:k){
#     cn[i] <- paste('n',as.character(i),sep = '')
#   }
#   colnames(answer) <- cn
# 
#   for(i in 1:N){
#     ft = paste('f', as.character(i), sep = '')
#     answer[[ft]] = apply(answer[,1:k],1,function(x) SetFlag(x,i))
#   }
#   
#   answer$gap.sd <- apply(answer[,1:k],1,gap.sd)
#   answer$drawsum <- apply(answer[,1:k],1,sum)
#   answer$range <- answer[,k] - answer[,1]  
   return(answer) 
}
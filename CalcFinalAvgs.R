source("ParamsFromId.R")
library(iterpc)

coeffs <- readRDS("reg_flag_coefs.rds")

EvaluateSelectionCoef <- function(x,N,k,m,coef){
  answer <- coef[1]
  for(i in 1:(N-1))
    if(i %in% x)
      answer <- answer + (m/k)*coef[i+1]
    else 
      answer <- answer + ((k-m)/(N-k))*coef[i+1]
    return(answer)
}

for(id in 1:12){
  pars <- ParamsFromID(id)
  N <- pars$possibleRange
  k <- pars$number.drawn
  m <- as.integer(substr(pars$prize,nchar(pars$prize),nchar(pars$prize)))
  temp <- data.frame(getall(iterpc(N,k)))
  cn <- vector(mode = "character", length = pars$number.drawn)
  for(i in 1:pars$number.drawn){
    cn[i] <- paste('n',as.character(i),sep = '')
  }
  colnames(temp) <- cn
  
  temp$avgprize <- apply(temp,1,function(x) EvaluateSelectionCoef(x,N,k,m,coeffs[[id]]))
  
  filename <- paste("final_avg_",as.character(id),".rds",sep='')
  saveRDS(temp,filename)
  print(id)
}
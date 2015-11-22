gap.sd <- function(x){
  temp <- x[2:length(x)] - x[1:length(x)-1] 
  return(sd(temp))
}

SetFlag <- function(x,n){
  return(as.numeric(any(x == n)))
}

AddFeatures <- function(df,N){
  temp <- df
  nc <- ncol(temp)
  for(i in 1:N){
    ft = paste('f', as.character(i), sep = '')
    temp[[ft]] = apply(temp,1,function(x) SetFlag(x,i))
  }
  temp$gap.sd <- apply(temp,1,gap.sd)
  temp$drawsum <- apply(temp,1,sum)
  temp$range <- temp[,nc] - temp[,1]
  return(temp)
}
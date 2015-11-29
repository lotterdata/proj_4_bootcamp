LexPos <- function(S,n,k){
  curr_n <- n
  curr_k <- k
  answer <- 1
  elem <- 1
  index <- 1
  while(curr_k > 0){
    if(elem == S[index]){
      curr_k <- curr_k-1
      index = index + 1
    }
    else{
      answer <- answer + choose(curr_n-1,curr_k-1)
    }
    curr_n <- curr_n - 1
    elem <- elem + 1
  }
  return(answer)
}
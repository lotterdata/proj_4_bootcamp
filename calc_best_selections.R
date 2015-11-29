GetTopK <- function(df,colnum,k){
  return(df[sort.list(df[[colnum]])[1:k],])
}



fl.prize3 <- readRDS("final_avg_2.rds")
fl.prize4 <- readRDS("final_avg_1.rds")

nj.prize3 <- readRDS("final_avg_3.rds")
nj.prize4 <- readRDS("final_avg_4.rds")


pa.prize3 <- readRDS("final_avg_5.rds")
pa.prize4 <- readRDS("final_avg_6.rds")

nc.prize3 <- readRDS("final_avg_7.rds")
nc.prize4 <- readRDS("final_avg_8.rds")

tx.prize3 <- readRDS("final_avg_9.rds")
tx.prize4 <- readRDS("final_avg_11.rds")
tx.prize4roll <- readRDS("final_avg_10.rds")

or.prize4 <- readRDS("final_avg_12.rds")

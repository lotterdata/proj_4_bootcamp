temp <- readRDS("regression_flags.rds")

reg.flag.coeffs <- list()
for(i in 1:12){
  reg.flag.coeffs[[i]] <- temp[[i]]$finalModel$coefficients
}

saveRDS(reg.flag.coeffs,"reg_flag_coefs.rds")


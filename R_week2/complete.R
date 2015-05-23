complete <- function(directory, id = 1:332)
{
  df <- data.frame(id=id, nobs=id)
  j <- 0
  for (i in id)
  {
    csv <- read.csv(paste0(directory,"/",pad0(i),".csv"))
    cc <- complete.cases(csv)
    j <- j + 1
    df[j,2] = length(cc[cc == TRUE])
  }
  df
}

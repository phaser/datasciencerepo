source("complete.R")

# pad the number with zeroes to match the name of the file
pad0 <- function(i)
{
  if (i < 10)
  {
    paste0("00",i)
  } else 
    if (i < 100)
    {
      paste0("0",i)
    } else
    {
      paste0(i)
    }
}

corr <- function(directory, threshold = 0)
{
    cc <- complete(directory)
    cc <- cc[cc[,2] >= threshold,]
    rv <- vector(mode="numeric", length=length(cc[,1]))
    for (i in seq_along(cc[,1]))
    {
        csv <- read.csv(paste0(directory,"/",pad0(cc[i,1]),".csv"))
        gcsv <- complete.cases(csv)
        csv <- csv[gcsv,]
        rv[i] <- cor(csv[,2], csv[,3])
    }
    rv
}

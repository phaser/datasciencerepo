add2 <- function(x, y)
{
  x + y
}

x <- add2(3, 4)
print (x)

columnmean <- function(y, removeNA=TRUE)
{
    nc <- ncol(y)
    means <- numeric(nc)
    for (i in 1:nc)
    {
        means[i] <- mean(y[,i], rm.na = removeNA)
    }
    means
}
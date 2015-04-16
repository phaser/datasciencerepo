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

# get column number by name
get_column_number <- function(csv, pollutant)
{
  csv_columns <- names(csv)
  for (c in seq_along(csv_columns))
  {
    if (as.character(csv_columns[c]) == pollutant)
      return(c)
  }
}

pollutantmean <- function(directory, pollutant, id = 1:332)
{
  sm <- 0
  lnid <- 0
  for (i in id)
  {
    csv <- read.csv(paste0(directory,"/",pad0(i),".csv"))
    cn <- get_column_number(csv, pollutant)
    isna <- is.na(csv[,cn])
    lnid <- lnid + length(isna[isna == FALSE])
    sm <- sm + sum(csv[,cn], na.rm=TRUE)
  }
  sm / lnid
}

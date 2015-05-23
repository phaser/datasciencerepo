rankhospital <- function (state, disease, num = "best")
{
    outcome <- read.csv("outcome-of-care-measures.csv", colClasses="character")
    ## check if state valid
    st <- outcome[outcome[,7] == state,1]
    if (length(st) == 0)
    {
        stop("invalid state")
    }

    ## check if disease valid
    ds <- noquote(strsplit(disease, " "))
    ds <- unlist(noquote(lapply(ds, capwords)))
    ds <- paste0(ds, collapse=".")
    nms <- names(outcome)
    exp <- paste0("^Hospital.30.Day.Death.*", ds, ".*")
    match <- grep(exp, nms)
    if (length(match) == 0)
    {
        stop("invalid outcome")
    }

    idx <- match[1]
    outcome <- outcome[outcome[,7] == state,]
    outcome[,idx] <- as.numeric(outcome[,idx])
    outcome <- outcome[!is.na(outcome[,idx]),]
    outcome <- outcome[order(outcome[,2]),]

    if (class(num) == "character")
    {
        if (!(num == "best" || num == "worst"))
        {
            stop("num: invalid argument")
        }
        minimum <- if (num == "best")
        {
            min(outcome[,idx])
        } else
        {
            max(outcome[,idx])
        }
        outcome <- outcome[outcome[,idx] == minimum,]
        outcome[1,2]
    } else
    if (class(num) == "numeric")
    {
        if (num > length(outcome[,2]))
        {
            return(NA)
        }
        outcome <- outcome[order(outcome[,idx]),]
        outcome[num,2]
    } else
    {
        stop("num: invalid argument")
    }
}
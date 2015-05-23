source("rankhospital.R")

rankall <- function(disease, num = "best")
{
    outcome <- read.csv("outcome-of-care-measures.csv", colClasses="character")

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

    states <- unique(outcome[,7])
    states <- as.character(states)
    states <- states[order(states)]


    hospitals <- vector(length=length(states))
    for (i in seq_along(states))
    {
        ioutcome <- outcome[outcome[,7] == states[i],]
        ioutcome[,idx] <- as.numeric(ioutcome[,idx])
        ioutcome <- ioutcome[!is.na(ioutcome[,idx]),]
        ioutcome <- ioutcome[order(ioutcome[,2]),]

        if (class(num) == "character")
        {
            if (!(num == "best" || num == "worst"))
            {
                stop("num: invalid argument")
            }
            minimum <- if (num == "best")
            {
                min(ioutcome[,idx])
            } else
            {
                max(ioutcome[,idx])
            }
            ioutcome <- ioutcome[ioutcome[,idx] == minimum,]
            hospitals[i] <- ioutcome[1,2]
        } else
            if (class(num) == "numeric")
            {
                if (num > length(outcome[,2]))
                {
                    return(NA)
                }
                ioutcome <- ioutcome[order(ioutcome[,idx]),]
                hospitals[i] <- ioutcome[num,2]
            } else
            {
                stop("num: invalid argument")
            }
    }
    data.frame(hospital=hospitals, state=states)
}
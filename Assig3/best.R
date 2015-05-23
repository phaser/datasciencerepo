capwords <- function(s, strict = FALSE) {
    cap <- function(s) paste(toupper(substring(s, 1, 1)),
    {
        s <- substring(s, 2); if(strict) tolower(s) else s
    },
    sep = "", collapse = " " )
    sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))
}

best <- function(state, disease)
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

    minimum <- min(outcome[,idx], na.rm=TRUE)
    outcome <- outcome[!is.na(outcome[,idx]),]
    outcome <- outcome[outcome[,idx] == minimum,]
    min(outcome[,2])
}


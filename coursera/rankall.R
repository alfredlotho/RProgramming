rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  data[, 11] <- as.numeric(data[, 11])
  data[, 17] <- as.numeric(data[, 17])
  data[, 23] <- as.numeric(data[, 23])
  ## Check that state and outcome are valid
  if (nrow(data[grep(state, data[,7]),]) == 0)
    stop("invalid state")
  if(!outcome %in% c("heart attack", "heart failure", "pneumonia")) 
    stop("invalid outcome")
  ## For each state, find the hospital of the given rank
  if (outcome == "pneumonia")
    colName <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  else if (outcome == "heart attack")
    colName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  else
    colName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  orderedList <- sapply(split(data, data$State), function(x) {
    x$Hospital.Name[order(x[colName],x$Hospital.Name, na.last = NA)]
  })
  finalList <- lapply(orderedList,function(x) {
    hospitalCount <- length(x)
    if (is.numeric(num)) {
      if (num > 0 & num < hospitalCount) {
        x[num]  
      } else {
        NA  
      }
    } else {
      if (num == "best") {
        x[1]
      } else if (num == "worst") {
        x[hospitalCount]
      } else {
        stop("invalid num")
      }
    }
  })
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  data.frame(hospital = unlist(finalList), state = names(finalList))
}


## Return hospital name in that state with the given rank
## 30-day death rate



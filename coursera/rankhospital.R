rankhospital <- function(state, outcome, num = "best") {
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
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if (outcome == "pneumonia")
    colName <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  else if (outcome == "heart attack")
    colName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  else
    colName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  b <- subset(data, 
              data$State == state, 
              select = 
                c(Hospital.Name ,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, 
                  Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, 
                  Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
  orderedList <- b$Hospital.Name[order(b[,colName], b$Hospital.Name, na.last=NA)]
  hospitalCount <- length(orderedList)
  if (is.numeric(num)) {
    if (num > 0 & num < hospitalCount) {
      orderedList[num]  
    } else {
      NA  
    }
  } else {
    if (num == "best") {
      orderedList[1]
    } else if (num == "worst") {
      orderedList[hospitalCount]
    } else {
      stop("invalid num")
    }
  }
    
}

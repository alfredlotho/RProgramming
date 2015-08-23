complete <- function(directory, id = 1:332) {
  completelist <- data.frame()
  for(i in id) {
    fileName <- paste(directory, sprintf("%03d.csv",i),  sep = "/")
    data <- read.csv(fileName)
    completedata <- data[(!is.na(data$sulfate) & !is.na(data$nitrate)),]
    completelist <- rbind(completelist, data.frame(id=i, nobs=nrow(completedata)))
  }
  completelist
}
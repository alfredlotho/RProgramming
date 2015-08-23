corr <- function(directory, threshold = 0) {
  corrlist <- numeric(0)
  index <- 1
  filelist <- list.files(directory)
  for(i in 1:length(filelist)) {
    fileName <- paste(directory, filelist[i],  sep = "/")
    data <- read.csv(fileName)
    completedata <- data[(!is.na(data$sulfate) & !is.na(data$nitrate)),]
    if (nrow(completedata) > threshold) {
      corrlist[index] <- cor(completedata$sulfate, completedata$nitrate)
      index <- index + 1
    }
  }
  corrlist
}
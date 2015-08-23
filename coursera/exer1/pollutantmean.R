pollutantmean <- function(directory, pollutant, id = 1:332) {
  for(i in id) {
    fileName <- paste(directory, sprintf("%03d.csv",i),  sep = "/")
    if (exists("maindata")) {
      localdata <- read.csv(fileName, header = TRUE)
      maindata <- rbind(maindata, localdata)
      rm(localdata)
    } else {
      maindata <- read.csv(fileName, header = TRUE)
    }
  }
  mean(maindata[[pollutant]], na.rm = TRUE)
}
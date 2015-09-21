run_analysis <- function() {
  #load library
  library(dplyr)
  
  ## read all training and test sets then merge to one set
  features <- read.table("features.txt")
  xtest <- read.table("./test/X_test.txt", col.names = features[,2])
  ytest <- read.table("./test/y_test.txt", col.names = "Activity")
  stest <- read.table("./test/subject_test.txt", col.names = "Subject")
  test <- cbind(stest, ytest, xtest)
  xtrain <- read.table("./train/X_train.txt", col.names = features[,2])
  ytrain <- read.table("./train/y_train.txt", col.names = "Activity")
  strain <- read.table("./train/subject_train.txt", col.names = "Subject")
  train <- cbind(strain, ytrain, xtrain)
  union <- rbind(train, test)
  remove(features,xtest,ytest,stest,test,xtrain,ytrain,strain,train)
  
  ## get all mean and stdev columns
  filterCol <- grep("Subject|Activity|mean\\.\\.|std\\.\\.",names(union))
  union <- union[,filterCol]
  
  ## use descriptive names for activity
  actLabels <- read.table("activity_labels.txt", col.names=c("id","activityName"))
  union$Activity <- actLabels$activityName[match(union$Activity, actLabels$id)]
  remove(actLabels)
  
  ## independent data set that contains the average of each variable for each activity and subject
  result <- aggregate(select(union,-(Subject:Activity)),select(union,Activity,Subject), FUN = mean)
  remove(union)
  result
}
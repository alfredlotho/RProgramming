1. Load all necessary libraries
(In this project, the dplyr library was used for selecting specific rows from the data frame)
2. Read all the data sets (x, y and subject data sets for both training and testing samples)
3. Combine all the data sets into one big data sets
  * Combine all training data sets by lining up all their columns together (using cbind)
  * Combine all test data sets by lining up all their columns together (using cbind)
  * Combine the test and training data sets by adding all test measurements after training measurements (using rbind)
4. Get only the columns for Subject, Activity, Mean and Standard Deviation (those with mean() and std() in their column names)
    Note: columns like meanFreq() is not included because it is not a column for mean but a column for frequency
5. Get all labels from the activity.txt.
    Use it to replace the numeric values in the Activity column for the big data set obtained in Step 3.
6. Get the mean of all variables grouped by Subject and Activity

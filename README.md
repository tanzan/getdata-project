# getdata-project
Getting and Cleaning Data Course Project

This project provides an R script run_analisys.R which extracts a data set for the experiment http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The extracted data set contains merged data from both test and training data sets with the average of each variable for each activity and each subject. See [CodeBook](CodeBook.md) for detail description.

To run the script do the following in R console
```
  source("run_analisys.R")
  run_analisys() #This function returns the resulting data set	
```



library(dplyr)
library(tidyr)

run_analisys <- function(){
  
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url,"dataset.zip",method="curl")
  unzip("dataset.zip")
  
  datapath <- "UCI HAR Dataset"
  
  activity_labels <- read.table(file.path(datapath,"activity_labels.txt"))  
  names(activity_labels) <- c("activity_label","activity_name")
  
  features <- read.table(file.path(datapath,"features.txt"),stringsAsFactors=FALSE)  
  names(features) <- c("feature_id","feature_name")  
  
  read_data <- function(type){
    
    subjects <- read.table(file.path(datapath,type,paste0("subject_",type,".txt")))    
    names(subjects) <- "subject_id"
    
    labels <- read.table(file.path(datapath,type,paste0("y_",type,".txt")))    
    names(labels) <- "activity_label"
    
    data <- read.table(file.path(datapath,type,paste0("X_",type,".txt")))      
    
    mean_features <- filter(features,grepl("mean",feature_name))
    
    std_features <- filter(features,grepl("std",feature_name))
    
    subset <- select(data,c(mean_features$feature_id,std_features$feature_id))    
    names(subset) <- c(mean_features$feature_name,std_features$feature_name)
    
    subjects %>% bind_cols(labels) %>% merge(activity_labels) %>% 
    bind_cols(subset) %>% select(-activity_label) %>% arrange(subject_id)
  }
  
  read_data("test") %>% bind_rows(read_data("train")) %>% 
  gather(feature_name,feature_value,-activity_name,-subject_id) %>% 
  group_by(subject_id,activity_name,feature_name) %>% summarize(feature_mean=mean(feature_value))
  
}

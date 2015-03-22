##Reading libraries. You should have packages reshape2 and dplyr installed.
##Otherwise use install.packages("reshape2"), install.packages("dplyr") before
##running the script
library(reshape2)
library(dplyr)

##Unpacking zip-archive, reading training set and test set. You should have file 
##"course_proj_data.zip" in your working directory
unzip("course_proj_data.zip")
training_set <- read.table("UCI HAR Dataset/Train/X_train.txt")
test_set <- read.table("UCI HAR Dataset/Test/X_test.txt")

##1. Merging together training and test sets
whole_set <- rbind(training_set, test_set)

##2. Extracting measurements on the mean and standard deviation
    ##Reading features' names
features <- read.table("UCI HAR Dataset/features.txt")

    ##*filtering features to find only features with words "mean()" or "std()"
filtered_features <- filter(features, grepl("mean()|std()", features$V2))
    
    ##*subsetting from main data set just the columns with numbers of 
    ## features that we need
filt_feat_nums <- filtered_features[,1]
whole_set_subset <- whole_set[,filt_feat_nums]

##3. Naming activities in the data set ustig descriptive names
    ##*reading labels for activities and merging two files to one set
train_labels <- read.table("UCI HAR Dataset/Train/y_train.txt")
test_labels <- read.table("UCI HAR Dataset/Test/y_test.txt")
whole_labels <- rbind(train_labels,test_labels)

    ##*giving readable name for a column, replacing numbers of activity with 
    ## readable names
colnames(whole_labels) <- c("Activity")
whole_labels$Activity[whole_labels$Activity==1]<-"WALKING"
whole_labels$Activity[whole_labels$Activity==2]<-"WALKING_UPSTAIRS"
whole_labels$Activity[whole_labels$Activity==3]<-"WALKING_DOWNSTAIRS"
whole_labels$Activity[whole_labels$Activity==4]<-"SITTING"
whole_labels$Activity[whole_labels$Activity==5]<-"STANDING"
whole_labels$Activity[whole_labels$Activity==6]<-"LAYING"

##4. Labeling the data set with descriptive variable names
colnames(whole_set_subset) <- filtered_features[,2]

##adding column for activity description to main data_set
whole_set_full <- cbind(whole_set_subset, whole_labels)

##reading data for subjects and adding this data as a column to main data set
subject_test <- read.table("UCI HAR Dataset/Test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/Train/subject_train.txt")
all_subjects <- rbind(subject_train, subject_test)
colnames(all_subjects) <- "Subject"
whole_set_finished <- cbind(all_subjects, whole_set_full)

##5. Creating second data set with average of each variable for each activity
##and each subject

names_of_variables <- as.character(filtered_features[,2])
melt_set <- melt(whole_set_finished, id = c("Subject", "Activity"), measure.vars=names_of_variables)
new_set <- melt_set %>% group_by(Subject, Activity) %>% mutate(Average.meaning=mean(value))
new_set <- new_set[,c(1,2,3,5)]
final_data <- unique(new_set)



##Writing out tidy data to a file "tidy_data.txt" in your working directory
write.table(final_data, "tidy_data.txt", row.names = FALSE)
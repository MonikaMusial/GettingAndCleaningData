library(reshape2)
library(plyr)


run_analysis <- function() {
  
#  reading test and training files
#
dir<-getwd()
subjectTest <- read.table(paste(dir,"/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",sep=""), header = FALSE)
labelsTest <- read.table(paste(dir,"/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",sep=""), header = FALSE)
testSet <- read.table(paste(dir,"/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",sep=""), header = FALSE)

subjectTrain <- read.table(paste(dir,"/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt",sep=""), header = FALSE)
labelsTrain <- read.table(paste(dir,"/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/y_train.txt",sep=""), header = FALSE)
trainSet <- read.table(paste(dir,"/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",sep=""), header = FALSE)

features<-read.table(paste(dir,"/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/features.txt",sep=""), header = FALSE)
activityLabels<-read.table(paste(dir,"/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/activity_labels.txt",sep=""), header = FALSE)

#  merging train and test files
#
set<-rbind(trainSet,testSet)
labelsSet<-rbind(labelsTrain,labelsTest)
subjectSet<-rbind(subjectTrain,subjectTest)

# adding descriptive activity names to name the activities in the data set
#
labelsSet$id  <- 1:nrow(labelsSet)
act<-merge(activityLabels,labelsSet, by.x = "V1",by.y = "V1")
act<-act[order(act$id), ]
colnames(set)<-features$V2
finalSet<-plyr::mutate(set,Activity=act$V2)

# Extracts only the measurements on the mean and standard deviation for each measurement
#
indexes<-grep("std|mean|Mean",features$V2)
indexes<-c(indexes,ncol(finalSet))
# Tidy data set
finalSet<-finalSet[,indexes]

# Creating tidy data set with the average of each variable for each activity and each subject
#
columns<-colnames(finalSet[,1:(ncol(finalSet)-1)])
finalSet[] <- lapply(finalSet[], as.numeric)
summarisedSet<-plyr::mutate(finalSet,Subject=subjectSet$V1)
summarisedSet<-ddply(summarisedSet, c("Activity","Subject"), function(x) colMeans(x[columns]))
# Tidy data set with the average of each variable for each activity and each subject
summarisedSet
write.table(summarisedSet,file= "SummaryData.txt", row.name=FALSE)

}


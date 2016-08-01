---
title: "Getting and Cleaning Data project, Monika Musial"
output: github_document
---

This is a code book that describes the variables, the data, and any transformations or work that I performed in script 'run_analysis.R'.The purpose of this script is to clean the data that represents data collected from the accelerometers from the Samsung Galaxy S smartphone. The data was downloaded from the following location: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In this work following packages were used: reshape2 and plyr. Whole work was done in following steps:

1. First thing was to read both test and training files containing following data: 

  - Main data set with all the measurements for the experiments. (X_train.txt and X_test.txt).
  - Data set where each row identifies the type of activity that was performed by the subject (y_train.txt and y_test.txt). Its range is from 1 to 6. 
  - Data set where each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. (subject_test.txt and subject_train.txt) 

2. Then I read files:

  - 'features.txt': A 561-feature vector with time and frequency domain variables.
  
  - 'activity_labels.txt': Links the class labels with their activity names.

3. In the next step I have merged the training and the test sets to create one data set for each category: I called them:
  - 'set', this is the main data set with all the measurements for the experiments. 
  - labelsSet with that identifies a type of activity
  - subjectSet that identifies the subject who carried out the experiment

4. Next, I added the new variable called 'Activity' to the data set called 'set' in order to add the descriptive activity names (from file activity_labels) for each row. To do so I first added id column to the labels data set than I merged the two data sets: labelsSet and activityLabels by activity id, and then I reordered the final data set by the id column to receive the order that I had at the beginning. In 'Activity' column I saved the data with activity names from this final data set.

5. The next step was to appropriately label the main data set called 'set' with descriptive variable names that I took from features file.

6. Then I used grep function to find indexes of features (taken from features file) that contain either 'std','mean' or 'Mean' to extract only the measurements on the mean and standard deviation for each measurement. These indexes helped me select the proper columns in my main data set.

7. Finally I created independent tidy data set called 'summarisedSet' with the average of each variable for each activity and each subject. To do so, first I added new variable called Subject to the main data set to include the data that identifies the subject who carried out the experiment.Then I used funtion 'ddply' to group summarisedSet by Activity and Subject variables and calculate for each group means of the remaining variables.I saved the result data set in 'SummaryData.csv' file.






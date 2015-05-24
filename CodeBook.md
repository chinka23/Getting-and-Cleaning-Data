# Introduction
* Download the given URL file, unzip it
  The site where the data was obtained:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  The data for the project:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Explaining the Script
The script `run_analysis.R`basically performs the 5 steps described in the course project's definition
* Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in ActivityTrainData, FeaturesTrainData and SubjectTrainData variables respectively.
* Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in ActivityTestData, FeaturesTestData and SubjectTestData variables respectively.

## Section 1. Merge the training and the test sets to create one data set.
* Files having the no. of columns same and referring to the same entities is merged using the `rbind()` function as seen below.
* Merge the data table by rows respectively.
* Give names to Variables declared
* Merge columns to get the data frame DATA for all data

## Section 2. Extract only the measurements on the mean and standard deviation for each measurement.
* Subset Name of Features by measurements with “mean()” or “std()”
* Subset the data frame DATA by seleted names of Features
* To view the data structuire of files in DATA , use str(DATA)

## Section 3. Use descriptive activity names to name the activities in the data set
* Read descriptive activity names from “activity_labels.txt”
* Update values with correct activity names
* Correct column name

## Section 4. Appropriately label the data set with descriptive activity names.
* Appropriately label the data set with descriptive variable names
* Use gsub function for pattern replacement to clean up the data labels.

## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
* Creates a second,independent tidy data set and ouput it
* We need to produce only a data set with the average of each veriable for each activity and subject

# Variables

* `ActivityTrainData', 'FeaturesTrainData', 'SubjectTrainData',  and 'ActivityTestData', 'FeaturesTestData' and 'SubjectTestData'` contain the data from the downloaded files.
* `SubjectData`, `ActivityData` and `FeaturesData` merge the previous datasets to further analysis.
* `FeaturesNames` contains the correct names for the `FeaturesData` dataset, which are applied to the column names stored in `Mean_SD_Features`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.
* `DATA` merges `SubjectData`, `ActivityData` and `FeaturesData` in a big dataset.
* Finally, `TidyData` contains the relevant averages which will be later stored in a `.txt` file.

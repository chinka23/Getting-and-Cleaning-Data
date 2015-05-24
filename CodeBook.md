# Introduction
The script `run_analysis.R`performs the 5 steps described in the course project's definition.
* First, all the similar data is merged using the `rbind()` function. 
* By similar, we address those files having the same number of columns and referring to the same entities.

## Section 1. Merge the training and the test sets to create one data set.

After setting the source directory for the files, read into tables the data located in

features.txt
activity_labels.txt
subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt
Assign column names and merge to create one data set.

* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from `features.txt`.
## Section 2. Extract only the measurements on the mean and standard deviation for each measurement.
Create a logcal vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others. Subset this data to keep only the necessary columns.

* As activity data is addressed with values 1:6, we take the activity names and IDs from `activity_labels.txt` and they are substituted in the dataset.
## Section 3. Use descriptive activity names to name the activities in the data set
Merge data subset with the activityType table to inlude the descriptive activity names

* On the whole dataset, those columns with vague column names are corrected.
## Section 4. Appropriately label the data set with descriptive activity names.
Use gsub function for pattern replacement to clean up the data labels.

* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called `meandata.txt`, and uploaded to this repository.
## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
We need to produce only a data set with the average of each veriable for each activity and subject

# Variables

* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
* `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
* `features` contains the correct names for the `x_data` dataset, which are applied to the column names stored in `mean_and_std_features`, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the `activities` variable.
* `all_data` merges `x_data`, `y_data` and `subject_data` in a big dataset.
* Finally, `averages_data` contains the relevant averages which will be later stored in a `.txt` file. `ddply()` from the plyr package is used to apply `colMeans()` and ease the development.

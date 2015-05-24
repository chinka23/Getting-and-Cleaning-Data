## Download the given URL file, unzip it

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="auto")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
rootfilepath <- file.path("./data" , "UCI HAR Dataset")
filescontent<-list.files(rootfilepath, recursive=TRUE)
filescontent

##  [1] "activity_labels.txt"                         
##  [2] "features_info.txt"                           
##  [3] "features.txt"                                
##  [4] "README.txt"                                  
##  [5] "test/Inertial Signals/body_acc_x_test.txt"   
##  [6] "test/Inertial Signals/body_acc_y_test.txt"   
##  [7] "test/Inertial Signals/body_acc_z_test.txt"   
##  [8] "test/Inertial Signals/body_gyro_x_test.txt"  
##  [9] "test/Inertial Signals/body_gyro_y_test.txt"  
## [10] "test/Inertial Signals/body_gyro_z_test.txt"  
## [11] "test/Inertial Signals/total_acc_x_test.txt"  
## [12] "test/Inertial Signals/total_acc_y_test.txt"  
## [13] "test/Inertial Signals/total_acc_z_test.txt"  
## [14] "test/subject_test.txt"                       
## [15] "test/X_test.txt"                             
## [16] "test/y_test.txt"                             
## [17] "train/Inertial Signals/body_acc_x_train.txt" 
## [18] "train/Inertial Signals/body_acc_y_train.txt" 
## [19] "train/Inertial Signals/body_acc_z_train.txt" 
## [20] "train/Inertial Signals/body_gyro_x_train.txt"
## [21] "train/Inertial Signals/body_gyro_y_train.txt"
## [22] "train/Inertial Signals/body_gyro_z_train.txt"
## [23] "train/Inertial Signals/total_acc_x_train.txt"
## [24] "train/Inertial Signals/total_acc_y_train.txt"
## [25] "train/Inertial Signals/total_acc_z_train.txt"
## [26] "train/subject_train.txt"                     
## [27] "train/X_train.txt"                           
## [28] "train/y_train.txt"


## After unzip and storing the Data into a variable, we read the data from file into another variables.
## Reading the Fearures files
FeaturesTestData  <- read.table(file.path(rootfilepath, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrainData <- read.table(file.path(rootfilepath, "train", "X_train.txt"),header = FALSE)

## Reading the Activity files
ActivityTestData  <- read.table(file.path(rootfilepath, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrainData <- read.table(file.path(rootfilepath, "train", "Y_train.txt"),header = FALSE)

## Read the Subject files
SubjectTrainData <- read.table(file.path(rootfilepath, "train", "subject_train.txt"),header = FALSE)
SubjectTestData  <- read.table(file.path(rootfilepath, "test" , "subject_test.txt"),header = FALSE)

## If you want to view the properties inside respective variable use str(variable name) command.


############################################################################################################
## STEP 1
## Merges the training and the test sets to create one data set
  ## 1. Merge the data table by rows respectively.
SubjectData <- rbind(SubjectTrainData, SubjectTestData)
ActivityData<- rbind(ActivityTrainData, ActivityTestData)
FeaturesData<- rbind(FeaturesTrainData, FeaturesTestData)
  ## 2. Give names to Variables declared
names(SubjectData)<-c("subject")
names(ActivityData)<- c("activity")
FeaturesNames <- read.table(file.path(rootfilepath, "features.txt"),head=FALSE)
names(FeaturesData)<- FeaturesNames$V2
## 3.Merge columns to get the data frame Data for all data
Merge <- cbind(SubjectData, ActivityData)
DATA <- cbind(FeaturesData, Merge)

############################################################################################################
## STEP 2
## Extracts only the measurements on the mean and standard deviation for each measurement
  ## 1.Subset Name of Features by measurements with “mean()” or “std()”
Mean_SD_Features<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
  ## 2.Subset the data frame Data by seleted names of Features
NamesSelected<-c(as.character(Mean_SD_Features), "subject", "activity")
DATA<-subset(DATA,select=NamesSelected)
## 3. To view the data structuire of files in DATA , use str(DATA)

############################################################################################################
## STEP 3
## Uses descriptive activity names to name the activities in the data set
  ## 1. Read descriptive activity names from “activity_labels.txt”
LabelsActivities <- read.table(file.path(rootfilepath, "activity_labels.txt"),header = FALSE)
  ## 2. Update values with correct activity names
ActivityData[, 1] <- LabelsActivities[ActivityData[, 1], 2]
  ## 3. Correct column name
names(ActivityData) <- "activity"

############################################################################################################
## Step 4
## Appropriately label the data set with descriptive variable names
names(DATA)<-gsub("^t", "time", names(DATA))
names(DATA)<-gsub("^f", "frequency", names(DATA))
names(DATA)<-gsub("Acc", "Accelerometer", names(DATA))
names(DATA)<-gsub("Gyro", "Gyroscope", names(DATA))
names(DATA)<-gsub("Mag", "Magnitude", names(DATA))
names(DATA)<-gsub("BodyBody", "Body", names(DATA))
## In order to view the names in DATA, use names(DATA) command


############################################################################################################
## Step 5
## Creates a second,independent tidy data set and ouput it
library(plyr);
TidyData<-aggregate(. ~subject + activity, DATA, mean)
TidyData<-TidyData[order(TidyData$subject,TidyData$activity),]
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)

############################################################################################################


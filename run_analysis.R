## =============================
## MASTER PLAN -- Occurs at beginning of each submitted document. This explains
##      what is in the overall plan and how the pieces fit together, referring
##      to the assignment.
## Purpose of this project: demonstrate ability to collect, work with, and clean a data set.
## Goal of this project: prepare tidy data that can be used for later analysis.
##  Subgoals (A-D):
## A. create one R script called run_analysis.R that does the following.
##      Steps (1-5):
## 1.	Merges the training and the test sets to create one data set.
## 2.	Extracts only the measurements on the mean and standard deviation
##      for each measurement.
## 3.	Uses descriptive activity names to name the activities in the data set
## 4.	Appropriately labels the data set with descriptive variable names.
## 5.	From the data set in step 4, creates a second, independent tidy data set,
##      named SubjectActivityMotionDataset.txt,
##      with the average of each variable for each activity and each subject.
## B.  create README.md  for inclusion in the repo, describing how the script works
##      Steps (1-4)
##      1. Orientation/overview
##      2. Explanation of my understanding of this assignment (
##      (or why what I did was what I thought I was supposed to do)
##      3. Quick overview of what program does when it runs
##      4. Summary: how run_analysis.R performs the required steps
##      5. Summary: how to use CodeBook.md
## C.  create CodeBook.md describing the variables and their derivation.
##      Steps (1-4)
##      1. Decisions about variables to be included in this project
##      2. Naming Conventions for variables in this project
##      3. Variable Names and Derivations for the internal datasets
##              (things you might need to know about Steps 1-4 in run_analysis.R
##              vectors, data tables, and variables created on the way to the answer,
##              in case you need to make sense of or repair the code)
##      4. Variable Names and Derivations for the tidy dataset,
##               (created in Step 5 in run_analysis.R), SubjectActivityMotionDataset.txt

## D.  generate SubjectActivityMotionDataset.txt using run_analysis.R

## =============================

## This is SubGoal A: R script called run_analysis.R that does the following:
##      Steps (1-5):
##STEP ZERO (doesn't occur in Master): Necessary housekeeping
## 1.	Merges the training and the test sets to create one data set.
## 2.	Extracts only the measurements on the mean and standard deviation
##      for each measurement.
## 3.	Uses descriptive activity names to name the activities in the data set
## 4.	Appropriately labels the data set with descriptive variable names.
## 5.	From the data set in step 4, creates a second, independent tidy data set,
##      named SubjectActivityMotionDataset.txt,
##      with the average of each variable for each activity and each subject.
##
##      STEP ZERO (doesn't occur in Master): Necessary housekeeping
##      Library calls -- all the packages that will be needed later.
library("data.table", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
library("plyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
library("dplyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
library("tidyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")

##      Initial Data Table Setups and Reads
## Initialize datasets for the data to be read into
TrainSubjectsDataset<-data.table()
TestSubjectsDataset<-data.table()
TrainActivityDataset<-data.table()
TestActivityDataset<-data.table()
TrainVariablesDataset<-data.table()
TestVariablesDataset<-data.table()

## Read data into the datasets
TrainSubjectsDataset<-read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
TestSubjectsDataset<-read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
TrainActivityDataset<-read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
TestActivityDataset<-read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
TrainVariablesDataset<-read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
TestVariablesDataset<-read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)

##STEP 1.	Merges the training and the test sets to create one data set.

##      Data Table Combinations to Form Grand Dataset
#Initialize datasets for combination operation
TrainDataset<-data.table()
TestDataset<-data.table()
GrandDataset<-data.table()
##bind datasets first into Train and Test
TrainDataset<-bind_cols(TrainSubjectsDataset,TrainActivityDataset,TrainVariablesDataset)
TestDataset<-bind_cols(TestSubjectsDataset,TestActivityDataset,TestVariablesDataset)
##then bind Train and Test dataset into Grand dataset
GrandDataset<-rbind(TrainDataset,TestDataset)
##Cleanup, getting rid of the temporary working databases to free up workspace
## and decrease clutter
remove(TrainSubjectsDataset,
       TestSubjectsDataset,
       TrainActivityDataset,
       TestActivityDataset,
       TrainVariablesDataset,
       TestVariablesDataset,
       TrainDataset,
       TestDataset)
## STEP2.Extracts only the measurements on the mean and standard deviation
##      for each measurement.

##      Read in Original Variable Names (reserve for further use in Step 3)
OriginalNames<-data.frame()
OriginalNames<-read.table("./UCI HAR Dataset/features.txt",header=FALSE)
OriginalVariableNames<-as.character(OriginalNames[,2])

##      Identify Measurements To Be Retained and Express Them As a Logical Vector
##      called RetainMeasurements.
## Details given in CodeBook.
##I used grep and the slightly awkward looping process because it was much faster
##and less flaky than match().  Grep reports an integer vector of column numbers
##rather than a logic vector.
VariablesThatContainMean<-grep('mean',OriginalVariableNames)
VariablesThatContainStdDeviation<-grep('std',OriginalVariableNames)
VariablesThatContainGrav<-grep('grav',OriginalVariableNames,ignore.case=TRUE)
VariablesThatContainmeanFreq<-grep('meanFreq',OriginalVariableNames)
##RetainMeasurements begins as a logical vector that is all FALSE, i.e. keeps nothing
RetainMeasurements<-logical(length(OriginalVariableNames))
##This pulls out all the possible variables to keep
for (i in VariablesThatContainMean) RetainMeasurements[i]<-TRUE
for (i in VariablesThatContainStdDeviation) RetainMeasurements[i]<-TRUE
##This cleans out the variables I chose not to keep (see CodeBook for details)
for (i in VariablesThatContainGrav) RetainMeasurements[i]<-FALSE
for (i in VariablesThatContainmeanFreq) RetainMeasurements[i]<-FALSE

##Adds two variable names at the front so columns will match up properly with PetitDataset
VariablesList<-c("Subject_Number","Activity_Code",OriginalVariableNames[RetainMeasurements])

## 3.	Uses descriptive activity names to name the activities in the data set

##The rules for renaming the measurement variables:
##The first word is the physical property being measured (Acceleration, which is
##a stand-in for force; Jerk, which is rate of change in acceleration;
## or AngularMomentum).

##If it's the Euclidean magnitude, i.e. sqrt(x^2+y^2+z^2), the word "magnitude"
## appears next; otherwise it may be assumed linear in whatever the dimension suffix specifies.

## Next there's a two-letter code indicating how the underlying data for this calculation was reported:
        ## AF=from the accelerometer, via frequency domain signals
        ##AT= from the accelerometer, via time domain signals
        ##GF=from the gyroscope, via frequency domain signals
        ##GT= from the gyroscope, via time domain signals
 ##The next suffix is the statistical moment, that is, whether it's the
        ##mean or the standard deviation being reported

##Finally,if the physical property is being measured in any specific direction.
        ##that direction will be the very last suffix on the variable name  (-X,-Y, or -Z).


##This long sequence of gsub() converts the original dataset names to something
        ##more people readable by modifying and changing the emphasis of the encoding
        ##that was already there in the original dataset. Please
        ##see codebook for full details. Note to me and anyone else: gsubs are very
        ##sensitive to order of execution! I made a complete mess of my data several
        ##times before I got the order of the gsubs right!

VariablesList<-gsub("fBodyAccJerk","Jerk-AF",VariablesList)
VariablesList<-gsub("fBodyAccMag","Acceleration-Magnitude-AF",VariablesList)
VariablesList<-gsub("fBodyBodyAccJerkMag","Acceleration-Magnitude-Jerk-AF",VariablesList)
VariablesList<-gsub("fBodyBodyGyroJerkMag","AngularMomentum-Jerk-GF",VariablesList)
VariablesList<-gsub("fBodyBodyGyroMag","AngularMomentum-Magnitude-GF",VariablesList)
VariablesList<-gsub("tBodyAccJerkMag","Jerk-Magnitude-AT",VariablesList)
VariablesList<-gsub("tBodyAccMag", "Acceleration-Magnitude-AT",VariablesList)
VariablesList<-gsub("tBodyGyroJerkMag","Jerk-Magnitude-GT",VariablesList)
VariablesList<-gsub("tBodyGyroMag","AngularMomentum-Magnitude-GT",VariablesList)
VariablesList<-gsub("tBodyGyroJerk","Jerk-GT",VariablesList)
VariablesList<-gsub("tBodyAccJerk", "Jerk-AT",VariablesList)
VariablesList<-gsub("fBodyAcc","Acceleration-AF",VariablesList)
VariablesList<-gsub("fBodyGyro","AngularMomentum-GF",VariablesList)
VariablesList<-gsub("tBodyAcc","Acceleration-AT",VariablesList)
VariablesList<-gsub("tBodyGyro","AngularMomentum-GT",VariablesList)


#Extract PetitDataset from GrandDataset so that it contains only desired columns
RetainColumns<-c(TRUE,TRUE,RetainMeasurements)
PetitDataset<-data.table()
PetitDataset<-GrandDataset[RetainColumns]

## 4.	Appropriately labels the data set with descriptive variable names.
##Attach the human-friendlier variable names to PetitDataset
colnames(PetitDataset)<-VariablesList

#Reassigning "Activity Code" to meaningful names; builds a vector (DecryptedActivity)
##to replace PetitDataset$Activity_Code
ActivityLabels<-data.frame()
ActivityLabels<-read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)
ActivityVector<-as.vector(ActivityLabels[,2])
DecryptedActivity<-character(nrow(PetitDataset))
ActIndex<-integer(1)
for (k in 1:nrow(PetitDataset)) {
        ActIndex<-PetitDataset$Activity_Code[k]
        DecryptedActivity[k]<-ActivityVector[ActIndex]
}
PetitDataset$Activity_Code<-DecryptedActivity
PetitDataset<-rename(PetitDataset,Activity=Activity_Code)


##Clean up working files from steps 2-4:
remove(GrandDataset,
       i,
       OriginalNames,
       OriginalVariableNames,
       RetainColumns,
       RetainMeasurements,
       VariablesThatContainGrav,
       VariablesThatContainmeanFreq,
       VariablesThatContainStdDeviation,
       VariablesThatContainMean,
       ActivityLabels,
       ActIndex,
       ActivityVector,
       DecryptedActivity,
       k,
       VariablesList)

##STEP 5. From the data set in step 4, creates a second, independent tidy data set,
##      named SubjectActivityMotionDataset.txt,
##      with the average of each variable for each activity and each subject.

#Create an intermediate dataset in which the data has been grouped by Subject_Number and Activity
SubjectActivityDataTable<-PetitDataset %>% group_by(Subject_Number,Activity)
#Now create the tertiary/final dataset in which individual values have been
#replaced by means on all variables except the grouping ones (one reason to use
#mutate_each is that it leaves grouping variables alone)
TidyGroupedSubjectActivityData<-mutate_each(SubjectActivityDataTable,funs(mean))
#remove duplicates and sort for convenience
FinishedTidyDataset<-unique(TidyGroupedSubjectActivityData)
FinishedTidyDataset<-arrange(FinishedTidyDataset,Subject_Number,Activity)
#Remove the last few no-longer-needed objects
remove(TidyGroupedSubjectActivityData,
       PetitDataset,
       SubjectActivityDataTable)
#Write the finished dataset to a file
write.table(FinishedTidyDataset,file="./SubjectActivityMotionDataset.txt")



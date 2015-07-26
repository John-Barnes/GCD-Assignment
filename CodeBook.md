---
title: "CodeBook.md"
author: "John Barnes"
date: "July 22, 2015"
output: html_document
---

# MASTER PLAN -- Occurs at beginning of each submitted document. This explains what is in the overall plan and how the pieces fit together, referring to the assignment.


## Purpose of this project: demonstrate ability to collect, work with, and clean a data set.
  
## Goal of this project: prepare tidy data that can be used for later analysis.
  
## Subgoals (A-D):
  
### A. create one R script called run_analysis.R that does the following. Steps (1-5):
       
1.	Merges the training and the test sets to create one data set.  
2.	Extracts only the measurements on the mean and standard deviation for each measurement.  
3.	Uses descriptive activity names to name the activities in the data set.  
4.	Appropriately labels the data set with descriptive variable names.  
5.	From the data set in step 4, creates a second, independent tidy data set, named SubjectActivityMotionDataset.txt, with the average of each variable for each activity and each subject.
	
### B.  create README.md  for inclusion in the repo, describing how the script works
       Steps (1-4)

1. Orientation/overview  
2. Explanation of my understanding of this assignment  (or why what I did was what I thought I was supposed to do)
3. Quick overview of what program does when it runs  
4. Summary: how run_analysis.R performs the required steps  
5. Summary: how to use CodeBook.md


###  C.  create CodeBook.md describing the variables and their derivation.
       Steps (1-4)  
       
1. Decisions about variables to be included in this project  
2. Naming Conventions for variables in this project  
3. Variable Names and Derivations for the internal datasets  
               (things you might need to know about Steps 1-4 in run_analysis.R vectors, data tables, and variables created on the way to the answer, in case you need to make sense of or repair the code)  
4. Variable Names and Derivations for the tidy dataset, (created in Step 5 in run_analysis.R), SubjectActivityMotionDataset.txt

### D.  generate SubjectActivityMotionDataset.txt using run_analysis.R

#This is SubGoal C: create CodeBook.md describing the variables and their derivation.
       Steps (1-4):
 
#CONTENTS OF CODEBOOK
 
##1. Decisions about variables to be included in this project

##2. Naming Conventions for variables in this project

##3. Variable Names and Derivations for the internal datasets  
(things you might need to know about Steps 1-4 in run_analysis.R vectors, data 
tables, and variables created on the way to the answer, in case you need to make 
sense of or repair the code)

##4. Variable Names and Derivations for the tidy dataset  
Where you go to look stuff up! Created in Step 5 in run_analysis.R 
                
#1. Decisions about variables to be included in this project

This dataset contains a large number of observations of the motion of a cell  
phone clipped to the waist of people exercising. It is a subset of a much larger  
dataset prepared by the UCI Machine Learning Repository  
(http://archive.ics.uci.edu/ml/index.html for much more information).

Some variables that mention mean and standard deviation in the original datasets  
(such as meanGravity) appear to have been recorded primarily to calibrate  
instruments rather than to record exercise performance; since gravity is a  
consistent large acceleration, the original researchers included separately  
calculated gravity accelerations to make it easy to extract them for comparisons.  
Because the variables to be used to actually analyze motion are calculated, gravity  
values have already been subtracted from them and are not relevant to a purpose  
of analyzing body motion, so they are omitted in the final tidy dataset.

Some variables are primarily aggregate measures of how well the recording  
equipment was working, addressed to engineers of the monitoring equipment more than  
kinesiologists and physiologists. These include variables whose names included  
meanFrequency and other usages other than -mean(). Because this tidy dataset has  
been prepared primarily for research into individual exercise behavior rather than  
study of reporting methods or physics computation, variables for these other  
observational and adjustment purposes have been omitted.

Experimentation showed that by selecting only the variables that included -mean()  
and -std(), and specifically excluding the ones that included “grav” and  
“meanFrequency,” the dataset could be reduced to an acceptable size while  
preserving all the variables that actually measured the body motion of the person  
exercising.

The following has been edited from the original document features_info.text; I’ve  
left only the information that applies the variables I retained. (Note that the  
authors refer to the variables as “features”):

##BEGIN EDITED TEXT FROM features_info.text 
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 



Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 



Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 



These signals were used to estimate variables of the feature vector for each pattern:  

'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.



tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag



The set of variables that were estimated from these signals are: 



mean(): Mean value

std(): Standard deviation


Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:


tBodyAccMean

tBodyAccJerkMean

tBodyGyroMean

tBodyGyroJerkMean


##END EDITED TEXT FROM features_info.text 

#2. Naming Conventions for variables in this project

##General Identifiers for observations do not follow conventions used in rest of data
###Subject Number  
a unique number assigned to each person exercising. There were 30 different test subjects, so subject numbers go from 1 to 30.

###Activity  
One of six activities people did as part of the exercise in this study. The six  
activities were walking, walking upstairs, walking downstairs, sitting, standing,  
and laying.

##Other observations given more human-interpretable names  
Since the terms above from the original documentation are somewhat cryptic, and  
to my mind they overvalue how the data was reported and undervalue  
hat it is, I've invented a different nomenclature.  In my dataset, the very  
abbreviated and ambiguous variable names above have been replaced with something 
more straightforward.  The rules are as follows:

###The first word is the physical property being measured  
It will be one of three words: Acceleration, which is a stand-in for force;  
Jerk, which is rate of change in acceleration; or AngularMomentum (which is  
actually a short term for "Change in Angular Momentum over Time")). 

###Either the second word is Magnitude or there's a final dimensional suffix  
If it's the Euclidean magnitude, i.e. sqrt(x^2+y^2+z^2), the word "magnitude"  
appears next; otherwise there will be a dimensional suffix at the end, and the  
physical property is linear in whatever direction the dimension suffix specifies,  
which will be X, Y, or Z.

###There's a two-letter code indicating how the underlying data for this calculation was reported:

AF=from the accelerometer, via frequency domain signals  
AT= from the accelerometer, via time domain signals  
GF=from the gyroscope, via frequency domain signals  
GT= from the gyroscope, via time domain signals   

### The code Mean or StDev identifies the statistical moment 

i.e. whether it's the mean or the standard deviation being reported

### Dimensional suffix:  
if the physical property has a direction it's identified with a final suffix on  
the variable name  (-X,-Y, or -Z).  




#3. Variable Names and Derivations for the Internal datasets  
(Steps 1-4 in run_analysis.R)

##3a. The following objects are used internally only in Step 1 of run_analysis.R,  
in the process of reading data and assembling it into a combined database. They  
are removed from the workspace at the end of Step 1.

* TrainSubjectsDataset

* TestSubjectsDataset

* TrainActivityDataset

* TestActivityDataset

* TrainVariablesDataset

* TestVariablesDataset

* TrainDataset

* TestDataset

##3b. The following objects are removed shortly before the end of Step 4,  
as once the PetitDataset is completed there's no further need for any of them. 

*GrandDataset

*i

*OriginalNames

*OriginalVariableNames

*RetainColumns

*RetainMeasurements

*VariablesThatContainGrav

*VariablesThatContainmeanFreq

*VariablesThatContainStdDeviation

*VariablesThatContainMean

*ActivityLabels

*ActIndex

*ActivityVector

*DecryptedActivity

*k

*VariablesList

##3c. Some very large files are removed once the smaller tidy file has been established,  
just before the final report is written to the working directory as a text file.  
Though there's no danger of their accidentally getting into a current computation,  
they are huge and take up space and time that could be better used. They are:

*TidyGroupedSubjectActivityData
        
*PetitDataset
       
*SubjectActivityDataTable
       
#4. The variables/columns in Finished Tiny Dataset, in order:
 
 1 Subject_Number The number assigned by the original researchers to identify a subject. Integer. There were 30 subjects in the study and there are no missing numbers    

2 Activity One of six activities in which participants took part. Originally coded as a number, converted to text here by using a simple table lookup.    

3 Acceleration-AT-mean()-X Mean   acceleration  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

4 Acceleration-AT-mean()-Y Mean   acceleration along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

5 Acceleration-AT-mean()-Z Mean   acceleration along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

6 Acceleration-AT-std()-X Standard deviation of  acceleration  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

7 Acceleration-AT-std()-Y Standard deviation of  acceleration along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

8 Acceleration-AT-std()-Z Standard deviation of  acceleration along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

9 Jerk-AT-mean()-X Mean  jerk  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

10 Jerk-AT-mean()-Y Mean  jerk along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

11 Jerk-AT-mean()-Z Mean  jerk along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

12 Jerk-AT-std()-X Standard deviation of jerk  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

13 Jerk-AT-std()-Y Standard deviation of jerk along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

14 Jerk-AT-std()-Z Standard deviation of jerk along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

15 AngularMomentum-GT-mean()-X Mean  angular momentum  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

16 AngularMomentum-GT-mean()-Y Mean  angular momentum along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

17 AngularMomentum-GT-mean()-Z Mean  angular momentum along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

18 AngularMomentum-GT-std()-X Standard deviation of angular momentum  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

19 AngularMomentum-GT-std()-Y Standard deviation of angular momentum along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

20 AngularMomentum-GT-std()-Z Standard deviation of angular momentum along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

21 Jerk-GT-mean()-X Mean  jerk  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

22 Jerk-GT-mean()-Y Mean  jerk along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

23 Jerk-GT-mean()-Z Mean  jerk along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

24 Jerk-GT-std()-X Standard deviation of jerk  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

25 Jerk-GT-std()-Y Standard deviation of jerk along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

26 Jerk-GT-std()-Z Standard deviation of jerk along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

27 Acceleration-Magnitude-AT-mean() Mean  Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total acceleration Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

28 Acceleration-Magnitude-AT-std() Standard deviation of Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total acceleration Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

29 Jerk-Magnitude-AT-mean() Mean  Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total jerk Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

30 Jerk-Magnitude-AT-std() Standard deviation of Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total jerk Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in time.

31 AngularMomentum-Magnitude-GT-mean() Mean  Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total angular momentum Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

32 AngularMomentum-Magnitude-GT-std() Standard deviation of Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total angular momentum Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

33 Jerk-Magnitude-GT-mean() Mean  Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total jerk Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

34 Jerk-Magnitude-GT-std() Standard deviation of Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total jerk Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in time.

35 Acceleration-AF-mean()-X Mean   acceleration  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

36 Acceleration-AF-mean()-Y Mean   acceleration along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

37 Acceleration-AF-mean()-Z Mean   acceleration along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

38 Acceleration-AF-std()-X Standard deviation of  acceleration  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

39 Acceleration-AF-std()-Y Standard deviation of  acceleration along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

40 Acceleration-AF-std()-Z Standard deviation of  acceleration along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

41 Jerk-AF-mean()-X Mean  jerk  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

42 Jerk-AF-mean()-Y Mean  jerk along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

43 Jerk-AF-mean()-Z Mean  jerk along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

44 Jerk-AF-std()-X Standard deviation of jerk  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

45 Jerk-AF-std()-Y Standard deviation of jerk along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

46 Jerk-AF-std()-Z Standard deviation of jerk along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

47 AngularMomentum-GF-mean()-X Mean  angular momentum  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in frequency.

48 AngularMomentum-GF-mean()-Y Mean  angular momentum along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in frequency.

49 AngularMomentum-GF-mean()-Z Mean  angular momentum along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in frequency.

50 AngularMomentum-GF-std()-X Standard deviation of angular momentum  along the X-axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in frequency.

51 AngularMomentum-GF-std()-Y Standard deviation of angular momentum along the Y-axis Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in frequency.

52 AngularMomentum-GF-std()-Z Standard deviation of angular momentum along the Z -axis. Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in frequency.

53 Acceleration-Magnitude-AF-mean() Mean  Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total acceleration Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

54 Acceleration-Magnitude-AF-std() Standard deviation of Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total acceleration Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

55 Acceleration-Magnitude-Jerk-AF-mean() Mean  Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total jerk Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

56 Acceleration-Magnitude-Jerk-AF-std() Standard deviation of Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total jerk Average value computed on several observations for this combination of subject and activity. Reported by the accelerometer and estimated via changes in frequency.

57 AngularMomentum-Magnitude-GF-mean() Mean  Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total angular momentum Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in frequency.

58 AngularMomentum-Magnitude-GF-std() Standard deviation of Euclidean magnitude, sqrt(X^2+Y^2+Z^2), of the total angular momentum Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in frequency.

59 AngularMomentum-Jerk-GF-mean() Mean angular momentum change (which is equivalent to acceleration) as calculated from measured jerk.  Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in frequency.

60 AngularMomentum-Jerk-GF-std() Standard deviation of angular momentum change (which is equivalent to acceleration) as calculated from measured  Average value computed on several observations for this combination of subject and activity. Reported by the gyroscope and estimated via changes in frequency.


---
title: "ReadMe.md"
author: "John Barnes"
date: "July 22, 2015"
output: html_document
---
# GCD-Assignment
This repository was created as part of my final project for the Johns Hopkins/Coursera course in "Getting and Cleaning Data." It is intended to hold materials relating to the final assignment for that course. 

The material below is an explanation of the other files in this repository. Note that it (and every document in this assignment except the actual dataset) begin with a master explanation of the whole assignment and document set, a note about which document/part of the assignment this is, and then the relevant text or code.

# ReadMe.md
author: "John Barnes"
date: "July 26, 2015"


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


# This is SubGoal B: The ReadMe.md file which contains the following:  Steps (1-5):
##1. Orientation/overview
##2. Explanation of my understanding of this assignment (or why what I did was what I thought I was supposed to do)
##3. Quick overview of what program does when it runs
##4. Summary: how run_analysis.R performs the required steps
##5. Summary: how to use CodeBook.md

# 1. Orientation/Overview:
 
 The text file of the tidy database loaded just fine, and I've sourced and run the run_analysis
       file several times from a cold start, so I know it's working pretty well.  This document is just a
       few quick notes to make clear how it all fits together.
       
#2. As I understood the assignment, 
  we were to take a huge messy pile of badly organized, hard to understand data, and reduce it to something
  compact and meaningful, in a clean cross-tab. I settled on 60 variables (subject, activity, and 58 that seemed
  to me to be directly reporting motion); there were 10,299 original observations. This boils it down to a 180X60
  grid that I think really could be used to study people's exercise habits. A very large number of the kinds of
  the raw data, as I noted in the CodeBook, seemed to be more about calibration or administration than about
  actually understanding what happens when people exercise, so I discarded many more than I kept.
       
#3. About running the program:  

### a. run_analysis.R is all in one  
all one need do is run it, and there are no separately called functions.

###b. There are library calls up front  
to make sure you're running data.table, plyr, dplyr, and tidyr. 
###c. run_analysis.R assumes that you have the UCI HAR Dataset  
unzipped and in a folder in your working directory, with the same structure it came with.

###d. The program seems to have no problem overwriting its own previous finished dataset,  
so it can be tested repeatedly without clearing prior files.

### e. The necessary longish run time may seem a bit perturbing  
if you source it and run it, because all you'll see is various  harmless warnings  
for a while. Don't worry, it's doing what it's supposed to!

###f. When run_analysis.R finishes,  
there will be a dataset called FinishedTidyData in your workspace, and  
a copy of it in a .txt file called SubjectActivityMotionDataset.txt in your working directory.
	
###g. I have an old habit of always cleaning out working files,  
so there's not much to see while it runs and if it works right, there's just a result at the end.
       
#4. The basic working process: 
   
run_analysis.R first brings all the required files into shortlived temporary data tables,  
then column and row binds them into the "everything version," GrandDataset.  
It then follows a set of rules to locate the mean standard deviation variables  
and creates a logic vector with which to weed out both names and columns. 

       There's a lot about those decisions in the Code Book.    
       
Once it has run the names and the data against that logic vector
and cut the volume down (PetitDataset is less than a fifth the size of GrandDataset),  
it next uses a short group of gsub commands to rephrase the column headings into  
something people-friendlier, and adds the revised names as column heads.

Then it applies group by and mutate each to PetitDataset to produce a file  
where individual values are all replaced by group means,   
weeds out the many duplicates with unique(),   
arranges it all for easier reading,  
and voila! The datset is done.
        
#5. Using the CodeBook.
    
    Like any good reference book, mostly you will want to start at the back, where
 there's a list of all the variables and what they are. Up at the front it explains 
 some of my decisions about which data to work with, discusses a bunch of temporary
 variables, vectors, and dataframes that you won't have to worry about unless
the program breaks down in the middle, and explains the rules by which I created more
readable variable names (at least I thought they were more readable). A shorter version
of that also appears in the program's comments.
  

---
title: "Code Book"
author: "Green"
date: "Thursday, August 14, 2014"
output: html_document
---

## Description of the variables

The variables for this project were provided by 

==================================================================

Human Activity Recognition Using Smartphones Dataset
Version 1.0

==================================================================

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

==================================================================

Each measured variables were defined by the original authors in two files 

1. "./features_info.txt"" and 
2. "./features.txt" file. 

The first file describes each variable and what each variable is measuring. The second file enumerates each variable by name. There are a total of 561 variables in the second file. However, the current analysis extracts only variables of the form

\*-mean()\* and

\*-std()\*, 

which represents the mean and standard deviation of each measured variable in each of three dimensions X, Y and Z. 

Accompanying these measures are two other variables. The first numerically identifies a participant, "person\_ID", while the second identifies the activity, "Activity\_ID" performed by each person. This information will be extracted and used in this analysis.

## The Data

There were 30 volunteers and each volunteer performed six different activities:

1. Walking
2. Walking_Upstairs
3. Walking_downstairs
4. Sitting
5. Standing
6. Laying

There are 10,299 observations on the 561 variables. In the process of tidying data the dimensions of this set of data will decline. To each row of this data set will be bound an identifier of the subject and the activity.

#Data Transformations

The analysis begins with the importation of the raw data. In the run_analysis.R file this is done using six lines of code. The variables XTrain, YTrain and SubTrain are created and represent the 561 measures for each person in the training data set. YTrain identifies the activities of each line of code in the XTrain file, and will eventually be bound to that file. Finally, the SubTrain identifies the test subjects. With this information the variable SYTrain is created by binding the columns of the SubTrain and YTrain variables and these two variables are then removed from the working memory.  An identical process is then performed to extract the test data creating an XTest, YTest and SYTest variable, including the removal of the variables YTest and STest.

At this point the XTrain and XTest data is stacked creating the variable DTA. Similarly, SYTrain and SYText are stacked to create the new variable DTARL. Then the original data, separated data, is removed from the working memory. The variable DTA is of dimension 10,299 rows and 561 columns and represents all of the measures from this project. The variable DTARL is a 10299 by 2 dimensional variable where each row identifies the subject and the activity in each row of the DTA variable; however, these two data sets will not be bound together just yet.

###Creating names for the features

Each column in DTA has a name. These names are given by the original authors of this study in the file "./features.txt". I will extract this information and use it below. 

From the vn variable the function grep is used three times. The purpose of using grep is to extract the position of all variable names with the word "mean", with the word "Mean", and the word "std" within the variable names

The next step in the process is to subset the DTA data frame. Subseting is performed to select the columns with variables containing the words "mean", "Mean" or "std". The new data frame, DTA, contains only columns of data representing "mean", "Mean" and "std" variables. 

From the vn data frame, where all of the variable names are stored, extract only the variable names containing "mean", "Mean" and "std". Construct a vector from the data frame vnp. Extend this vector by adding "Person_ID" and "Activity_ID". Finally there is a vector with the names of all the variables of interest. At this point bind the paired data frame DTA with the DTARL data frame. This yields a data frame, DTA, with person ID and Activity ID as well as all measures containing "mean","Mean", and "std". Finally, place names for each variable into the DTA data frame using the vector vnames.

Construct a factor variable so the Activity ID, which prior to this step are numbers, can receive a descriptive name. Give the factor variable the descriptive names.

Finally, perform the aggregation of the DTA$Person and DTA$fActivity to create a data frame containing the mean of each variable for each person and each activity. This is the tidy data set that we set out to create. So, write this variable to the file "./TidyData.txt"


README.md file

##Introduction

This README file compiles the necessary information about the different files used in the Course Project of Getting and cleaning data.

###Files

There are four files created for this assignment.

1. A tidy data set "./TidyData.txt".
2. The script used to create the tidy data set "./run_analysis.R".
3. A code book "./CodeBook.md".
4. This readme file "./README.md".

###Additional Files

The other files in the git repository contain:

1. The zipped Data file.
2. EXTFile - the file with the data extracted from the zipped file.

This completes the list of the files added by this author to the analysis. The other files in the github repository were provided by the instructors of this particular Coursera module.

The details of my r script are given in the files "./CodeBook.md" and in "./run_analysis.R". The gist of the work in its broadest form is that two data frames, are going to be merged. Each data frame has observations on the same 561 variables. So, these two data frames are "stacked" making a single data frame with 10,299 observations. Each observation is associated with an activity and a person. Two other data frames are extracted and stacked so we can identify each person and activity in the final data frame.

The size of the first data frame, 10,299 by 561, is reduced so that only variables representing the "mean()" and "std()" of some variable is left in our data frame. With the size of the big data frame reduced as described here I then merge the data frame containing the names and activities of each observation to the measures. Using this new data frame we can reach a final tidy data set, as asked for in the problem statement, by aggregating the data. The data is aggregated by taking the mean of each variable for each person ID and each activity. The data frame is then saved to a text file.
SamsungDataCleaningProject
==========================

Course project for Getting and Cleaning Data

The function run_analysis reads in the relevant data for this project from a folder called "UCI HAR Dataset" in the working directory. The data read in includes the test data, the training data, the features (which provides names for the columns), the numerical designation for the activity, and the subject number. 

The run_analysis function then uses cbind and rbind to conglomerate the data together into one data set to satisfy Step 1. This is saved as a file, since that's how I interpreted Step 1 although it is ambiguous. The conglomerated data is then stripped down to only the mean and standard deviation data, plus the activity designation and subject number required to complete the other steps. This satisfys Step 2.

For Step 3 I have set up a for loop containing a series of if statements which assign the proper activity labels to the appropriate rows.

For Step 5 I have an aggregate command which takes the mean of the data divided up by activity and subject. This data is then written out to a text file called "final.txt" in the "UCI HAR Dataset" folder.   

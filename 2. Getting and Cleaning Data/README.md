#2. Getting And Cleaning Data

========================

###How run_analysis.R works



* imports the data from the train set and the test set.

* merges the 3 types of datasets (measured properties, subjects, activities performed) for the X, Y and S set.

* replaces, in the data, the activity identifiers with the activity labels (human readable)

* extracts the mean() and std() variables from the dataset

* merges the resulting sets

* computes the average of each variable for each activity and each subject and saves it into the tidy dataset (mean_activity_subject.txt)

---
title: "ReadMe"
author: "Aniruddha Amrite"
date: "December 12, 2016"
output: html_document
---

The file describes the steps in creating a tidy dataset form several datasets in a database. 

## Steps for creating a combined dataset from several datasets
1)  set a working directory and down load and unzip the UCI HAR datasets 
2)  read in the descriptive labels for the activities using the read.table function. 
3)  Read in the training datasets X_train, y_train and subject_train (read in R as training_values, training_labels and     training_subjects respectively)
4)  The subject_train dataset has just the ID numbers for the subjects hence the variable is renamed as ID
5)  The activity labels are found in the activity labels dataset. Merge the training labels and activity labels dataset
    to get a datsaet that has both the activity labels and numbers
6)  The names of the columns for the training_values dataset can be obtained from the features.txt dataset. 
7)  Make a complete training dataset by using cbind on the three training datasets
8)  Repeat the above steps for the test datasets X_test y_test and subject_test (read in R as test_values, test_labels      and test_subjects respectively) and combine the test datasets into one
9)  Prepare a combined training and test dataset (combo_dset) by using rbind o the training and test datasets
10) Select only the mean and Standard deviation based parameters from the combo_dset to form the final tidy combined        dataset
11) Create a new average dataset from the final combined dataset which averages the variables by ID and activity label
12) Write and export this average tidy dataset

## Reasons why the datset is Step 10 is tidy

The dataset created in step 10 has 1 record per subject and activity which should be a feature of a tidy dataset. Only the columns required for the analysis have been selected. Explanatory names like ID and activity labels have been provided for the columns and the names for values of the activities are explained in the features.txt from the original database and have been explained in the codebook.md file that accompanies the dataset. 

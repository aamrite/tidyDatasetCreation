##load the required packages
library(doBy)
###Getting datasets from the analysis####

setwd("H:\\Personal\\Continuing Education\\Data Scientist Specialization\\Getting and Cleaning Data\\Assignment")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Dataset.zip")

#unzip the files

unzip(zipfile="./Dataset.zip",exdir=".")##unzip files in the same working directory

###Get the activity labels
activity_labels<-read.table("H:\\Personal\\Continuing Education\\Data Scientist Specialization\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset\\activity_labels.txt")


### read the training datasets

training_values<-read.table("H:\\Personal\\Continuing Education\\Data Scientist Specialization\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset\\train\\X_train.txt")
training_labels<-read.table("H:\\Personal\\Continuing Education\\Data Scientist Specialization\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset\\train\\y_train.txt")
training_subjects<-read.table("H:\\Personal\\Continuing Education\\Data Scientist Specialization\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset\\train\\subject_train.txt")

names(training_subjects)<-c("ID")# rename the single variable in the dataset as ID

##merge the activity labels dataset with training labels dataset based on ID
training_labels<-merge(activity_labels,training_labels)

names(training_labels)<-c("LableNo","ActivityLabel")


##read the features dataset to get labels for the training values
features<-read.table("H:\\Personal\\Continuing Education\\Data Scientist Specialization\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset\\features.txt")

##use the features values to label the training values
names(training_values)<-features$V2

#combine the training into one dataset
training<-cbind(training_subjects,training_values,training_labels)

### read the test datasets
test_values<-read.table("H:\\Personal\\Continuing Education\\Data Scientist Specialization\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset\\test\\X_test.txt")
test_labels<-read.table("H:\\Personal\\Continuing Education\\Data Scientist Specialization\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset\\test\\y_test.txt")
test_subjects<-read.table("H:\\Personal\\Continuing Education\\Data Scientist Specialization\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset\\test\\subject_test.txt")
names(test_subjects)<-c("ID")
##merge the activity labels dataset with test labels dataset based on ID
test_labels<-merge(activity_labels,test_labels)
names(test_labels)<-c("LableNo","ActivityLabel")

names(test_values)<-features$V2


#combine the test into one dataset
test<-cbind(test_subjects,test_values,test_labels)


###combine the training and test into one dataset

combo_dset<-rbind(test,training)
names(combo_dset)



##selecting only the mean and SD values
mean_para<-grepl("mean",names(combo_dset))
sd_para<-grepl("std",names(combo_dset))
Mean_para<-grepl("Mean",names(combo_dset))## the mean for the angle variables is labelled as "Mean" and not "mean"
combo_dset2<-combo_dset[,mean_para==T|sd_para==T|Mean_para==T]
combo_dset3<-combo_dset[,c("ID","LableNo","ActivityLabel")]
combo<-cbind(combo_dset3,combo_dset2)

combo<-combo[order(combo$ID,combo$LableNo),]


###Average Dataset

avgdset<-aggregate(.~ID+ActivityLabel+LableNo,data=combo, FUN="mean")

write.table(avgdset,file="H:\\Personal\\Continuing Education\\Data Scientist Specialization\\Getting and Cleaning Data\\Assignment\\output.txt", row.names=F)

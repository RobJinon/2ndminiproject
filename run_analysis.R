# CMSC 197 - 2
# 2nd Mini Project: Part 1
# by Jon Robien Jinon


#load required libraries
library("data.table")

# download files
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"

if(!file.exists("part1.zip")){
  download.file(url, "part1.zip")
}

if(!dir.exists("specdata")){
  dir.create("specdata")
}

if(!dir.exists("specdata/UCI HAR Dataset")){
  unzip("part1.zip", exdir = "specdata")
}

# load data from files
subject_train <- read.table("./specdata/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./specdata/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./specdata/UCI HAR Dataset/train/Y_train.txt")
subject_test <- read.table("./specdata/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./specdata/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./specdata/UCI HAR Dataset/test/Y_test.txt")


names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"


# change column names 
features <- read.table("./specdata/UCI HAR Dataset/features.txt")
names(x_train) <- features$V2
names(x_test) <- features$V2

names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"

names(y_train) <- "activityID"
names(y_test) <- "activityID"


# combine all data into one dataset
combined_data <- rbind( cbind(subject_train, y_train, x_train), cbind(subject_test, y_test, x_test) )

# extract measurements on the mean and standard deviation for each measurement
extract <- grepl("mean|std", features)
extract[1:2] <- TRUE

combined_data <- combined_data[, extract]



# create second, independent tidy data set with the average of each variable for each activity and each subject
train_data <- cbind(as.data.table(subject_train), y_train, x_train)
test_data <- cbind(as.data.table(subject_test), y_test, x_test)
data <- rbind(test_data, train_data)

id_labels <- c("subjectID", "activityID")
data_labels <- setdiff(colnames(data), id_labels)
melt_data = melt(data, id=id_labels, measure.vars=data_labels)

tidy_data = dcast(melt_data, subjectID + activityID ~ variable, mean)

# create csv file for tidy data
write.csv(tidy_data, "tidy_data.csv", row.names=FALSE)
print("CSV file created! Check tidy_data.csv.")




# CMSC 197 - 2: 2nd Mini Project

# Part 1
The first step in cleaning and tidying data is to add column names.
In this case, the column names were already provided from the features.txt file so we just load the file and load them into the x_train and x_test dataframes.

The next step is to combine all of the data.
This is done by first combining all of the train and test data separately using the cbind function. 
After te train and test data are combined, we then combile them together using rbind.

Now we need to extract only the the measurements on the mean and standard deviation for each measurement.
This is done using grepl. (line 53)
Then we filter the data from the combined dataframe using "combined_data[, extract]"

In order to create a second, independent tidy data set with the average of each variable for each activity and each subject, this is done using melt() to create a molten dataframe.

The last step is to create the CSV file for the tidy data set. 

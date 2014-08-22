dataclean
=========
Project for Getting and Cleaning Data

1> We received all the raw data from https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip

2> The main code downloads the zip file and reads the file using read.table

3> The column labels are in features.txt. We are reading the column names while reading the file itself (saves us some headache later on.)

4> test data set and corresponding files are read in the file with suffix *test train data set and corresponding files are read in the file with suffix *train

5> We merge the test and train data set as required in the assignment.

6> We add subject and activity columns as the primary keys (to be used later on)

7> Now, all the activity labels are in other file activity_labels.txt. We read and merge the corresponding dataframe with our earlier dataframe. Note, we drop the numberic activity identifier.

8> Finally, we use ddply to get mean by subject and activity. We store this output as tidydata.

9> We write the tidydata to a file.

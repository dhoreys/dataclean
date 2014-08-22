
setwd("C:\\EDA\\R\\dataclean")
#download the data
if (!file.exists("./smartphones.zip")){
        #download.file("https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip", destfile = "dataysd/smartphones.zip")
        download.file("https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip", destfile = "./smartphones.zip")
        unzip("./smartphones.zip")
   
}

#features <- read.csv("./proj/UCI HAR Dataset/features.txt")
features <- read.table("./proj/UCI HAR Dataset/features.txt")

#label column names
colnames <- features$V2

# test data set - 30% data and read the column labels
test <- read.table("./proj/UCI HAR Dataset/test/X_test.txt", col.names = colnames)

#read the subjects for test data
subject_test <- read.table("./proj/UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test)[1] <- "subject" 

#read the activity levels for test data 
y_test <- read.table("./proj/UCI HAR Dataset/test/y_test.txt")
colnames(y_test)[1] <- "activity" 

# training data set - 70% data
train <- read.table("./proj/UCI HAR Dataset/train/X_train.txt", col.names = colnames)

#read the subjects for training data and read the column labels
subject_train <- read.table("./proj/UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train)[1] <- "subject"

#read the activity levels for training data
y_train <- read.table("./proj/UCI HAR Dataset/train/y_train.txt")
colnames(y_train)[1] <- "activity" 

test1 <- cbind(subject_test, y_test, test)
train1 <- cbind(subject_train, y_train, train)


#append the training and test data sets. 
#NOTE: The instructions says "merge", but I doubt that. Merge needs atleast 1 common column
mydata <- rbind(test1, train1)

#select columns that have 'mean' and standard deviation i.e. 'std'
meandf <- subset(mydata, select=(names(mydata)[grep('mean',names(mydata))]))
stddf <- subset(mydata, select=(names(mydata)[grep('std',names(mydata))]))

#just adding subject and activity so that we can do other cool stuff.
subdf <- subset(mydata, select=(names(mydata)[grep('subject',names(mydata))]))
actdf <- subset(mydata, select=(names(mydata)[grep('activity',names(mydata))]))
subset1 <- cbind(subdf, actdf, meandf, stddf)

actv <- read.table("./proj/UCI HAR Dataset/activity_labels.txt")
colnames(actv)[1] <- "activity"
colnames(actv)[2] <- "activitylabel"

# merge the data. this is many to one relationship.
mergedata <- merge(subset1, actv, by=c("activity"))
#drop the old column
mergedata$activity <- NULL


#tmpdata <- mergedata[,-1]
#tempdata <- tmpdata[,-(ncol(tmpdata))]

# To create tidydata, I am using ddply that returns dataframe
# There is definitely a better way to do this rather than type in all the names here.
tidydata <- ddply(mergedata, .(subject, activitylabel), summarize,
      
      tBodyAcc.mean...X = round(mean(tBodyAcc.mean...X), 2),
      tBodyAcc.mean...Y = round(mean(tBodyAcc.mean...Y), 2),
      tBodyAcc.mean...Z = round(mean(tBodyAcc.mean...Z), 2),
 
      tGravityAcc.mean...X = round(mean(tGravityAcc.mean...X), 2),
      tGravityAcc.mean...Y = round(mean(tGravityAcc.mean...Y), 2),
      tGravityAcc.mean...Z = round(mean(tGravityAcc.mean...Z), 2),
      
      tBodyAccJerk.mean...X = round(mean(tBodyAccJerk.mean...X), 2),
      tBodyAccJerk.mean...Y = round(mean(tBodyAccJerk.mean...Y), 2),
      tBodyAccJerk.mean...Z = round(mean(tBodyAccJerk.mean...Z), 2),
       
      tBodyGyro.mean...X = round(mean(tBodyGyro.mean...X), 2),
      tBodyGyro.mean...Y = round(mean(tBodyGyro.mean...Y), 2),
      tBodyGyro.mean...Z = round(mean(tBodyGyro.mean...Z), 2),
      
      tBodyGyroJerk.mean...X = round(mean(tBodyGyroJerk.mean...X), 2),
      tBodyGyroJerk.mean...Y = round(mean(tBodyGyroJerk.mean...Y), 2),
      tBodyGyroJerk.mean...Z = round(mean(tBodyGyroJerk.mean...Z), 2),
               
      tBodyAccMag.mean.. = round(mean(tBodyAccMag.mean..), 2),
      tGravityAccMag.mean.. = round(mean(tGravityAccMag.mean..), 2),
      tBodyAccJerkMag.mean.. = round(mean(tBodyAccJerkMag.mean..), 2),
      tBodyGyroMag.mean.. = round(mean(tBodyGyroMag.mean..), 2),
      tBodyGyroJerkMag.mean.. = round(mean(tBodyGyroJerkMag.mean..), 2),
      

      fBodyAcc.mean...X = round(mean(fBodyAcc.mean...X), 2),
      fBodyAcc.mean...Y = round(mean(fBodyAcc.mean...Y), 2),
      fBodyAcc.mean...Z = round(mean(fBodyAcc.mean...Z), 2),
      
      fBodyAcc.meanFreq...X = round(mean(fBodyAcc.meanFreq...X), 2),
      fBodyAcc.meanFreq...Y = round(mean(fBodyAcc.meanFreq...Y), 2),
      fBodyAcc.meanFreq...Z = round(mean(fBodyAcc.meanFreq...Z), 2),
      
      fBodyAccJerk.mean...X = round(mean(fBodyAccJerk.mean...X), 2),
      fBodyAccJerk.mean...Y = round(mean(fBodyAccJerk.mean...Y), 2),
      fBodyAccJerk.mean...Z = round(mean(fBodyAccJerk.mean...Z), 2),
      
      fBodyAccJerk.meanFreq...X = round(mean(fBodyAccJerk.meanFreq...X), 2),
      fBodyAccJerk.meanFreq...Y = round(mean(fBodyAccJerk.meanFreq...Y), 2),
      fBodyAccJerk.meanFreq...Z = round(mean(fBodyAccJerk.meanFreq...Z), 2),
      
      fBodyGyro.mean...X = round(mean(fBodyGyro.mean...X), 2),
      fBodyGyro.mean...Y = round(mean(fBodyGyro.mean...Y), 2),
      fBodyGyro.mean...Z = round(mean(fBodyGyro.mean...Z), 2),

      fBodyGyro.meanFreq...X = round(mean(fBodyGyro.meanFreq...X), 2),
      fBodyGyro.meanFreq...Y = round(mean(fBodyGyro.meanFreq...Y), 2),
      fBodyGyro.meanFreq...Z = round(mean(fBodyGyro.meanFreq...Z), 2),
      
      fBodyAccMag.mean.. = round(mean(fBodyAccMag.mean..), 2),
      fBodyAccMag.meanFreq.. = round(mean(fBodyAccMag.meanFreq..), 2),
      fBodyBodyAccJerkMag.mean.. = round(mean(fBodyBodyAccJerkMag.mean..), 2),
      fBodyBodyAccJerkMag.meanFreq.. = round(mean(fBodyBodyAccJerkMag.meanFreq..), 2),
      fBodyBodyGyroMag.mean.. = round(mean(fBodyBodyGyroMag.mean..), 2),
      fBodyBodyGyroMag.meanFreq.. = round(mean(fBodyBodyGyroMag.meanFreq..), 2),
      fBodyBodyGyroJerkMag.mean.. = round(mean(fBodyBodyGyroJerkMag.mean..), 2),
      fBodyBodyGyroJerkMag.meanFreq.. = round(mean(fBodyBodyGyroJerkMag.meanFreq..), 2),
      
      tBodyAcc.std...X = round(mean(tBodyAcc.std...X), 2),
      tBodyAcc.std...Y = round(mean(tBodyAcc.std...Y), 2),
      tBodyAcc.std...Z = round(mean(tBodyAcc.std...Z), 2),
      
      tGravityAcc.std...X = round(mean(tGravityAcc.std...X), 2),
      tGravityAcc.std...Y = round(mean(tGravityAcc.std...Y), 2),
      tGravityAcc.std...Z = round(mean(tGravityAcc.std...Z), 2),
      
      tBodyAccJerk.std...X = round(mean(tBodyAccJerk.std...X), 2),
      tBodyAccJerk.std...Y = round(mean(tBodyAccJerk.std...Y), 2),
      tBodyAccJerk.std...Z = round(mean(tBodyAccJerk.std...Z), 2),
      
      tBodyGyro.std...X = round(mean(tBodyGyro.std...X), 2),
      tBodyGyro.std...Y = round(mean(tBodyGyro.std...Y), 2),
      tBodyGyro.std...Z = round(mean(tBodyGyro.std...Z), 2),
      
      tBodyGyroJerk.std...X = round(mean(tBodyGyroJerk.std...X), 2),
      tBodyGyroJerk.std...Y = round(mean(tBodyGyroJerk.std...Y), 2),
      tBodyGyroJerk.std...Z = round(mean(tBodyGyroJerk.std...Z), 2),
      
      tBodyAccMag.std.. = round(mean(tBodyAccMag.std..), 2),
      tGravityAccMag.std.. = round(mean(tGravityAccMag.std..), 2),
      tBodyAccJerkMag.std.. = round(mean(tBodyAccJerkMag.std..), 2),

      tBodyGyroMag.std.. = round(mean(tBodyGyroMag.std..), 2),
      tBodyGyroJerkMag.std.. = round(mean(tBodyGyroJerkMag.std..), 2),

      fBodyAcc.std...X = round(mean(fBodyAcc.std...X), 2),
      fBodyAcc.std...Y = round(mean(fBodyAcc.std...Y), 2),
      fBodyAcc.std...Z = round(mean(fBodyAcc.std...Z), 2),
      
      fBodyAccJerk.std...X = round(mean(fBodyAccJerk.std...X), 2),
      fBodyAccJerk.std...Y = round(mean(fBodyAccJerk.std...Y), 2),
      fBodyAccJerk.std...Z = round(mean(fBodyAccJerk.std...Z), 2),

      fBodyGyro.std...X = round(mean(fBodyGyro.std...X), 2),
      fBodyGyro.std...Y = round(mean(fBodyGyro.std...Y), 2),
      fBodyGyro.std...Z = round(mean(fBodyGyro.std...Z), 2),
 
      fBodyAccMag.std.. = round(mean(fBodyAccMag.std..), 2),
      fBodyBodyAccJerkMag.std.. = round(mean(fBodyBodyAccJerkMag.std..), 2),
      fBodyBodyGyroMag.std.. = round(mean(fBodyBodyGyroMag.std..), 2),
      fBodyBodyGyroJerkMag.std.. = round(mean(fBodyBodyGyroJerkMag.std..), 2)
      
      )

#write to a file
write.table(tidydata, file="./tidydata.txt", row.names = FALSE)
#write.csv(...)




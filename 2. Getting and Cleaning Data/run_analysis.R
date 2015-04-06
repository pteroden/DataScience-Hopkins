library(data.table)

#Loading & merging data in X, Y, S groups
x_train <- read.table("./train/X_train.txt")
x_test <- read.table("./test/X_test.txt")
X <- rbind(x_train, x_test)

y_train <- read.table("./train/Y_train.txt")
y_test <- read.table("./test/Y_test.txt")
Y <- rbind(y_train, y_test)

sub_train <- read.table("./train/subject_train.txt")
sub_test <- read.table("./test/subject_test.txt")
S <- rbind(sub_train, sub_test)

rm(x_train, x_test, y_train, y_test, sub_train, sub_test)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
names <- read.table("features.txt")
good_names <- grep("-mean\\(\\)|-std\\(\\)", names[, 2])
X <- X[, good_names]

# Uses descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")
activities[, 2] <- tolower(activities[, 2])
activities[, 2] <- gsub("_", " ", tolower(activities[, 2]))

Y[,1] = activities[Y[,1], 2]

#Merges the S, Y, X - groups in one.
all_data <- cbind(S, Y, X)

#Appropriately labels the data set with descriptive variable names. 
names <- names[good_names, 2]
names <- tolower(gsub("\\(\\)", "", names))
names(all_data) <- c("subject", "activity", names)
write.table(result, "merged_data.txt")

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
NumSub = length((unique(all_data$subject)))
NumAct = length((unique(all_data$activity)))
NumCol = dim(all_data)[2]
result = all_data[1:(NumSub*NumAct), ]

row = 1
for(s in 1:NumSub){
      for(a in 1:NumAct){
            temp <- all_data[(all_data$subject == s & all_data$activity == activities[a, 2]), ]
            result[row, 1] <- as.numeric(s)
            result[row, 2] <- activities[a, 2]
            result[row, 3:NumCol] <- colMeans(temp[, 3:NumCol])
            row = row + 1
      }
}

# Exporting 2nd data set to .txt file
write.table(result, "mean_activity_subject.txt", row.name = F)
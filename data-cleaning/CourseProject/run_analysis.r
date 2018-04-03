# 1. Import relevant libraries
library(plyr)
library(dplyr)
library(reshape2)

# 2. Download and extract data
if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists("data/course_project_files.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                 "data/course_project_files.zip")
}
unzip("data/course_project_files.zip", exdir="data")

# 2. Merge the training and test sets
# 3. / 2a. Extract only the mean and standard deviation for each measurement
# Now, the project description asks to extract only the mean and standard deviation *after* merging the dataset.
# However, the mean and standard deviation are a small subset of the overall data, so to minimise the machine
# workload, we'll read only them in, taking advantage of "read.fwf"'s column skipping functionality.

# Read in in the features list and find those with mean or standard columns
features <- readLines("data/UCI HAR Dataset/features.txt")
features <- sapply(features, function(x) { strsplit(x, " ")[[1]][[2]]})
meanandstd <- grepl(features, pattern = "(mean\\(\\)|std\\(\\))")

# If there is "mean"/"std", column width is +16 (i.e. read it in); otherwise -16 (i.e. skip it)
colwidths <- sapply(X = meanandstd, FUN = function(x) { ifelse(x, 16, -16)})
colnames <- features[meanandstd]

# Read in training data
x.training <- read.fwf("data/UCI HAR Dataset//train/X_train.txt", widths=colwidths, n = -1, col.names = colnames)
y.training <- readLines("data/UCI HAR Dataset/train/y_train.txt")
subject.training <- readLines("data/UCI HAR Dataset/train/subject_train.txt")

# Merge training data to form a single data.frame
training <- cbind(x.training, y.training, subject.training)

# Rename subject and activity to allow for merging with test data set
training <- training %>% rename(activity = y.training, subject = subject.training)

# Read in testing data
x.test <- read.fwf("data/UCI HAR Dataset/test/X_test.txt", widths=colwidths, n = -1, col.names = colnames)
y.test <- readLines("data/UCI HAR Dataset/test/y_test.txt")
subject.test <- readLines("data/UCI HAR Dataset/test/subject_test.txt")

# Merge testing data to form a single data.frame
test <- cbind(x.test, y.test, subject.test)

# Rename subject and activity to allow for merging with training data set
test <- test %>% rename(activity = y.test, subject = subject.test)

# Generate the total data set
total.data <- merge(training, test, all = TRUE)

# 4. Use descriptive activity names to name the activities in the data set
total.data$activity <- revalue(x = total.data$activity, 
                             c("1" = "walking", "2" = "walkingupstairs", "3" = "walkingdownstairs", 
                               "4" = "sitting", "5" = "standing", "6" = "laying"))

# 5. Appropriately label the data set with descriptive variable names
# The naming principles used are detailed in the code book and readme. 
# The comments below detail what each step is accomplishing.
col.names <- names(total.data)
new.col.names <- sub("BodyBody", "Body", col.names)  # Replace typo
new.col.names <- gsub("([A-Z])", "\\.\\1", new.col.names)  # Insert a period before capitals
new.col.names <- gsub("(mean)(.*)", "\\2.mean", new.col.names)  # Remove 'mean' and put it at end of line
new.col.names <- gsub("(std)(.*)", "\\2.std", new.col.names)  # Remove 'std' and put it at end of line
new.col.names <- gsub("(\\.+)", "\\.", new.col.names)  # Remove multiple periods and replace them with just one
new.col.names <- gsub("(^t)", "time", new.col.names)  # Replace "t" at start of line with "time"
new.col.names <- gsub("(^f)", "frequency", new.col.names)  # Replace "f" at start of line with "frequency"
new.col.names <- gsub("(Acc)", "acceleration", new.col.names)  # Replace "Acc" with "acceleration"
new.col.names <- tolower(new.col.names)  # Make all names lower case

# Apply revised names
names(total.data) <- new.col.names

# 6. Create a second, independent tidy data set with the average of each variable for each activity and each subject
melted.data <- melt(total.data, id=c("subject", "activity"))
tidy.data <- dcast(melted.data, activity + subject ~ variable, mean)

# 7. Write to file.
write.csv(total.data, "totaldata.csv")
write.csv(tidy.data, "tidydata.csv")
write.table(tidy.data, "tidydata.txt", row.name=FALSE)
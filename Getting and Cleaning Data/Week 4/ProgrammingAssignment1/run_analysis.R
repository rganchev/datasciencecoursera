## Remember the current working directory so we can restore it later
wd <- getwd()
setwd(dirname(parent.frame(2)$ofile))

source("read_features.R")
source("read_activities.R")
source("read_dataset.R")

## Read the raw data
data_dir <- "UCI HAR Dataset"

features <- read_features(data_dir)
activities <- read_activities(data_dir)

train <- read_dataset(data_dir, "train", features, activities)
test <- read_dataset(data_dir, "test", features, activities)

## Merge the "train" and "test" datasets
data <- rbind(train, test)

## Calculate the average values of each data column for each (Activity, Subject)
## pair in the data above. Write the result to a file.
means <- aggregate(. ~ Subject + Activity, data, mean)
write.table(means, "means.txt", row.names = FALSE)

## Restore the current working directory
setwd(wd)

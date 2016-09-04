## Reads one of the "train" or "test" parts of the UCI HAR Dataset, depending
## on the value of the 'dataset_name' argument.
read_dataset <- function(data_dir, dataset_name, features, activities) {
    get_file_name <- function(data_prefix) {
        paste0(data_prefix, "_", dataset_name, ".txt")
    }
    
    ## Read the "Subject" column
    file <- file.path(data_dir, dataset_name, get_file_name("subject"))
    subject <- read.table(file, col.names = "Subject")
    
    ## Read the "Activity" column
    file <- file.path(data_dir, dataset_name, get_file_name("y"))
    activity <- read.table(file, col.names = "Activity")
    activity$Activity <- factor(activity$Activity,
                                levels = activities$level,
                                labels = activities$label)
    
    ## Read the rest of the measurements
    file <- file.path(data_dir, dataset_name, get_file_name("X"))
    measurements <- read.table(file,
                               colClasses = features$class,
                               col.names = features$label,
                               check.names = FALSE)
    
    cbind(subject, activity, measurements)
}

source("humanize.R")

## Reads the list of features from the UCI HAR Dataset. This method adds the
## 'class' field to each feature. If the feature is a mean or standard deviation
## the value of the 'class' field is "numeric", otherwise it is "NULL".
read_features <- function(data_dir) {
    features <- read.table(file.path(data_dir, "features.txt"),
                           col.names = c("id", "label"))
    
    features$class <- sapply(features$label, function(label) {
        is_mean_or_std <- length(grep("(mean|std)\\(\\)", label)) > 0
        if (is_mean_or_std) "numeric" else "NULL"
    })
    
    features$label <- humanize(features$label, replacements = c(
        T = "",
        Acc = "Acceleration",
        Mag = "Magnitude",
        F = "FFT of",
        Std = "(STD)",
        Mean = "(Mean)"
    ))
    
    features
}

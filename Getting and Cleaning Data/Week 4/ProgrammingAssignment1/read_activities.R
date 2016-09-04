source("humanize.R")

## Reads the list of activities from the UCI HAR Dataset. The activity names
## are 'humanize'd
read_activities <- function(data_dir) {
    activities <- read.table(file.path(data_dir, "activity_labels.txt"),
                             col.names = c("level", "label"))
    activities$label <- humanize(activities$label)
    
    activities
}

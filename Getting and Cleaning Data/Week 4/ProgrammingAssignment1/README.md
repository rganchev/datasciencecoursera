## Programming Assignment

This repo contains the solution to the programming assignment in Week 4 of the course
Getting and Cleaning Data from the Data Science specialization in Coursera.

### Running the script

To run the data analysis script, you need to checkout this repo and execute the following command in
R or Rstudio:

```
source("path/to/repo/run_analysis.R")
```

The script produces the file *means.txt*. Please refer to the CodeBook for further information
about the file's contents.

### Reading the output

To read the produced output file, use the following command in R or Rstudio:

```
means <- read.table("path/to/repo/means.txt", check.names = FALSE)
```

### Code structure

*run_analysis.R* makes use of the follwing helper scripts:

 * *read_features.R* - Reads the file _features.txt_ from the UCI HAR Dataset. Also, renames the
 features to transform them in a more human-readable format and adds class indicators to signify
 which features represent a _mean_ or _standard deviation_ measurement.

 * *read_activities.R* - Reads the file _activity\_labels.txt_ from the UCI HAR Dataset and
 transforms all activity labels to a more human-friendly format.

 * *humanize.R* - Contains a helper function used by the above two scripts to transform various
 strings to a human-readable format.

 * *read_dataset.R* - Reads either the "train" or the "test" dataset, ignoring all features marked
 as irrelevant by _read\_features_ and assigning the human-readable activity names construced by
 _read\_activities_.

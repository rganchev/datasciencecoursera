## Code Book

This document describes the structure of the "Means" dataset as well as the transformations that
were performed to construct it.

The "Means" dataset constains summary data for the "UCI HAR Dataset". It consists of the average
values for all _mean_ and _standard deviation_ measurements grouped by all possitble pairs of
*Subject* and *Activity*. Please refer to the UCI HAR Dataset feature descirption document
(the **features.txt** file) for further information on each separate measurement.

### Transformations

The following transformations were applied when constructing the "Means" dataset:

 * The "test" and "train" datasets were constructed by reading and merging together the
 corresponding **X_*.txt**, **y_*.txt** and **subject_*.txt** files.

 * From the **X_*.txt** files, only _mean_ and _standard deviation_ measurements were included, the
 rest were ignored.

 * The activity codes were replace with human-readable strings.

 * All columns headers were renamed to be more human-friendly.

 * The "test" and "train" datasets were merged together in a single dataset containing all observations.

 * An aggregation operation was applied to calculate the average value of each feature for each
 **Subject** and each **Activity**.

### Feature description

<dl>
	<dt>Subject</dt>
	<dd>The identification number of the subject who performed the activity. A number between 1 and 30.</dd>

	<dt>Activity</dt>
	<dd>The activity that was performed. One of "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing" or "Laying"

	<dt>[FFT of ]&lt;measurement&gt; (&lt;aggregation&gt;) [&lt;axis&gt;]</dt>
	<dd>The average value of the corresponding aggregated measurement. For more information about included measurements, please see the file <b>features.txt</b> from the UCI HAR Datset.<br />
	Example: "FFT of Body Acceleration (STD) Y" contains the average value of the standard deviation
	of the Fast Fourier Transform performed on Body Acceleration on the Y axis.</dd>
</dl>

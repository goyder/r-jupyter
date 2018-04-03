# Codebook

## Requirement as per marking guide
> GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

## Data outputs
`run_analysis.r` has two main data.frame outputs: 
* `total.data`, a merged and renamed combination of the training and test data;
* `tidy.data`, a tidied and summarised dataset containing averages of `total.data` by subject and activity.

The following variable names are common to both data.frames.

## Variable Descriptions

### Feature selection

From original feature guide:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
> 
> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

### Modification

#### Principles

The variables names were modified under the following naming principles:
* `mean()` and `std()` to be replaced with `mean` and `std` at end of feature name.
* Feature names to be separated by periods, as suggested by [Google R Style Guide](https://google.github.io/styleguide/Rguide.xml). This aids readability in long, feature names with sub-divisions.
* Replace `t` with `time`.
* Replace `f` with `frequency`.
* All features to be lowercase.
* Eliminate any multiple periods.

#### Feature names

The resulting feature are produced from applying the above modifications:

* `time.body.acceleration.XYZ`
* `time.gravity.Acc.XYZ`
* `time.body.acceleration.jerk.XYZ`
* `time.body.gyro.XYZ`
* `time.body.gyro.jerk.XYZ`
* `time.body.acceleration.mag`
* `time.gravity.acceleration.mag`
* `time.body.acceleration.jerk.mag`
* `time.body.gyro.mag`
* `time.body.gyro.jerk.mag`
* `frequency.body.acceleration.XYZ`
* `frequency.body.acceleration.jerk.XYZ`
* `frequency.body.gyro.XYZ`
* `frequency.body.acceleration.mag`
* `frequency.body.acceleration.jerk.mag`
* `frequency.body.gyro.mag`
* `frequency.body.gyro.jerk.mag`

These are then appended by `.mean` or `.std` as per feature adjustments.

`activity` lists which activity is being undertaken and is one of the following variables:
* walking
* walkingupstairs
* walkingdownstairs
* sitting
* standing
* laying

`subject` indexes each data point by the subject of the study.

#### Units

As no units are provided in the original data set, no units are available here.
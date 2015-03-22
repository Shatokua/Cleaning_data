Script is provided for cleaning row data from "Human Activity Recognition Using Smartphones Dataset"
Originally data set consists from the single files that contain results of the experiments. 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. 
Data contains numbers for 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

Using a provided script it is possible to unzip and read files, combine numeric data to one data set, 
where all the observations are organized according main variables. At the end you get the calculations of
average meanings for every variable for each participant (variable "Subject") for each activity (variable 
"Activity"). All the variables and activities are labeled with descriptive names.

For using script you should have packages reshape2 and dplyr installed.
Otherwise use install.packages("reshape2"), install.packages("dplyr") before running the script.
You also should have archive "course_proj_data.zip" in your working directory.

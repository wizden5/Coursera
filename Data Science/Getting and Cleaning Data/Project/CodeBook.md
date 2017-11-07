#Samsung Data Wrangling

## 1. Variables
* The *samsung* dataset consists of 561 measures on 30 subjects in 6 different states (walking, sitting etc.). The 561 measures such as mean, standard deviation, maximum value are normalized and stated as integers in [-1,1] interval.

* *features* is a character vector consisting of 561 measure names, such as "tBodyAcc-mean()-X" used as column names for the main data set.

* *act_labels* is a character vector with 6 activity names ("WALKING", "WALKING UPSTAIRS, "WALKING DOWNSTAIRS", "SITTING, "STANDING", "LAYING")

* *id* is an integer vector with subject identifiers

* *activity* is an integer factor with activities coded as numbers (1-6)


## 2. Operations

1. Reading the text files with **read.table** 
2. Merging test and train set with **rbind** 
3. Removing partial files with **rm**
4. Setting features vector as column names in data set using **as.character** and **colnames**
5. Selecting columns with means and standard deviation values with **grepl**
6. Linking activity (numerical ids) with activity labels using **as.character** and **factor**
7. Adding ID and activities vector to initial dataset with **data.frame**
8. Sorting dataset with **dplyr:::arrange**
9. Extracting additional dataset with **dplyr:::group_by** and **dplyr:::summarise_each**
10. Saving dataset with **write.table**







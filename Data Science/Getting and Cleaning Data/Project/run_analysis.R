#LOADING ALL THE NEEDED FILES

#dataset components
samsung_test <- read.table("X_test.txt", sep = "")
samsung_train <- read.table("X_train.txt", sep = "")

#561-features vector
features <- read.table("features.txt", sep = "")

#activity character labels
act_labels <- read.table("activity_labels.txt", sep = "")

#ids
id_test <- read.table("subject_test.txt", sep = "")
id_train <- read.table("subject_train.txt", sep = "")

#activity numeric ids
act_test <- read.table("y_test.txt", sep = "")
act_train <- read.table("y_train.txt", sep = "")


#1. MERGE TRAINING SET AND TEST SET
#merge to one dataset
samsung <- rbind(samsung_test, samsung_train)

#remove partials
rm(samsung_test, samsung_train)


#2. EXTRACT MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

#adding names to columns using feature.txt
features <- as.character(features[,2])
colnames(samsung) <- features

#selecting desired columns
samsung <- samsung[, grepl("mean|std", colnames(samsung))]


#3 & 4. USING DESCRIPTIVE VARIABLE NAMES
#colnames were applied in step 2.

#merge ids and activity numerical ids
activity <- rbind(act_test, act_train)
id <- rbind(id_test, id_train)


#remove partials
rm(act_test, act_train, id_test, id_train)

#extracty id from dt and change it to numeric
id <- as.numeric(id[,1])

#extract activity names from dt and change it to character
act_labels <- as.character(act_labels[,2])

#name activity vector and transform it to factor
activity <- factor(activity[, 1], labels = act_labels)

#create final data frame
samsung <- data.frame(ID = id, activity = activity, samsung)

#sort according to id and activity using dplyr package
library(dplyr)
samsung <- arrange(samsung, ID, desc(activity))


#5. CREATE GROUPED DATA SET WITH AVERAGES
samsung2<- samsung %>%
            group_by(ID, activity) %>%
            summarise_all(funs(mean))

#SAVE DATASET
write.table(samsung2, file = "samsung_averages.txt", row.names = FALSE)
            

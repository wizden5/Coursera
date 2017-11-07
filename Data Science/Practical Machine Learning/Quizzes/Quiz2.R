# 1.
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
library(AppliedPredictiveModeling)
adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

# 2.
library(ggplot2)
library(Hmisc)
training$index <- inTrain
training$FlyAsh <- cut2(training$FlyAsh)
ggplot(data = training) + geom_jitter(aes(x = index, y = CompressiveStrength, col = FlyAsh)) 


# 3.
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

ggplot(data = training) + geom_histogram(aes(x = Superplasticizer))

training$trans <- log(training$Superplasticizer + 1)


# 4. 
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

training2 <- select(training, starts_with("IL"))
pca2 <- preProcess(training2, method = "pca", thresh = 0.9)
training2_pca <- predict(obj = pca2, training2)

# 5. 
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]


training_pred <- select(training, starts_with("IL"))
training_pred$diagnosis <- training$diagnosis

mod_ord <- train(diagnosis ~ ., data = training_pred, method = 'glm')
confusionMatrix(predict(mod_ord, newdata = testing), testing$diagnosis)

obj <- preProcess(training_pred, method = "pca", thresh = 0.8)
training_pred_pca <- predict(training_pred, obj = obj)
training_pred_pca$diagnosis <- training$diagnosis
mod_pca <- train(diagnosis ~ ., data = training_pred_pca, method = "glm")

testing_pca <- select(testing, starts_with("IL"))
testing_pca <- predict(testing_pca, obj = obj)
confusionMatrix(predict(mod_pca, newdata = testing), testing_pca$diagnosis)


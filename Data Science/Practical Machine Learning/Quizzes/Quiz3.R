library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)


#Q1
set.seed(125)
inTrain <- createDataPartition(y=segmentationOriginal$Case,p=0.6, list=FALSE)
training <- segmentationOriginal[inTrain,]
testing <- segmentationOriginal[-inTrain,]

modFit <- train(Case ~ .,method="rpart",data=training) 
print(modFit$finalModel)

suppressMessages(library(rattle))
library(rpart.plot)
fancyRpartPlot(modFit$finalModel)



#Q3
library(pgmm)
data(olive)
olive = olive[,-1]

newdata = as.data.frame(t(colMeans(olive)))

modolive <- train(Area ~ ., method = "rpart", data = olive)
predict(modolive, newdata = newdata)


#Q4
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
missClass = function(values, prediction){sum(((prediction > 0.5) * 1) != values) / length(values)}

set.seed(13234)
modelSA <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, 
                 data = trainSA, method = "glm", family = "binomial")
missClass(testSA$chd, predict(modelSA, newdata = testSA))
missClass(trainSA$chd, predict(modelSA, newdata = trainSA))


#Q5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)
set.seed(33833)
library(randomForest)

modvowel <- randomForest(y ~ ., data = vowel.train)
order(varImp(modvowel), decreasing = T)

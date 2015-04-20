#### LOADING DATA
dataTrain <- read.csv("data/pml-training.csv", na.strings = c("", "NA", "#DIV/0!"))
dataTest <- read.csv("data/pml-testing.csv", na.strings = c("", "NA", "#DIV/0!"))

summary(dataTrain)
summary(dataTest)

#### CLEANING DATA
# belt|arm|dumbbell|classe
names(dataTrain)
BeltArmDumbell <- grepl(pattern = "belt|arm|dumbbell|classe", x = names(dataTrain))
accTrain <- dataTrain[, BeltArmDumbell]
accTest <- dataTest[, BeltArmDumbell]

# Removing variables with NA's
NAs <- rep(NA, length(names(accTrain))-1)
for(i in 1:length(NAs)){
      NAs[i] <- ifelse(sum(is.na(accTrain[, i])) != 0, TRUE, FALSE)
}

accTrain.na <- accTrain[, !NAs]
accTest.na <- accTest[, !NAs]

summary(accTrain.na)

# Removing variables with near zero variance
library(caret)

nzv.train <- nearZeroVar(x = accTrain.na, freqCut = 80/20, uniqueCut = 10, saveMetrics = TRUE, 
                         foreach = FALSE, allowParallel = TRUE)
accTrain.na.nzv <- accTrain.na[, !nzv.train[, "nzv"]]
accTest.na.nzv <- accTest.na[, !nzv.train[, "nzv"]]

# Partitioning data
inTrain <- createDataPartition(y = accTrain.na.nzv$classe, p = 0.7, list = FALSE)

train <- accTrain.na.nzv[inTrain, ]
test <- accTrain.na.nzv[-inTrain, ]
validate <- accTest.na.nzv

# Removing unneeded sets
rm(dataTrain, dataTest, BeltArmDumbell, accTrain, accTest, NAs, i, accTrain.na, 
   accTest.na, nzv.train, accTrain.na.nzv, accTest.na.nzv, inTrain)

### CREATING MODEL
# Parallel computing + Model Creation

library(doParallel)
library(randomForest)
registerDoParallel(cores=detectCores()-1)
system.time(RF <- foreach(ntree=rep(250, 4), .combine=combine, .packages='randomForest') %dopar%
                  randomForest(classe ~ ., ntree = ntree, data = train))

# Assesing model
predRF <- predict(RF, test)
confusionMatrix(test$classe, predRF)

# Prediction on validate dataset
predRF.validate <- predict(RF, validate)

# Creating answers for COURSERA
pml_write_files = function(x){
      n = length(x)
      for(i in 1:n){
            filename = paste0("problem_id_", i, ".txt")
            write.table(x[i], file=filename, quote=FALSE, row.names=FALSE, col.names=FALSE)
      }
}

pml_write_files(predRF.validate)

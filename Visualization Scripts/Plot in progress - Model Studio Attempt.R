# import da libraries
library(tidyverse)
library(ranger)
library(modelStudio)
library(DALEX)
library(DALEXtra)
library(mlr)


# Load Data
setwd("~/Data Viz in R/Data-Visualization-Final-Project/Data Files for Analysis")
df <- read_csv("Residential_Solar_Zip.csv")

index <- sample(1:nrow(df), 0.7*nrow(df))
train <- df[index,]
test <- df[-index,]

# fit a model
task <- makeRegrTask(id = "zip code", data = train, target = "Adoption_Rate")
learner <- makeLearner("regr.ranger", predict.type = "response")
model <- train(learner, task)

# create an explainer for the model    
explainer <- explain_mlr(model,
                         data = test,
                         y = test$Adoption_Rate,
                         label = "mlr")

new_observations <- test[1:2,]
#rownames(new_observation) <- c("id1", "id2")

# make a studio for the model
modelStudio(explainer, new_observations)


data <- DALEX::apartments

# split the data
index <- sample(1:nrow(data), 0.7*nrow(data))
train <- data[index,]
test <- data[-index,]

# fit a model
task <- makeRegrTask(id = "apartments", data = train, target = "m2.price")
learner <- makeLearner("regr.ranger", predict.type = "response")
model <- train(learner, task)

# create an explainer for the model
explainer <- explain_mlr(model,
                         data = test,
                         y = test$m2.price,
                         label = "mlr")

# pick observations
new_observation <- test[1:2,]
rownames(new_observation) <- c("id1", "id2")

# make a studio for the model
modelStudio(explainer, new_observation)
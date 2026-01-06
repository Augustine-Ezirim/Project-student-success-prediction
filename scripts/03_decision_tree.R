rm(list = ls())

suppressPackageStartupMessages({
  library(caret)
  library(pROC)
  library(rpart)
  library(rattle)
  library(RColorBrewer)
})

load("outputs/analysis_objects.RData")

train <- tree_data[train_idx, ]
test  <- tree_data[-train_idx, ]

# Fit tree on TRAIN
tree.student <- rpart(pass ~ ., data = train, method = "class", cp = 0)
fancyRpartPlot(tree.student)

tree.student$cptable

cp.opt <- tree.student$cptable[which.min(tree.student$cptable[, "xerror"]), "CP"]
pruned.tree.student <- prune(tree.student, cp = cp.opt)
fancyRpartPlot(pruned.tree.student)

predClass <- predict(pruned.tree.student, newdata = test, type = "class")
confusionMatrix(predClass, test$pass, positive = "1")

predProb <- predict(pruned.tree.student, newdata = test, type = "prob")[, 2]
roc_obj <- roc(response = test$pass, predictor = predProb)
plot(roc_obj, main = "ROC Curve: Decision Tree")
auc(roc_obj)

summary(pruned.tree.student)

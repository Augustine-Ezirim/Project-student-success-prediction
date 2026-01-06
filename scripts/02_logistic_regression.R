rm(list = ls())

suppressPackageStartupMessages({
  library(caret)
  library(pROC)
  library(car) 
})

load("outputs/analysis_objects.RData")

train <- df[train_idx, ]
test  <- df[-train_idx, ]

outglm_simple <- glm(pass ~ failures + goout + Walc + famsup + G1 + G2,
                     data = train, family = binomial())

summary(outglm_simple)

test$prob_simple <- predict(outglm_simple, newdata = test, type = "response")
test$pred_simple <- factor(ifelse(test$prob_simple >= 0.5, 1, 0), levels = c(0, 1))

confusionMatrix(test$pred_simple, test$pass, positive = "1")

roc_simple <- roc(response = test$pass, predictor = test$prob_simple)
plot(roc_simple, main = "ROC Curve: Logistic Regression")
auc(roc_simple)

vif(outglm_simple)

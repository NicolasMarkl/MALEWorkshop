library(tidyverse)
library(e1071)
library(class)
library(caret)


head(iris)
x = iris[,-5]
y = iris[,5]


pp = preProcess(iris, method = c("center", "scale"))
pp$mean
pp$std

x_scaled = predict(pp, x)

knn_model = gknn(Species ~ ., data = iris)
knn_model


saveRDS(knn_model, "mtcars_knn_model.RDS")
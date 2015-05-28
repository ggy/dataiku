census_income_test <- read.table("~/Data/dataiku/census_income_test.csv", sep=";", quote="\"")

data = census_income_test[1:1000,]

library('ggplot2')
summary(data)


GLM.1 <- glm(V42 ~ V41 +V40 +V39 +V38 +V37 +V36 +V35 +V34 +V33 +V32 +V31 +V30 +V29 +V28 +V27 +V26 
             +V25 +V24 +V23 +V22 +V21 +V20 +V19 +V18 +V17 +V16 +V15 +V14 +V13 +V12 +V11 +V10 +V9 +V8 +V7 +V6 +V5 
             +V4 +V3 +V2 +V1, family=binomial(logit), data=data)
summary(GLM.1)


HClust.2 <- hclust(dist(model.matrix(~-1 + 
                                       V1+V3+V4+V6+V17+V18+V19+V25+V31+V37+V39+V40+V41, data)) , method= "ward")
plot(HClust.2, main= "Cluster Dendrogram for Solution HClust.2", xlab= 
       "Observation Number in Data Set data", 
     sub="Method=ward; Distance=euclidian")

library("e1071", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.1")
model <- svm(V42 ~ V41 +V40 +V39 +V38 +V37 +V36 +V35 +V34 +V33 +V32 +V31 +V30 +V29 +V28 +V27 +V26 
             +V25 +V24 +V23 +V22 +V21 +V20 +V19 +V18 +V17 +V16 +V15 +V14 +V13 +V12 +V11 +V10 +V9 +V8 +V7 +V6 +V5 
             +V4 +V3 +V2 +V1, data, type = "C-classification", kernel = "polynomial", degree = 2, gamma = 2, cost = 0.5, coef0 = 0)
model$fitted
table(model$fitted, data$V42)

require(rpart)
require(mlbench)
require(party)

data = census_income_test[1:10000,]
newdata = census_income_test[10001:20000,]

formule = V42 ~ (V41 +V40 +V39 +V38 +V37 +V36 +V35 +V34 +V33 +V32 +V31 +V30 +V29 +V28 +V27 +V26 
+V25 +V24 +V23 +V22 +V21 +V20 +V19 +V18 +V17 +V16 +V15 +V14 +V13 +V12 +V11 +V10 +V9 +V8 +V7 +V6 +V5 
+V4 +V3 +V2 +V1)


# rpart
x.rp <- rpart(formule, data=data)
x.rp.pred <- predict(x.rp, type="class", newdata=newdata)
x.rp.prob <- predict(x.rp, type="prob", newdata=newdata)

require(party)
x.cf <- cforest(formule, data=data, control = cforest_unbiased(mtry = ncol(data)-2))
x.cf.pred <- predict(x.cf, newdata=newdata)
x.cf.prob <-  1- unlist(treeresponse(x.cf, newdata), use.names=F)[seq(1,nrow(newdata)*2,2)]


# Bagging
require(ipred)
x.ip <- bagging(formule, data=data)
x.ip.prob <- predict(x.ip, type="prob", newdata=data)

# SVM
require(e1071)
# svm requires tuning
x.svm.tune <- tune(svm, formule, data = data,
                   ranges = list(gamma = 2^(-8:1), cost = 2^(0:4)),
                   tunecontrol = tune.control(sampling = "fix"))

x.svm.tune

x.svm <- svm(formule, data = data, cost=4, gamma=0.0625, probability = TRUE)
x.svm.prob <- predict(x.svm, type="prob", newdata=newdata, probability = TRUE)





# ROCR
require(ROCR)

# rpart
x.rp.prob.rocr <- prediction(x.rp.prob[,2], newdata$V42)
x.rp.perf <- performance(x.rp.prob.rocr, "tpr","fpr")
plot(x.rp.perf, col=2)

# legend.
legend(0.6, 0.6, c('rpart','bagging','svm'), 2:4)


# bagging
x.ip.prob.rocr <- prediction(x.ip.prob[,2], newdata$V42)
x.ip.perf <- performance(x.ip.prob.rocr, "tpr","fpr")
plot(x.ip.perf, col=5, add=TRUE)

# svm
x.svm.prob.rocr <- prediction(attr(x.svm.prob, "probabilities")[,2], newdata$V42)
x.svm.perf <- performance(x.svm.prob.rocr, "tpr","fpr")
plot(x.svm.perf, col=6, add=TRUE)




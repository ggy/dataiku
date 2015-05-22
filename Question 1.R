census_income_learn <- read.table("~/Data/dataiku/census_income_learn.csv", sep=";", quote="\"")

library('ggplot2')
Age = census_income_learn$V1
qplot(Age)

summary(census_income_learn)

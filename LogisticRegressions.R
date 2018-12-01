#Install required pacakges for analyses
install.packages("car"); install.packages("compute.es"); install.packages("ggplot2"); install.packages("multcomp"); install.packages("pastecs"); install.packages("mlogit"); install.packages("nlme"); 
install.packages("reshape"); install.packages("effects"); install.packages("lm.beta")

#Load required packages
library(car); library(compute.es); library(ggplot2); library(multcomp); library(pastecs); library(mlogit); library(nlme); library(reshape); library(effects); library(lm.beta)


#Inpute data into R 
Brett_data <- read.csv("https://raw.githubusercontent.com/jshutay/CourseExamples/master/VideoGameData.csv",
                       header = TRUE,
                       sep = ",")


#Logistic Regression Example
LogisticModel<-glm(Advertising ~ Visits + VisitTime, data = Brett_data, family = binomial())
LogisticModel
summary(LogisticModel)
#Install required pacakges for analyses
install.packages("car"); install.packages("compute.es"); install.packages("ggplot2"); install.packages("multcomp"); install.packages("pastecs"); install.packages("mlogit"); install.packages("nlme"); 
install.packages("reshape"); install.packages("effects"); install.packages("lm.beta")

#Load required packages
library(car); library(compute.es); library(ggplot2); library(multcomp); library(pastecs); library(mlogit); library(nlme); library(reshape); library(effects); library(lm.beta)


#Inpute data into R 
ExperimentalData <- read.csv("https://raw.githubusercontent.com/jshutay/CourseExamples/master/TIM6520Dataset.csv",
                       header = TRUE,
                       sep = ",")


#Logistic Regression Example
#Note: if you want to use the advertising variable as a predictor, you would need to create dummy variables since there are three levels.
LogisticModel<-glm(Game ~ Visits + VisitTime, data = ExperimentalData, family = binomial())
LogisticModel
summary(LogisticModel)
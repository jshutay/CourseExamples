#Install required pacakges for analyses
install.packages("car"); install.packages("compute.es"); install.packages("ggplot2"); install.packages("multcomp"); install.packages("pastecs"); install.packages("mlogit"); install.packages("nlme"); 
install.packages("reshape"); install.packages("effects"); install.packages("lm.beta")

#Load required packages
library(car); library(compute.es); library(ggplot2); library(multcomp); library(pastecs); library(mlogit); library(nlme); library(reshape); library(effects); library(lm.beta)


#Inpute data into R 
ExperimentalData <- read.csv("https://raw.githubusercontent.com/jshutay/CourseExamples/master/TIM6520Dataset.csv",
                       header = TRUE,
                       sep = ",")


#Simple Linear Regression Examples

#Regression analysis
VisitRegression <- lm(VisitTime ~ Visits, data=ExperimentalData)
TotalRegression <- lm(VisitTime ~ TotalTime, data=ExperimentalData)

#Get standardized beta weights
lm.beta(VisitRegression)
lm.beta(TotalRegression)

#Compare models
anova(VisitRegression, TotalRegression)

#Compute residuals
resid(VisitRegression)
rstandard(TotalRegression)

#Appending diagnostics to dataset
ExperimentalData$residuals<-resid(VisitRegression)
ExperimentalData$standardized.residuals<-rstandard(TotalRegression)

#Write dataset to csv file - you will need to set your work directory to where you want this file outputted
write.table(ExperimentalData, "Data with Diagnostics.csv", sep = "\t", row.names = FALSE)

#Generate Predicted values by Standardized Residual Scatter Plot to test assumptions
scatter <- ggplot(ExperimentalData, aes(VisitRegression$fitted.values, standardized.residuals))
  scatter + geom_point() + geom_smooth(method = "lm", colour = "Blue") + labs (x = "Visit time", y = "Standardized Residuals")


#Multiple Linear Regression Examples

#Regression analysis
#Note: if you want to use the advertising variable as a predictor, you would need to create dummy variables since there are three levels.
VisitRegression <- lm(VisitTime ~ Visits, data=ExperimentalData)
TotalRegression <- lm(VisitTime ~ Visits + Game, data=ExperimentalData)
  
#Get standardized beta weights
lm.beta(VisitRegression)
lm.beta(TotalRegression)
  
#Compare models
anova(VisitRegression, TotalRegression)
  
#Compute residuals
resid(VisitRegression)
rstandard(TotalRegression)
  
#Appending diagnostics to dataset
ExperimentalData$residuals<-resid(VisitRegression)
ExperimentalData$standardized.residuals<-rstandard(TotalRegression)
  
#Write dataset to csv file - - you will need to set your work directory to where you want this file outputted
write.table(ExperimentalData, "Data with Diagnostics.csv", sep = "\t", row.names = FALSE)
  
#Generate Predicted values by Standardized Residual Scatter Plot to test assumptions
scatter <- ggplot(ExperimentalData, aes(VisitRegression$fitted.values, standardized.residuals))
scatter + geom_point() + geom_smooth(method = "lm", colour = "Blue") + labs (x = "Visit time", y = "Standardized Residuals")
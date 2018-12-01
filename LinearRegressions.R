#Install required pacakges for analyses
install.packages("car"); install.packages("compute.es"); install.packages("ggplot2"); install.packages("multcomp"); install.packages("pastecs"); install.packages("mlogit"); install.packages("nlme"); 
install.packages("reshape"); install.packages("effects"); install.packages("lm.beta")

#Load required packages
library(car); library(compute.es); library(ggplot2); library(multcomp); library(pastecs); library(mlogit); library(nlme); library(reshape); library(effects); library(lm.beta)


#Inpute data into R 
Brett_data <- read.csv("https://raw.githubusercontent.com/jshutay/CourseExamples/master/VideoGameData.csv",
                       header = TRUE,
                       sep = ",")


#Simple Linear Regression Examples

#Regression analysis
VisitRegression <- lm(VisitTime ~ Visits, data=Brett_data)
TotalRegression <- lm(VisitTime ~ TotalTime, data=Brett_data)

#Get standardized beta weights
lm.beta(VisitRegression)
lm.beta(TotalRegression)

#Compare models
anova(VisitRegression, TotalRegression)

#Compute residuals
resid(VisitRegression)
rstandard(TotalRegression)

#Appending diagnostics to dataset
Brett_data$residuals<-resid(VisitRegression)
Brett_data$standardized.residuals<-rstandard(TotalRegression)

#Write dataset to csv file - you will need to set your work directory to where you want this file outputted
write.table(Brett_data, "Brett's Data with Diagnostics.csv", sep = "\t", row.names = FALSE)

#Generate Predicted values by Standardized Residual Scatter Plot to test assumptions
scatter <- ggplot(Brett_data, aes(VisitRegression$fitted.values, standardized.residuals))
  scatter + geom_point() + geom_smooth(method = "lm", colour = "Blue") + labs (x = "Visit time", y = "Standardized Residuals")


#Multiple Linear Regression Examples

#Regression analysis
VisitRegression <- lm(VisitTime ~ Visits, data=Brett_data)
TotalRegression <- lm(VisitTime ~ Visits + Advertising, data=Brett_data)
  
#Get standardized beta weights
lm.beta(VisitRegression)
lm.beta(TotalRegression)
  
#Compare models
anova(VisitRegression, TotalRegression)
  
#Compute residuals
resid(VisitRegression)
rstandard(TotalRegression)
  
#Appending diagnostics to dataset
Brett_data$residuals<-resid(VisitRegression)
Brett_data$standardized.residuals<-rstandard(TotalRegression)
  
#Write dataset to csv file - - you will need to set your work directory to where you want this file outputted
write.table(Brett_data, "Brett's Data with Diagnostics.csv", sep = "\t", row.names = FALSE)
  
#Generate Predicted values by Standardized Residual Scatter Plot to test assumptions
scatter <- ggplot(Brett_data, aes(VisitRegression$fitted.values, standardized.residuals))
scatter + geom_point() + geom_smooth(method = "lm", colour = "Blue") + labs (x = "Visit time", y = "Standardized Residuals")
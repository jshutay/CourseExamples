
#Install required pacakges for analyses
install.packages("car"); install.packages("compute.es"); install.packages("ggplot2"); install.packages("multcomp"); install.packages("pastecs"); install.packages("mlogit"); install.packages("nlme"); install.packages("reshape"); install.packages("effects")

#Load required packages
library(car); library(compute.es); library(ggplot2); library(multcomp); library(pastecs); library(mlogit); library(nlme); library(reshape); library(effects)


#Inpute data into R 
ExperimentalData <- read.csv("https://raw.githubusercontent.com/jshutay/CourseExamples/master/TIM6520Dataset.csv",
                       header = TRUE,
                       sep = ",")


#One-Way ANOVA
OneWayModel<-aov(Visits ~ Game, data = ExperimentalData)
Anova(OneWayModel, type="III")

OneWayModel2<-aov(Visits ~ Advertising, data = ExperimentalData)
Anova(OneWayModel2, type="III")


#Factorial ANOVAs (Visits, Visit_time)
FactorialModel<-aov(Visits ~ Game*Advertising, data = ExperimentalData)
Anova(FactorialModel, type="III")

#NOTE: if you run the plot function, you will need to hit enter in the console per the prompting 4 times
plot(FactorialModel)


FactorialModel2<-aov(VisitTime ~ Game*Advertising, data = ExperimentalData)
Anova(FactorialModel2, type="III")

#NOTE: if you run the plot function, you will need to hit enter in the console per the prompting 4 times
plot(FactorialModel2)




#Install required pacakges for analyses
install.packages("car"); install.packages("compute.es"); install.packages("ggplot2"); install.packages("multcomp"); install.packages("pastecs"); install.packages("mlogit"); install.packages("nlme"); install.packages("reshape"); install.packages("effects")

#Load required packages
library(car); library(compute.es); library(ggplot2); library(multcomp); library(pastecs); library(mlogit); library(nlme); library(reshape); library(effects)


#Inpute data into R 
Brett_data <- read.csv("https://raw.githubusercontent.com/jshutay/CourseExamples/master/VideoGameData.csv",
                       header = TRUE,
                       sep = ",")



# Independent samples t-test (data in single column) to compare to one-way ANOVA results
newModel<-t.test(Visits ~ Game, data = Brett_data, paired = FALSE)
newModel

newModel2<-t.test(Visits ~ Advertising, data = Brett_data, paired = FALSE)
newModel2

#One-Way ANOVA
OneWayModel<-aov(Visits ~ Game, data = Brett_data)
Anova(OneWayModel, type="III")

OneWayModel2<-aov(Visits ~ Advertising, data = Brett_data)
Anova(OneWayModel2, type="III")


#Factorial ANOVAs (Visits, Visit_time)
FactorialModel<-aov(Visits ~ Game*Advertising, data = Brett_data)
Anova(FactorialModel, type="III")

#NOTE: if you run the plot function, you will need to hit enter in the console per the prompting 4 times
plot(FactorialModel)


FactorialModel2<-aov(VisitTime ~ Game*Advertising, data = Brett_data)
Anova(FactorialModel2, type="III")

#NOTE: if you run the plot function, you will need to hit enter in the console per the prompting 4 times
plot(FactorialModel2)



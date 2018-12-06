

#Install required pacakges for analyses
install.packages("car"); install.packages("ggplot2"); install.packages("pastecs"); install.packages("effects")

#Load required packages
library(car); library(ggplot2); library(pastecs); library(effects)


#Inpute data into R 
ExperimentalData <- read.csv("https://raw.githubusercontent.com/jshutay/CourseExamples/master/TIM6520Dataset.csv",
                       header = TRUE,
                       sep = ",")


#Create graphics 


#create a bar chart without advertising broken out
bar <- ggplot(ExperimentalData, aes(Game, Visits))
bar + stat_summary(fun.y = mean, geom = "bar", position ="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width = 0.90), width = 0.2) + labs(x = "Game", y = "Total time played in minutes")

#create a bar chart by Advertising, no Game groups
bar <- ggplot(ExperimentalData, aes(Advertising, Visits))
bar + stat_summary(fun.y = mean, geom = "bar", position ="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width = 0.90), width = 0.2) + labs(x = "Advertising", y = "Total time played in minutes")

#Testing normality with a Q-Q plot
qqplot.time <- qplot(sample = ExperimentalData$Visits, stat="qq") 
qqplot.time

#Histogram
myhistogram <- ggplot(ExperimentalData, aes(Visits))
myhistogram + geom_histogram(aes(y = ..density..))
 hist_play <- ggplot(ExperimentalData, aes(Visits)) + theme(legend.position = "none") + geom_histogram(aes(y = ..density..), colour = "black", fill = "white") + labs(x="Average daily play time", y = "Density")
hist_play


#Creating separate dataframes for with and without advertising and creating histograms
advertising<-subset(ExperimentalData, ExperimentalData$Advertising == "Full")
advertisingLight<-subset(ExperimentalData, ExperimentalData$Advertising == "Partial")
no_adv<-subset(ExperimentalData, ExperimentalData$Advertising == "None")

hist.advertising <- ggplot(advertising, aes(Visits)) + geom_histogram(aes(y = ..density..), fill = "white", colour = "black", binwidth = 1) + labs(x = "Daily Average in Minutes", y = "Density") + stat_function(fun=dnorm, args=list(mean =  mean(advertising$Visits, na.rm = TRUE), sd = sd(advertising$Visits, na.rm = TRUE)), colour = "blue", size=1)
hist.advertising

hist.advertisingLight <- ggplot(advertisingLight, aes(Visits)) + geom_histogram(aes(y = ..density..), fill = "white", colour = "black", binwidth = 1) + labs(x = "Daily Average in Minutes", y = "Density") + stat_function(fun=dnorm, args=list(mean =  mean(advertising$Visits, na.rm = TRUE), sd = sd(advertising$Visits, na.rm = TRUE)), colour = "blue", size=1)
hist.advertisingLight

hist.no_adv <- ggplot(no_adv, aes(Visits)) + geom_histogram(aes(y = ..density..), fill = "white", colour = "black", binwidth = 1) + labs(x = "Daily Average in Minutes", y = "Density") + stat_function(fun=dnorm, args=list(mean =  mean(no_adv$Visits, na.rm = TRUE), sd = sd(no_adv$Visits, na.rm = TRUE)), colour = "blue", size=1)
hist.no_adv

#Scatterplot
scatterplot(ExperimentalData$Visits, ExperimentalData$VisitTime)


#Testing statistical assumptions for parametric tests

#Shapiro-Wilk tests for normality
shapiro.test(ExperimentalData$Visits)
by(ExperimentalData$Visits, ExperimentalData$Game, shapiro.test)
by(ExperimentalData$Visits, ExperimentalData$Advertising, shapiro.test)

#Compute descritive statistics
stat.desc(ExperimentalData$Visits)
by(data = ExperimentalData$Visits, INDICES = ExperimentalData$Game, FUN = stat.desc) 

#Levene's test for homogeneity of variance
leveneTest(ExperimentalData$Visits, ExperimentalData$Game)



                                                                                                                                                                                                                                                            
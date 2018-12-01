

#Install required pacakges for analyses
install.packages("car"); install.packages("ggplot2"); install.packages("pastecs"); install.packages("effects")

#Load required packages
library(car); library(ggplot2); library(pastecs); library(effects)

#Inpute data into R 
Brett_data <- read.csv("https://github.com/jshutay/CourseExamples/blob/master/VidoeGameData.csv",
                       header = TRUE,
                       sep = ",")


#Create graphics 


#create a bar chart without advertising broken out
bar <- ggplot(Brett_data, aes(Game, Visits))
bar + stat_summary(fun.y = mean, geom = "bar", position ="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width = 0.90), width = 0.2) + labs(x = "Game", y = "Total time played")

#create a bar chart by Advertising, no Game groups
bar <- ggplot(Brett_data, aes(Advertising, Visits))
bar + stat_summary(fun.y = mean, geom = "bar", position ="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position = position_dodge(width = 0.90), width = 0.2) + labs(x = "Advertising", y = "Total time played")

#Testing normality with a Q-Q plot
qqplot.time <- qplot(sample = Brett_data$Visits, stat="qq") 
qqplot.time

#Histogram
myhistogram <- ggplot(Brett_data, aes(Visits))
myhistogram + geom_histogram(aes(y = ..density..))
 hist_play <- ggplot(Brett_data, aes(Visits)) + theme(legend.position = "none") + geom_histogram(aes(y = ..density..), colour = "black", fill = "white") + labs(x="Average daily play time", y = "Density")
hist_play

#Line chart
line + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group = Game)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Advertising", y = "Average daily play time", colour = "Game")

#Creating separate dataframes for with and without advertising and creating histograms
advertising<-subset(Brett_data, Brett_data$Advertising == "Yes")
no_adv<-subset(Brett_data, Brett_data$Advertising == "No")

hist.advertising <- ggplot(advertising, aes(Visits)) + geom_histogram(aes(y = ..density..), fill = "white", colour = "black", binwidth = 1) + labs(x = "Daily Average in Minutes", y = "Density") + stat_function(fun=dnorm, args=list(mean =  mean(advertising$Visits, na.rm = TRUE), sd = sd(advertising$Visits, na.rm = TRUE)), colour = "blue", size=1)
hist.advertising

hist.no_adv <- ggplot(no_adv, aes(Visits)) + geom_histogram(aes(y = ..density..), fill = "white", colour = "black", binwidth = 1) + labs(x = "Daily Average in Minutes", y = "Density") + stat_function(fun=dnorm, args=list(mean =  mean(no_adv$Visits, na.rm = TRUE), sd = sd(no_adv$Visits, na.rm = TRUE)), colour = "blue", size=1)
hist.no_adv


#Testing statistical assumptions for parametric tests

#Shapiro-Wilk tests for normality
shapiro.test(Brett_data$Visits)
by(Brett_data$Visits, Brett_data$Game, shapiro.test)
by(Brett_data$Visits, Brett_data$Advertising, shapiro.test)

#Compute descritive statistics
stat.desc(Brett_data$Visits)
by(data = Brett_data$Visits, INDICES = Brett_data$Game, FUN = stat.desc) 

#Levene's test for homogeneity of variance
leveneTest(Brett_data$Visits, Brett_data$Game)



                                                                                                                                                                                                                                                            

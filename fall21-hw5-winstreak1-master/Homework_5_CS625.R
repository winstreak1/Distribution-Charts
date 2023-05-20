library(dplyr)
library(ggplot2)
library(tidyverse)
#Data Manipulation
US.CENSUS.COUNTY <- read.csv("~/Downloads/co-est2019-alldata.csv", header=TRUE) #show header
US.CENSUS.COUNTY <- US.CENSUS.COUNTY[(US.CENSUS.COUNTY$STNAME!=US.CENSUS.COUNTY$CTYNAME), 
          c("CTYNAME", "CENSUS2010POP", "POPESTIMATE2015", "POPESTIMATE2019", "STNAME")] #exclude rows where state name = county name
CENSUS.DATA <- gather(US.CENSUS.COUNTY, key = "POPULATIONYEAR", value = "POPULATION", 2:4) # combine 3 columns into POPULATIONYEAR and their respective values to population
US.CENSUS.MOD <- US.CENSUS.COUNTY[(US.CENSUS.COUNTY$STNAME!=US.CENSUS.COUNTY$CTYNAME),
                                  c("CTYNAME", "CENSUS2010POP", "STNAME")] #filtered original dataset to only reflect CENSUS2010POP

#Boxplot w/ limit
boxplot(POPULATION~POPULATIONYEAR, data=CENSUS.DATA, col=c("#2B35E5", "#2BFFE5", "#E335E5"), main="US County Population from 2010-2019", 
horizontal=FALSE, xlab="Pop. by Year", ylab="Population", ylim=c(0,1e05))

#Boxplot w/o limit
boxplot(POPULATION~POPULATIONYEAR, data=CENSUS.DATA, col=c("#2B35E5", "#2BFFE5", "#E335E5"), main="US County Population from 2010-2019", 
        horizontal=FALSE, xlab="Pop. by Year", ylab="Population")


#CENSUS.ECDF <- ecdf(CENSUS.DATA$POPULATION)
#plot(CENSUS.ECDF, xlab="Population", ylab="eCDF", main="US County Population from 2010-2019")

#hist(CENSUS.DATA$POPULATION, main="DID IT WORK?!",xlab="Population", ylab="", xlim=c(0,1e06), breaks = 1000)


#eCDF w/ CENSUS2010POP only
CENSUS.2010ONLY <- ecdf(US.CENSUS.MOD$CENSUS2010POP)
plot(CENSUS.2010ONLY, col="red", xlab="Population", ylab="eCDF", main="The number of tied observations for 2010 US Pop. by County")

#HISTOGRAM w/ POPCENSUS2010 only

hist(US.CENSUS.MOD$CENSUS2010POP, main="2010 Population Distribution by US Counties",xlab="Population", ylab="Frequency", 
     xlim=c(0,1e06),col = c("#2B35E5", "#2BFFE5", "#E335E5", "#d9b1f0"), breaks = 1000)

#Birth & Death Rate
CENSUS.BIRTH.DEATH <- read.csv("~/Downloads/co-est2019-alldata.csv", header=TRUE)
CENSUS.BIRTH.DEATH <- CENSUS.BIRTH.DEATH[(CENSUS.BIRTH.DEATH$STNAME!=CENSUS.BIRTH.DEATH$CTYNAME), 
                                     c("CTYNAME", "CENSUS2010POP", "BIRTHS2010", "DEATHS2010", "STNAME")]
#write.csv(CENSUS.BIRTH.DEATH, file = "census_birth_death.csv")

CENSUS.BD.2019 <- read.csv("~/Downloads/co-est2019-alldata.csv", header=TRUE)
CENSUS.BD.2019 <- CENSUS.BD.2019[(CENSUS.BD.2019$STNAME!=CENSUS.BD.2019$CTYNAME), 
                 c("CTYNAME","CENSUS2010POP", "POPESTIMATE2019", "BIRTHS2019", "DEATHS2019", "STNAME")]

write.csv(CENSUS.BD.2019, file = "census_bD_2019.csv")

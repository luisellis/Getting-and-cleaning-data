# Quiz week 4. Getting and cleaning Data
# Question number 1. 
URL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
# Variables description here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#download.file(URL1, "US communities.csv")
#read.csv("US communities.csv", header = TRUE) -> uscom 
# since it's the same data as quiz 3 i'm using quiz 3 code. So for future references
#Remove the cometary for lines 5 & 6 or refer to quiz3 code
read.csv("Question1.csv", header = T) -> idahoData
templist <- strsplit(names(idahoData), c("wgtp"))
templist[[123]]

#Question number 2
#URL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
#Same as question 1, it's a replicate data so I'll use code from quiz 3
#download.file(URL2, "Domestic Product.csv")
library(stringr)
domestic <- read.csv("Domestic Product.csv", header = T, skip = 3
                     , nrows = 232)
domestic <- domestic[-1,]
domestic <- domestic[,-c(3,6:10)]
domestic <- domestic[-c(192:232),]
domestic$US.dollars. <- str_trim(gsub(",","", domestic$US.dollars.))
mean(as.numeric(domestic$US.dollars.), na.rm = TRUE)

#Question number 3
names(domestic)[1] <- "CountryCode"
names(domestic)[3] <- "countryNames"
grep("^United", domestic$countryNames)
#Decided to do it even though the answer was intuitive

#Question number 4
#This one uses the one we used called domestic and another one from 3rd quiz
#URL3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
#download.file(URL3, "Eduacational data.csv")
educational <- read.csv("Eduacational data.csv", header = TRUE)
edudomestic <- merge(domestic, educational)
length(grep(": [Jj][Uu][Nn][Ee] [0-9]+", edudomestic$Special.Notes))

#Question number 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sampleTimes[year(sampleTimes) == 2012] -> times2012
wday(times2012) -> days2012 
length(days2012[days2012==2])
#1-"" "15" 2-377652.4 3- 4-13 5-250,47
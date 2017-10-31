#Quiz week 3 - Getting and cleaning data
#Question number 1 - download some data then do some stuff
URL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(URL1, "Question1.csv")
read.csv("Question1.csv", header = T) -> idahoData
# code book is here bois: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
idahoData$ACR == 3 & idahoData$AGS == 6 -> agricultureLogical
which(agricultureLogical)
#125,238,262
#Question number 2 - use jpeg and do some stuff
URL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
quest2 <- readJPEG("Image.jpg", native = T)
# -15259150 -10575416
#Question number 3
URL3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
URL4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(URL3, "Domestic Product.csv")
download.file(URL4, "Eduacational data.csv")
domestic <- read.csv("Domestic Product.csv", header = T, skip = 3
                     , nrows = 232)
educational <- read.csv("Eduacational data.csv", header = TRUE)
domestic <- domestic[-1,]
names(domestic)[1] <- "CountryCode"
domestic <- domestic[,-c(3,6:10)]
domestic <- domestic[-c(192:232),]
edudomestic <- merge(domestic, educational)
sortededudomestic <- arrange(edudomestic, desc(Ranking))
# 189 matches st. kitts
#Question 4
sortededudomestic %>% 
        group_by(Income.Group) %>% 
        summarise(mean(Ranking)) %>% 
        print
#32.966667,91.91304
#Question 5

cut(sortededudomestic$Ranking, breaks = 5) -> groups
table(sortededudomestic$Income.Group, groups)
#5
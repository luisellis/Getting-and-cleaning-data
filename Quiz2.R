# Quiz for week 2 of getting and leaning data.
# For question 1 got to access to the teacher's API of github
#This is the code from the github tutorial (note that key and secret is differet)

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at 
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "56b637a5baffac62cad9",
                   secret = "8e107541ae1791259e9987d544ca568633da2ebf")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)
#After you've done all this and have the data procced to the interested
contentList <- content(req)
for(i in 1:30) {print(contentList[[i]]$name)}
#there you can find that data sharing is the 12th element
contentList[[12]]$created_at
#supposing this was a big list and couldn't go through all, 
#just made the function to save it on a vector instead of printing them
#after saving it, could do subsetting or something like that (find the boolean
# that) then create another set and subset
##Question number 2
#use the sqldf package, download a csv and apply a function 
library(sqldf)
acs_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
# the online method was not working, so I dowloaded it
acs <- read.csv(choose.files(), header = T)
sqldf("select pwgtp1 from acs") -> fun1
view(fun1)
#I'll omit all tries but correct (logically) is
fun3 <- sqldf("select pwgtp1 from acs where AGEP < 50")

#Question 3, find which comand is similar to unique(acs$AGEP)
#for this we save the result
correct <- unique(acs$AGEP)
#after trial and error
sqldf("select distinct AGEP from acs")

#Question number 4
#read an html and find the amount of characters on lines 10,20,30 and 100
lineshtml <- "http://biostat.jhsph.edu/~jleek/contact.html"
readLines(lineshtml) ->doc
nchar(doc[c(10,20,30,100)])

#Question number 5
#read a file with .for extention and find a sum
urlfor <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
read.fwf(urlfor, 10, header = TRUE) -> quest5
#Aqui tocó force, probé con diferentes combinaciones de read.fwf
#la ganadora fue
read.fwf(urlfor, c(11,8, 8,5), skip = 4) -> quest5
sum(quest5$V4)
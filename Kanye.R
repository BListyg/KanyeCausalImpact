library("gtrendsR") #Gets data
library("CausalImpact") #For analysis
library(zoo)

#Reading in data
tswift <- gtrends(keyword = "Taylor Swift",
        time = "all")

kwest <- gtrends(keyword = "Kanye West",
                  time = "all")

tswift$interest_over_time$hits <- gsub("<1",0,tswift$interest_over_time$hits)

kwest$interest_over_time$hits <- gsub("<1",0,kwest$interest_over_time$hits)

data <- data.frame(tswift = as.numeric(tswift$interest_over_time$hits), 
              kwest = as.numeric(kwest$interest_over_time$hits))

data <- zoo(data, tswift$interest_over_time$date)

pre.period <- as.Date(c("2004-01-01", "2009-09-01"))
post.period <- as.Date(c("2009-10-01", "2018-04-01"))

impact <- CausalImpact(data, pre.period, post.period, model.args = list(niter = 5000, nseasons = 12))

plot(impact)

summary(impact)

summary(impact, "report")

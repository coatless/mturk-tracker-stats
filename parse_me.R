install.packages('devtools')

library(devtools)

install_github("jeroenooms/jsonlite")

library(jsonlite)

# Hit groups
hitg.url = 'https://crowd-power.appspot.com/_ah/api/mturk/v1/hitgroup/search?all=yes'
hitg.doc = fromJSON(txt=hitg.url)


############
# Demographics
#####

# Get demographics
demo.url = "https://mturk-surveys.appspot.com/_ah/api/survey/v1/survey/demographics/answers?limit=16000"
demo.docs = fromJSON(txt=demo.url)

# Remove the hit kind and extract out item info
demo.docs = demo.docs$items[,-ncol(demo.docs$items)]

# Extract out df
demo.docs = cbind(demo.docs[,-2],demo.docs[,2])

# To lower
demo.docs[demo.docs$gender == "Female","gender"] = "female"

# Cast types
demo.docs[,"locationCountry"] = factor(demo.docs[,"locationCountry"])
demo.docs[,"locationRegion"] = factor(demo.docs[,"locationRegion"])
demo.docs[,"locationCity"] = factor(demo.docs[,"locationCity"])
demo.docs[,"householdSize"] = factor(demo.docs[,"householdSize"])
demo.docs[,"householdIncome"] = factor(demo.docs[,"householdIncome"])
demo.docs[,"gender"] = factor(demo.docs[,"gender"])
demo.docs[,"yearOfBirth"] = factor(demo.docs[,"yearOfBirth"])
demo.docs[,"maritalStatus"] = factor(demo.docs[,"maritalStatus"])

demo.docs[,"date"] = strptime(demo.docs[,"date"],"%Y-%m-%dT%H:%M:%S")

#demo.docs[,"hitCreationDate"] = strptime(demo.docs[,"hitCreationDate"],"%Y-%m-%dT%H:%M:%S")


setwd("~/BoxSync/Courses/CS 565/Presentation")
save(demo.docs, file="demo.rda")

##########
# Arrival List
##########

from.date = URLencode("09/08/2015",reserved=T)
to.date = URLencode("09/08/2015",reserved=T)

# Get the data
url2  = paste0("https://crowd-power.appspot.com/_ah/api/mturk/v1/arrivalCompletions/list?from=",from.date,"&to=",to.date)



#####
# Treemap


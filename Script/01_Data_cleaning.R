#### Preamble ####
# Purpose: Clean the music first data and the no music first data
# Author: Hong Pan
# Date:  "`r format(Sys.time(), '%d %B %Y')`"
# Contact: hong.pan@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# -None

#### Workspace setup ####
library(tidyverse)

#### Read in the raw data ####

music_first <- readr::read_csv(here::here("Input/music_first.csv"))
no_music_first<-readr::read_csv(here::here("Input/no_music_first.csv"))


#### Data cleaning ####
## For music_first dataset

music_first_clean<-music_first[-c(28: 38),] #remove empty rows

music_first_clean<-music_first_clean%>%  # remove empty columns
  select(-c(Issues,...10,...13))
  
# Change dataset wide to longitudial
data1<-music_first_clean%>%
  select(X1,`Test Type 1`,`Time 1(sec)`,Gender,`Rating (1-5)`,Feedback,`Change (%)`)%>%
  mutate(order=1)


data2 <-music_first_clean%>%
  select(X1,`Test Type 2`,`Time 2 (sec)`,Gender,`Rating (1-5)`,Feedback,`Change (%)`)%>%
  mutate(order=2)

names(data1)[1:3] <- c("Id", "Test_Type", "Time(sec)")
names(data2)[1:3] <- c("Id", "Test_Type", "Time(sec)")

longdata1<- rbind(data1, data2)
longdata1 <- longdata1 %>% 
  arrange(Id, order)

# Change variable names
names(longdata1)[names(longdata1) == "Time(sec)"] <- "Time_Sec"
names(longdata1)[names(longdata1) == "Rating (1-5)"] <- "Rating"
names(longdata1)[names(longdata1) == "Change (%)"] <- "Change_%"

 
##For no_music_first dataset
no_music_first_clean<-no_music_first[-c(21: 34),]#remove empty rows

no_music_first_clean<-no_music_first_clean%>%  #remove empty columns
  select(-c(Issues,...10,...13))

# Change dataset wide to longitudial
data3<-no_music_first_clean%>%
  mutate(order=1,Id=seq(28,47))%>%
  select(Id,order,`Test Type 1`,`Time 1(sec)`,Gender,`Rating (1-5)`,Feedback,`Change (%)`)


data4 <-no_music_first_clean%>%
  mutate(order=2,Id=seq(28,47))%>%
  select(Id,order,`Test Type 2`,`Time 2 (sec)`,Gender,`Rating (1-5)`,Feedback,`Change (%)`)


names(data3)[3:4] <- c( "Test_Type", "Time(sec)")
names(data4)[3:4] <- c( "Test_Type", "Time(sec)")

longdata2<-rbind(data3, data4)


longdata2 <- longdata2 %>%
  arrange(Id, order)

#Change variables name
names(longdata2)[names(longdata2) == "Time(sec)"] <- "Time_Sec"
names(longdata2)[names(longdata2) == "Rating (1-5)"] <- "Rating"
names(longdata2)[names(longdata2) == "Change (%)"] <- "Change_%"


#Combined two datasets

music_dataset<-rbind(longdata1,longdata2)
music_dataset$Id<-as.character(dataset$Id)
music_dataset$order<-as.character(dataset$order)


#Save the cleaned dataset
write.csv(music_dataset, here::here("Input/music_dataset.csv"))









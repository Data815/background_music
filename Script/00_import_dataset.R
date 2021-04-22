#### Preamble ####
# Purpose: Import raw datasets from OSF
# Author: Hong Pan
# Date:  "`r format(Sys.time(), '%d %B %Y')`"
# Contact: hong.pan@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#-install.packages("osfr")



#### Workspace setup ####
library(osfr)
library(readxl)


#### Get Data ####
project<- osf_retrieve_node("https://osf.io/9xh8e/")
files <- osf_ls_files(project)
dataset<-osf_download(files[2,])

# Move Excel dataset to the input folder
file.copy(from = here::here("data-processed.xlsx"),
          to   = here::here("Input"))

file.remove(here::here("data-processed.xlsx"))

# Import the dataset from each sheet 
music <- read_excel(here::here("Input/data-processed.xlsx"), sheet = "Music First")
no_music<- read_excel(here::here("Input/data-processed.xlsx"), sheet = "No Music First")


#Save the data set in each worksheet as a separate CSV file
write.csv(music, here::here("Input/music_first.csv"))
write.csv(no_music, here::here("Input/no_music_first.csv"))

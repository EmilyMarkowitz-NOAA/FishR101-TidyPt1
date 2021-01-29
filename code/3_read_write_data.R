# Lesson 3: Reading and writing data in R
# Created by: Caitlin Allen Akselrud
# Contact: caitlin.allen_akselrud@noaa.gov
# Created: 2020-01-28
# Modified: 2021-01-28


# packages ----------------------------------------------------------------

library(tidyverse)
library(here)
library(lubridate)

# your working directory --------------------------------------------------

here() # this is where you are

# navigate to sub-folders:
here("code") # go into the 'code' folder
here("data") # go into the 'data' folder

# read in data ------------------------------------------------------------

# * RStudio console -------------------------------------------------------

# Files pane > data folder > click on data file > "Import Dataset"

# "File" -> "Import Dataset" > select a file or input a url

# Reproducible way: code in your import... see below

# * csv and other local files ---------------------------------------------

# base R:
ebs_csv_base <- read.csv(file = here("data", "ebs_2017-2018.csv"))
ebs_csv_base

whales_txt_base <- read.table(file = here("data", "GRAY.TXT"))
whales_txt_base

# tidy R:
ebs_csv_tidy <- read_csv(file = here("data", "ebs_2017-2018.csv"))
ebs_csv_tidy

whales_tab_tidy <- read_table(file = here("data", "GRAY.TXT"))
whales_tab_tidy # didn't work the way we expected...

# # try this instead (note '\t' means there is a tab separating columns)
whales_delim_tidy <- read_delim(file = here("data", "GRAY.TXT"), 
                              delim = "\t", col_names = FALSE)
whales_delim_tidy


# * from internet source --------------------------------------------------

# if the .csv is available online:
# data <- read.csv(url("http://some.where.net/data/foo.csv"))
# or, the tidy way:
plastics <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv')
plastics

git_data <- read.table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered.csv", header=T)
git_data
# works

git_data_tidy <- read_table("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered.csv")
git_data_tidy
# doesn't work

git_data_tidy2 <- read_delim("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered.csv", delim = "-")
git_data_tidy2
# doesn't work...

# common read-in problems -------------------------------------------------

# * error on read-in ------------------------------------------------------
# # try a different read-in method
#     there are multiple methods that do the same thing

# * columns not separated correctly ----------------------------------------
# # remember our git_data problem (above)?
#     try a different read-in method
#     use the read_delim to try different delimiters 
#     check your original data
#     go to the google machine for additional tips


# * extra header lines ----------------------------------------------------
# # use the 'skip' feature
ebs_header <- read_csv(file = here("data", "ebs_2017-2018_headers.csv"))
ebs_header
# take a look at the first row... that's not right...
ebs_header2 <- read_csv(file = here("data", "ebs_2017-2018_headers.csv"),
                         skip = 2, col_names = FALSE)
ebs_header2
# now we need column names
ebs_header_names <- names(read_csv(file = here("data", "ebs_2017-2018_headers.csv"), 
                                   n_max = 0))
ebs_header3 <- read_csv(file = here("data", "ebs_2017-2018_headers.csv"),
                        skip = 2, col_names = ebs_header_names)
ebs_header3
# and look, it auto-corrected the column types! how cool!

# * column type not correct -----------------------------------------------

ebs_header3
# but... a few column types are not correct. Let's fix that:
ebs_header4 <- read_csv(file = here("data", "ebs_2017-2018_headers.csv"),
                        skip = 2, col_names = ebs_header_names,
                        col_types = cols(
                          "LATITUDE" = col_double(),   
                          "LONGITUDE" = col_double(), 
                          "STATION" = col_character(),   
                          "STRATUM" = col_double(),   
                          "YEAR"    = col_double(),     
                          "DATETIME" = col_guess(),   
                          "WTCPUE"  = col_double(),  
                          "NUMCPUE" = col_double(),   
                          "COMMON"  = col_character(),   
                          "SCIENTIFIC" = col_character(),
                          "SID"     = col_double(),   
                          "BOT_DEPTH"= col_double(),  
                          "BOT_TEMP" = col_double(),  
                          "SURF_TEMP"= col_double(), 
                          "VESSEL"   = col_double(),  
                          "CRUISE"   = col_double(),  
                          "HAUL"     = col_double()
                        ))
ebs_header4
# *NOTE that in column "DATETIME" I specified col_guess()
#   that means I am asking the readr package to guess what column type it is
#   I tried setting that column to col_datetime() and col_time() but got 'parsing' errors
#   this is because the time format is non-conforming to standards
#   we will talk about how to fix time formats next week.

# is there any easier way to correct individual columns??
#   YES!

# install.packages('magrittr')
library(magrittr) # this package contains the function: %<>%
#   %<>% means: assign a change to the object on the left
ebs_header3
ebs_header3$DATETIME %<>% mdy_hm
# the mdy_hm means that the time format is month-day-year hour-minute 
#   from the lubridate package

ebs_header3
# now 'DATETIME' is formatted as a time! sweet victory.


# writing data ------------------------------------------------------------

# # write a table/tibble/data frame of results

# # write complex or mixed data: sink() function

# * .csv or text file -----------------------------------------------------

write.csv(x = whales_txt_base, file = here("output", "whales.csv"))
write_csv(x = whales_txt_base, path = here("output", "whales_readr.csv"))

write_file(x = "save my stuff", path = here("output", "save_text.txt"))

string_vector <- c("fish", "whale", "invert", "epipelagic", "benthic")
write_lines(x = string_vector, path = here("output", "save_lines.txt"))

write_lines(x = as.list(string_vector), path = here("output", "save_lines2.txt"))

# * complex or mixed output -----------------------------------------------

# the sink() function
save_to <- here("output", "my_first_sink.txt") # designate the output folder and name your output
sink(save_to)    # open or start your sink, and give it the save location and name
for (i in 1:20){ # print 20 numbers to your text file
  print(i)
}
sink()           # close the sink


# complex/mixed output: 
save_model_info <- list("data" = whales_txt_base,
                        "model" = "population dynamics",
                        "recruitment" = 0.05,
                        "mortality" = 0.04)

save_whale_model <- here("output", "whale_model.txt") 
sink(save_whale_model)
print(save_model_info)
sink() # ALWAYS close your sink at the end!



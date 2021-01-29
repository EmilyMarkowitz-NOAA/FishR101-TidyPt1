# Homework 3 Solutions: Reading and writing data in R
# Created by: Caitlin Allen Akselrud  
# Contact: caitlin.allen_akselrud@noaa.gov  
# Created: 2021-01-28

# packages ----------------------------------------------------------------
library(tidyverse)


# tasks -------------------------------------------------------------------

# 1) read-in: 
#     see if you can use the error message to determine what the two columns should be
#     correct the column types accordingly
#     HINT: use View(challenge) or tail(challenge) to see more of column y
challenge <- read_csv(readr_example("challenge.csv"))
challenge
tail(challenge)

challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)
challenge
tail(challenge)

# 2) write:
#     a) write your corrected challenge object to a .csv and a .txt file 
#         in the correct subfolder
#     b) write challenge, fish_names, and name_rank to a .txt file

fish_names <- c("Nemo", "Bubbles", "Jack", "Captain", "Finley",
                "Goldie", "Dory", "Ariel", "Angel", "Minnie")

name_rank <- rep(1:5, times = 2)

save_stuff <- list("challenge" = challenge,
                   "names" = fish_names,
                   "rank" = name_rank)

save_dir <- here('output', "saving_stuff.txt")
sink(save_dir)
save_stuff
sink()

# 3) find a data set you've worked with and pull it into R
#     a) fix any problems with column designation, and 
#     b) clean up the column names (Hint: remember lecture 2)


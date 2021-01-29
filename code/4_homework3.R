# Homework 3: Reading and writing data in R
# Created by: 
# Contact: 
# Created: 
# Modified: 


# packages ----------------------------------------------------------------
library(tidyverse)


# tasks -------------------------------------------------------------------

# 1) read-in: 
#     a) use the error message to determine what the two columns should be
#     b) correct the column types accordingly
#     HINT: use View(challenge) or tail(challenge) to see more of column y
challenge <- read_csv(readr_example("challenge.csv"))
challenge

# 2) write:
#     a) write your corrected challenge object to a .csv and a .txt file 
#         in the correct subfolder
#     b) write challenge, fish_names, and name_rank to a .txt file

fish_names <- c("Nemo", "Bubbles", "Jack", "Captain", "Finley",
                "Goldie", "Dory", "Ariel", "Angel", "Minnie")

name_rank <- rep(1:5, times = 2)



# 3) find a data set you've worked with and pull it into R
#     a) fix any problems with column designation, and 
#     b) clean up the column names (Hint: remember lecture 2)

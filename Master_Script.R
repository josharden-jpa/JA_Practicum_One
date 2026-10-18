


#Load Packages - load once so every sourced script can use them.

library(haven)
library(tidyverse)
library(here)
library(patchwork)

# project folder found by here, so no hardcoded paths.
project_root <- here::here()

# the data/raw folder path, built with file.path() so it works on any OS.
raw_dir <- file.path(project_root, "data", "raw")
dir.create(file.path(project_root, "output"), showWarnings = FALSE)




# Stage One -- Reading --


# give source() the full path from project_root so it finds the script

source(file.path(project_root, "Data_ONE.R"))  

# runs code, produce object 'raw_data'




# Stage Two - "Cleaning" - 


source(file.path(project_root, "Clean_TWO.R"))

# defines function 'clean_cces'
# turn the function into an object 'clean_data'

clean_data <- clean_cces(raw_data) # raw_data from stage 1 as object going in


saveRDS(clean_data, file.path(project_root, "data", "clean_cces.rds"))





# Stage Three - Figure(s) -


source(file.path(project_root, "Fig1_THREE.R"))   # defines make_fig1()

fig1 <- make_fig1(clean_data)                          # runs it
fig1                                              # displays it
ggsave(file.path(project_root, "output", "fig1.png"), fig1, width = 7, height = 10)


source(file.path(project_root, "Fig2_FOUR.R"))   # defines make_fig2()

fig2 <- make_fig2(clean_data)                          # runs it
fig2                                              # displays it
ggsave(file.path(project_root, "output", "fig2.png"), fig2, width = 7, height = 5)


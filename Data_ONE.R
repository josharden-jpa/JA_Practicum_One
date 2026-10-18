# read in and filter Cooperative (Congressional) Election Study data
# "“Partisanship and Voting Behavior”, for the years 2006–2024
# using the Cumulative CCES Dataset. "

raw_data <- read_dta(file.path(raw_dir, "cumulative_2006-2024.dta"))

#' Analyze Data
#' 
#' @description 
#' 
#' @return 

here::i_am("R/02_analyze_data.R")

# variables
todays_date <- base::Sys.Date()

# location of data 
location_of_us_clean <- here::here("clean_data",
                                   "us_covid_clean.rds")
location_of_or_clean <- here::here("clean_data",
                                   "or_covid_clean.rds")

# data 
us_clean <- base::readRDS(location_of_us_clean)
or_clean <- base::readRDS(location_of_or_clean)

# location of output data
location_of_todays_date <- here::here("output",
                                      "todays_date.rds")

# saved data
saveRDS(todays_date, location_of_todays_date)
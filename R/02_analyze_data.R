#' Analyze Data
#' 
#' @description This analysis does: 
#' 1. Save simple variables such as: today's date
#' 2. Load clean data
#' 3. Save Data
#' 4. Compute most current date of data. 
#' 
#' @return 2 char objects:  
#' date_today.rds : today's date
#' date_data.rds : data's most current date

here::i_am("R/02_analyze_data.R")

# libraries
library(dplyr)

# variables
date_today <- base::Sys.Date()

# location of data 
location_of_us_clean <- here::here("clean_data",
                                   "us_covid_clean.rds")
location_of_or_clean <- here::here("clean_data",
                                   "or_covid_clean.rds")

# data 
us_clean <- base::readRDS(location_of_us_clean)
or_clean <- base::readRDS(location_of_or_clean)

# most current date of data
most_current_date_of_data <- dplyr::arrange(us_clean, desc(date))[1,1]
date_data <- most_current_date_of_data$date

# location of output data
location_of_todays_date <- here::here("output",
                                      "date_today.rds")
location_of_datas_date <- here::here("output",
                                     "date_data.rds")

# saved data
saveRDS(date_today, location_of_todays_date)
saveRDS(date_data, location_of_datas_date)
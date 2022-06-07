#' Save "dates" data
#' 
#' @description this file uses baser and user input 
#' dates from google on us and or closure. 
#' 
#' @return a .rds file with a list of ?? dates. 

# location of this file within the project
here::i_am("00_code/R/00_02_raw_data_dates.R")

# todays date 
todays_date <- base::Sys.Date()

# closure dates (google search)
us_close_date <- base::as.Date("2020-03-15")
or_close_date <- base::as.Date("2020-03-23")

# list
date_data <- list(todays_date,
                  us_close_date,
                  or_close_date)

# location of saved data
location_of_dates_data <- here::here("01_data/raw_data",
                                     "raw_data_dates.rds")

# save date
base::saveRDS(date_data, location_of_dates_data)
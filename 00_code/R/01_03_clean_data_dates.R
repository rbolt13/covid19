#' Dates
#' 
#' @description puts all raw NYT dates, and raw dates into one list.
#' 
#' @return a .rds list of dates. 

# location of this file
here::i_am("00_code/R/01_03_clean_data_dates.R")

#location of data
location_of_NYT_data <- here::here("01_data/raw_data",
                                   "raw_data_NYT.rds")
location_of_dates_data <- here::here("01_data/raw_data",
                                     "raw_data_dates.rds")

# data
today <- base::readRDS(location_of_dates_data)[[1]]
us_close <- base::readRDS(location_of_dates_data)[[2]]
or_close <- base::readRDS(location_of_dates_data)[[3]]
us_data_date <- base::readRDS(location_of_NYT_data)[[4]]
or_data_date <- base::readRDS(location_of_NYT_data)[[5]]

# list
data_list <- list(today,
                  us_close,
                  or_close,
                  us_data_date,
                  or_data_date)

# location of date data
location_of_date_data <- here::here("01_data/clean_data",
                                    "clean_data_dates.rds")

# save data
base::saveRDS(data_list, location_of_date_data)
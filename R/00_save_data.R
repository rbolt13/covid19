#' Save Data
#'
#' @description saves two lists of data to raw_data folder. The first 
#' list of raw data uses the readr and tidycensus packages to make five
#' different data sets: states_covid_data, counties_covid_data, vacc_data, 
#' state_pop_data, and or_pop_data. The second list use base and dplyr 
#' functions to save five dates: todays_date, us_close_date, or_close_date, 
#' us_data_date, and counties_data_date. 
#' 
#' @return Two lists, one with raw data, and the other with date data. 

 
here::i_am("R/00_save_data.R")

library(readr)
library(tidycensus)
library(dplyr)


readRenviron(".Renviron")

# List 1: Raw Data

  # NYT CSV data 
states_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
counties_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
vacc_data <- readr::read_csv("https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/us_data/time_series/people_vaccinated_us_timeline.csv")
  # tidy census data 
state_pop_data <- tidycensus::get_estimates(geography = "state",
                                            year = 2019,
                                            variable = "POP")
or_pop_data <- tidycensus::get_estimates(geography = "county", 
                             state = "OR", 
                             year = 2019, 
                             variable = "POP")
  # put in one list
raw_data_list <- list(states_covid_data,
                      counties_covid_data,
                      vacc_data)

# List 2: Dates 

  # today 
todays_date <- base::Sys.Date()

  # closure dates (google)
us_close_date <- base::as.Date("2020-03-15")
or_close_date <- base::as.Date("2020-03-23")

  # arrange data by most current and extract that 
us_data_date_find <- dplyr::arrange(states_covid_data, desc(date))[1,1]
counties_data_date_find <- dplyr::arrange(counties_covid_data, desc(date))[1,1]
  
  # data dates 
us_data_date <- us_data_date_find$date
counties_data_date <- counties_data_date_find$date

  # put in one list 
dates_list <- list(todays_date,
                   us_close_date,
                   or_close_date,
                   us_data_date,
                   counties_data_date)

# Location of Data 

  # raw data list
location_of_raw_data_list <- here::here("raw_data",
                                        "raw_data_list.rds")

  # date data list 
location_of_dates_list <- here::here("raw_data",
                                     "dates_list.rds")

# Save Data 
base::saveRDS(raw_data_list, location_of_raw_data_list)
base::saveRDS(dates_list, location_of_dates_list)
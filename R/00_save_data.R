#' Save Data
#'
#' @description this file downloads various dfs and returns 
#' a list of raw dfs by first downloading CSV Covid data from the 
#' NYT Github, population data from the tidycensus package, and 
#' date data from base R, and google. 
#' 
#' @return One list with all the raw data used in this project.  

# This is where you are in the project. 
here::i_am("R/00_save_data.R")

# Theses are the libraries you will need for this file. 
library(readr)
library(tidycensus)
library(dplyr)

# This is where your hidden API key for tidycensus is located. 
readRenviron(".Renviron")

# Raw Data -----------------------------------------------------

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
  # today 
todays_date <- base::Sys.Date()

  # closure dates (google)
us_close_date <- base::as.Date("2020-03-15")
or_close_date <- base::as.Date("2020-03-23")

  # arrange data by most current date and extract that 
us_data_date_find <- dplyr::arrange(states_covid_data, desc(date))[1,1]
counties_data_date_find <- dplyr::arrange(counties_covid_data, desc(date))[1,1]
  
  # data dates 
us_data_date <- us_data_date_find$date
counties_data_date <- counties_data_date_find$date

  # put in one list
raw_data_list <- list(states_covid_data,
                      counties_covid_data,
                      vacc_data,
                      state_pop_data,
                      or_pop_data,
                      todays_date,
                      us_close_date,
                      or_close_date,
                      us_data_date,
                      counties_data_date)

# ------------------------------------------------------------------

# This is the location of raw data list. 
location_of_raw_data_list <- here::here("raw_data",
                                        "raw_data_list.rds")

# This saves the raw data list.
base::saveRDS(raw_data_list, location_of_raw_data_list)
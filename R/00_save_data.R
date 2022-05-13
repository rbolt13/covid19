#' Save Data
#'
#' @description uses readr to save 6 csv data sets from github,
#' and tidycensus to save 4 data sets. 
#' 
#' 00_00: where this file is located in within the project. 
#' 00_01: load libraries: readr and tridycensus
#' 00_02: read .Renviron, for tidycensus API
#' 00_03: save today's date
#' 00_04: read CSV data from github: states_covid_data, 
#' counties_covid_data, vacc_data
#' 00_05: 
#'
#' @return saves 10 .rds data sets to raw_data project folder. 
#' 6 related to covid, and 4 related to census data. 

# 00_00: location of this file within this project. 
here::i_am("R/00_save_data.R")

# 00_01: load libraries 
library(readr)
library(tidycensus)
library(dplyr)

# 00_02: read .Renviron
readRenviron(".Renviron")

# 00_03: save today's date
date_today <- base::Sys.Date()

# 00_04: read CSV data from github: states_covid_data, counties_covid_data, vacc_data
states_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
counties_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
vacc_data <- readr::read_csv("https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/us_data/time_series/people_vaccinated_us_timeline.csv")

# 00_05: BONUS DATA (not used bc/ not updated since 2021)
policytrackerOR_data <- read_csv("https://raw.githubusercontent.com/govex/COVID-19/govex_data/data_tables/policy_data/table_data/Current/Oregon_policy.csv")
college_data <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/colleges/colleges.csv')
mask_use_data <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/colleges/colleges.csv')

# 00_06: read tidycensus data
state_pop_data <- tidycensus::get_estimates(geography = "state",
                                            year = 2019,
                                            variable = "POP")
or_pop_data <- get_estimates(geography = "county", 
                             state = "OR", 
                             year = 2019, 
                             variable = "POP")

# 00_07: BONUS DATA (not used)
state_den_data <- get_estimates(geography = "state", 
                                year = 2019, 
                                variable =  "DENSITY") 

or_den_data <- get_estimates(geography = "county", 
                             state = "OR", 
                             year = 2019, 
                             variable = "DENSITY")

# 00_08: save date of most recent data entry
date_data_find <- dplyr::arrange(states_covid_data, desc(date))[1,1]
date_data <- date_data_find$date

# location of data (main)
location_of_states_covid <- here::here("raw_data",
                                       "states_covid_data.rds")
location_of_counties_covid <- here::here("raw_data",
                                         "counties_covid_data.rds")
location_of_vacc <- here::here("raw_data",
                               "vacc_data.rds")
location_of_state_pop <- here::here("raw_data",
                                    "state_pop_data.rds")
location_of_or_pop <- here::here("raw_data",
                                 "or_pop_data.rds")

# location of data (bonus)
location_of_policytracker <- here::here("raw_data",
                                        "policy_tracker_or_data.rds")
location_of_college <- here::here("raw_data",
                                  "college_covid_data.rds")
location_of_mask_use <- here::here("raw_data",
                                   "mask_use_data.rds")
location_of_state_den <- here::here("raw_data",
                                    "state_den_data.rds")
location_of_or_den <- here::here("raw_data",
                                 "or_den_data.rds")

# location of output data
location_of_todays_date <- here::here("raw_data",
                                      "date_today.rds")
location_of_datas_date <- here::here("raw_data",
                                     "date_data.rds")

# saved data
saveRDS(date_today, location_of_todays_date)
saveRDS(date_data, location_of_datas_date)

# save data
saveRDS(states_covid_data, location_of_states_covid)
saveRDS(counties_covid_data, location_of_counties_covid)
saveRDS(vacc_data, location_of_vacc)
saveRDS(state_pop_data, location_of_state_pop)
saveRDS(or_pop_data, location_of_or_pop)

# save data (bonus)
saveRDS(policytrackerOR_data, location_of_policytracker)
saveRDS(college_data, location_of_college)
saveRDS(mask_use_data, location_of_mask_use)
saveRDS(state_den_data, location_of_state_den)
saveRDS(or_den_data, location_of_or_den)
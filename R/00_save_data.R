#' Save Data
#'
#' @description uses readr to save 6 csv data sets from github,
#' and tidycensus to save 4 data sets. 
#'
#' @return saves 10 .rds data sets to raw_data project folder. 
#' 6 related to covid, and 4 related to census data. 

here::i_am("R/00_save_data.R")

library(readr)
library(tidycensus)

# read CSV data
states_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
counties_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
vacc_data <- readr::read_csv("https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/us_data/time_series/people_vaccinated_us_timeline.csv")

# bonus data (not used bc/ not updated since 2021)
policytrackerOR_data <- read_csv("https://raw.githubusercontent.com/govex/COVID-19/govex_data/data_tables/policy_data/table_data/Current/Oregon_policy.csv")
college_data <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/colleges/colleges.csv')
mask_use_data <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/colleges/colleges.csv')

# read tidycensus data
state_pop_data <- tidycensus::get_estimates(geography = "state",
                                            year = 2019,
                                            variable = "POP")
or_pop_data <- get_estimates(geography = "county", 
                             state = "OR", 
                             year = 2019, 
                             variable = "POP")

# bonus data (not used)
state_den_data <- get_estimates(geography = "state", 
                                year = 2019, 
                                variable =  "DENSITY") 

or_den_data <- get_estimates(geography = "county", 
                             state = "OR", 
                             year = 2019, 
                             variable = "DENSITY")

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
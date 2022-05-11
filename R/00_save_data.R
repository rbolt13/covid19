here::i_am("R/00_save_data.R")

library(readr)
library(tidycensus)

# read CSV data
us_states_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
us_counties_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
vacc <- readr::read_csv("https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/us_data/time_series/people_vaccinated_us_timeline.csv")

# bonus data (not updated since 2021)
policytrackerOR_data <- read_csv("https://raw.githubusercontent.com/govex/COVID-19/govex_data/data_tables/policy_data/table_data/Current/Oregon_policy.csv")
college_data <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/colleges/colleges.csv')
mask_use_data <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/colleges/colleges.csv')

# read tidycensus data
state_pop_data <- tidycensus::get_estimates(geography = "state",
                                            year = 2019,
                                            variable = "Pop")
state_den_data <- get_estimates(geography = "state", 
                                year = 2019, 
                                variable =  "DENSITY")
or_pop_data <- get_estimates(geography = "county", 
                             state = "OR", 
                             year = 2019, 
                             variable = "POP")
or_den_data <- get_estimates(geography = "county", 
                             state = "OR", 
                             year = 2019, 
                             variable = "DENSITY")

# put data into list
data_list <- list(us_states_covid_data, 
                  us_counties_data, 
                  vacc_data, 
                  policytrackerOR_data,
                  college_data,
                  mask_use_data,
                  state_pop_data,
                  state_den_data,
                  or_pop_data,
                  or_den_data)

# location of data
location_of_data <- here::here("raw_data", "data.rds")

# save list of data
saveRDS(data_list, location_of_data)
#' Save census data
#' 
#' @descritpion this file uses the R package tidycensus and 
#' an API to get population date by state and by county. 
#' 
#' @retrun a .RDS file with a list of two census data sets.

# location of this file within project
here::i_am("00_code/R/00_01_raw_data_census.R")

# packages
library(tidycensus)

# API 
readRenviron(".Renviron")

# data
state_pop_data <- tidycensus::get_estimates(geography = "state",
                                            year = 2019,
                                            variable = "POP")
or_pop_data <- tidycensus::get_estimates(geography = "county",
                                         state = "OR", 
                                         year = 2019, 
                                         variable = "POP")

# save data into a list
census_data <- list(state_pop_data,
                    or_pop_data)

# location of saved data
location_of_census_data <- here::here("01_data/raw_data",
                                      "raw_data_census.rds")

# save data
base::saveRDS(census_data, location_of_census_data)
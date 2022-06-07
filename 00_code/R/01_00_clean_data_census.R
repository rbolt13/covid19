#' Rename Census Data 
#' 
#' @description this file uses baseR to rename columns
#' which will be helpful for future joins. This file also 
#' removes " County, Oregon" from each cell which will make 
#' matching by county name easier. 
#' 
#' @return a .rds file with two census data sets.

# location of this file within the project
here::i_am("00_code/R/01_00_clean_data_census.R")

# location of census data
location_of_census_data <- here::here("01_data/raw_data",
                                      "raw_data_census.rds")

# census data
us_pop <- base::readRDS(location_of_census_data)[[1]]
or_pop <- base::readRDS(location_of_census_data)[[2]]

# function for census data with 'Name' and 'value' columns
census_rename <- function(census_data, name){
  base::names(census_data)[base::names(census_data) == 'NAME'] <- name
  base::names(census_data)[base::names(census_data) == 'value'] <- 'population'
  return(census_data)
}

# rename columns 
us_pop <- census_rename(us_pop, "state")
or_pop <- census_rename(or_pop, "county")

# remove " County, Oregon" from the county name
or_pop$county <- base::gsub(" County, Oregon", "", or_pop$county)

# list of clean census data 
clean_census_list <- list(us_pop,
                          or_pop)

# location of clean census data
location_of_clean_census_data <- here::here("01_data/clean_data",
                                            "clean_data_census.rds")

# save data
base::saveRDS(clean_census_list, location_of_clean_census_data)
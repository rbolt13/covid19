#' Clean Data
#' 
#' @description Cleans 5 data sets by:
#' 1. renaming tidycensus data columns
#' 2. removing " County, Oregon" from the county name in counties_covid_data
#' 3. join us_covid data with vacc data
#' 4. join us_join with us_pop
#' 5. join counties_covid with or_pop
#' 6. clean data
#'
#' @return returns two .rds data sets in the clean_data folder.

here::i_am("R/01_clean_data.R")

# libraries
library(magrittr)
library(dplyr)

# location of raw data
location_of_us_covid <- here::here("raw_data",
                                       "states_covid_data.rds")
location_of_counties_covid <- here::here("raw_data",
                                         "counties_covid_data.rds")
location_of_vacc <- here::here("raw_data",
                               "vacc_data.rds")
location_of_us_pop <- here::here("raw_data",
                                    "state_pop_data.rds")
location_of_or_pop <- here::here("raw_data",
                                 "or_pop_data.rds")
# data
us_covid <- base::readRDS(location_of_us_covid)
counties_covid <- base::readRDS(location_of_counties_covid)
vacc <- base::readRDS(location_of_vacc)
us_pop <- base::readRDS(location_of_us_pop)
or_pop <- base::readRDS(location_of_or_pop)

# 1. rename columns (for future join)
base::names(us_pop)[base::names(us_pop) == 'NAME'] <- 'state'
base::names(us_pop)[base::names(us_pop) == 'value'] <- 'population'
base::names(or_pop)[base::names(or_pop) == 'NAME'] <- 'county'
base::names(or_pop)[base::names(or_pop) == 'value'] <- 'or_population'

# 2. remove " County, Oregon" from the county name
or_pop$county <- base::gsub(" County, Oregon", "", or_pop$county)

# 3. join state covid data with vacc data
us_join <- us_covid %>%
  dplyr::select(date, 
         state, 
         cases, 
         deaths
         ) %>%
  dplyr::full_join(vacc %>%
                     dplyr::select(Province_State,
                                   Date,
                                   Lat, 
                                   Long_,
                                   People_Fully_Vaccinated,
                                   People_Partially_Vaccinated
                                   ),
            by = c("state" = "Province_State",
                   "date" = "Date")
            ) %>%
# 4. join state_join with state pop
  dplyr::select(date, 
                state, 
                cases, 
                deaths,
                Lat, 
                Long_,
                People_Fully_Vaccinated,
                People_Partially_Vaccinated
  ) %>%
  dplyr::full_join(us_pop %>%
                     dplyr::select(state,
                                   population
                                   ), 
            by = c("state" = "state")
            ) 

# 5. join counties covid data with or pop data
join_or <- counties_covid %>%
  dplyr::select(date,
                county,
                cases,
                deaths
                ) %>%
  dplyr::full_join(or_pop %>%
                     dplyr::select(county,
                                   or_population
                                   ),
            by = c("county" = "county")
  )

# 6. clean data
us_covid_clean <- us_join %>%
  # dplyr::summarise
  dplyr::summarise(
                  # Given
                   date = date,
                   state = state,
                   population = population,
                   cases = cases, 
                   deaths = deaths,
                   full_vacc = People_Fully_Vaccinated,
                   partial_vacc = People_Partially_Vaccinated,
                   # Population Percentages
                   cases_per_pop = cases/population,
                   deaths_per_pop = deaths/population,
                   full_vacc_per_pop = full_vacc/population,
                   partial_vacc_per_pop = partial_vacc/population
                   ) 
  # arrange
  

or_covid_clean <- join_or %>%
  dplyr::summarise(date = date,
                   county = county,
                   or_population = or_population,
                   cases = cases,
                   cases_per_pop = cases/or_population,
                   deaths = deaths,
                   deaths_per_pop = deaths/or_population
                   )
# location of cleaned data
location_of_us_clean <- here::here("clean_data",
                                   "us_covid_clean.rds")

location_of_or_clean <- here::here("clean_data",
                                   "or_covid_clean.rds")

# saved data
saveRDS(us_covid_clean, location_of_us_clean)
saveRDS(or_covid_clean, location_of_or_clean)
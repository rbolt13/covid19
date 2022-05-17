#' Clean Data
#' 
#' @description pulls in two lists of data sets: raw_data_list, and 
#' dates_list. 
#' 
#' Cleans 5 data sets by:
#' 
#' 
#' 
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

# Location of Data Lists: raw_data, and dates_data

  # raw data list
location_of_raw_data_list <- here::here("raw_data",
                                        "raw_data_list.rds")

  # date data list 
location_of_dates_list <- here::here("raw_data", "dates_list.rds")

# Save Data Lists, and Data Sets

  # save lists 
raw_data_list <- base::readRDS(location_of_raw_data_list)
dates_data_list <- base::readRDS(location_of_dates_list)

  # save raw dataset 
us_covid <- base::readRDS(location_of_raw_data_list)[[1]]
counties_covid <- base::readRDS(location_of_raw_data_list)[[2]]
vacc <- base::readRDS(location_of_raw_data_list)[[3]]
us_pop <- base::readRDS(location_of_raw_data_list)[[4]]
or_pop <- base::readRDS(location_of_raw_data_list)[[5]]

  # save us and counties data dates
us_data_date <- base::readRDS(location_of_dates_list)[[4]]
counties_data_date <- base::readRDS(location_of_dates_list)[[5]]

# Clean Data: us_clean and or_clean
  # rename columns (for future join)
base::names(us_pop)[base::names(us_pop) == 'NAME'] <- 'state'
base::names(us_pop)[base::names(us_pop) == 'value'] <- 'population'
base::names(or_pop)[base::names(or_pop) == 'NAME'] <- 'county'
base::names(or_pop)[base::names(or_pop) == 'value'] <- 'or_population'

  # remove " County, Oregon" from the county name
or_pop$county <- base::gsub(" County, Oregon", "", or_pop$county)

# Joins

  # join state covid data with vacc data
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
  # join state_join with state pop
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

  # join counties covid data with or pop data
join_or <- counties_covid %>%
  dplyr::filter(state == "Oregon") %>%
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

  # US
us_clean <- us_join %>%
     # dplyr::summarise
     dplyr::summarise(
                  # Given
                   Date = date,
                   State = state,
                   Population = population,
                   # Cases
                   Cases = cases, 
                   cases_per_pop = cases/population,
                   # Deaths
                   Deaths = deaths,
                   deaths_per_pop = deaths/population,
                   # Full Vacc
                   full_vacc = People_Fully_Vaccinated,
                   full_vacc_per_pop = full_vacc/population,
                   # Part Vacc
                   partial_vacc = People_Partially_Vaccinated, 
                   partial_vacc_per_pop = partial_vacc/population
                   ) 
  
# OR
or_clean <- join_or %>%
  # dplyr::summarise
  dplyr::summarise(Date = date,
                   County = county,
                   Population = or_population,
                   Cases = cases,
                   cases_per_pop = cases/or_population,
                   Deaths = deaths,
                   deaths_per_pop = deaths/or_population
                   )

# Current Data: us_current, and or_current  
  # filter by date of data 
us_current <- us_clean %>% filter(Date == us_data_date)
or_current <- or_clean %>%filter(Date == counties_data_date)

# New Data: new_cases, new_deaths, new_vacc
  # us
us_new <- "This is a placeholder"
  # or 
or_new <- us_clean %>% 
    # select 
  dplyr::select(Date, State, Cases, Deaths, full_vacc, partial_vacc) %>% 
    # filter by State == Oregon
  dplyr::filter(State == "Oregon") %>%
    # arrange by date
  dplyr::arrange(Date) %>%
    # calcualte new columns 
  dplyr::mutate(new_cases = Cases - lag(Cases, default = first(Cases)),
         new_deaths = Deaths - lag(Deaths, default = first(Deaths)),
         new_full_vacc = full_vacc - lag(full_vacc, default = first(full_vacc)),
         new_part_vacc = partial_vacc - lag(partial_vacc, default = first(partial_vacc)))


# List of clean data
clean_data_list <- list(us_clean,
                        or_clean,
                        us_current,
                        or_current,
                        us_new,
                        or_new)

# location of cleaned data list 
location_of_clean_data_list <- here::here("clean_data",
                                          "clean_data_list.rds")
# saved data
saveRDS(clean_data_list, location_of_clean_data_list)
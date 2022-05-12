#' Clean Data
#' 
#' @description Cleans 5 data sets by:
#' 1. renaming tidycensus data columns
#' 2. removing " County, Oregon" from the county name
#' 3. join us_covid data with vacc data
#' 4. join us_join with us_pop
#' 5. join counties_covid with or_pop
#' 6. clean data
#'
#' @return returns two .rds data sets in the clean_data folder.

here::i_am("R/01_clean_data")

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
us_covid <- readRDS(location_of_us_covid)
counties_covid <- readRDS(location_of_counties_covid)
vacc <- readRDS(location_of_vacc)
us_pop <- readRDS(location_of_us_pop)
or_pop <- readRDS(location_of_or_pop)

# 1. rename columns (for future join)
us_pop <- dplyr::rename("state" = NAME,
                           "population" = value)
or_pop <- dplyr::rename("county" = NAME,
                        "population" = value)

# 2. remove " County, Oregon" from the county name (for future join)
or_pop <- gsub(" County, Oregon", "", or_pop)

# 3. join state covid data with vacc data
us_join <- us_covid %>%
  select(date, 
         state, 
         cases, 
         deaths
         ) %>%
  full_join(vacc %>%
              select(Province_State,
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
  full_join(us_pop %>%
              select(state, 
                     population
                     ), 
            by = c("state" = "state")
            ) 

# 5. join counties covid data with or pop data
join_or <- counties_covid %>%
  select(date, 
         county, 
         cases, 
         deaths
         ) %>%
  full_join(select(county,
                   population),
            by = c("county" = "county")
  )

# 6. clean data
us_covid_clean <- us_join %>%
  summarise(date = date,
            state = state,
            population = population,
            cases = cases, 
            cases_per_pop = cases/population,
            deaths = deaths,
            deaths_per_pop = deaths/population,
            full_vacc = People_Fully_Cavvinated,
            full_vacc_per_pop = full_vacc/population,
            partial_vacc = People_Partially_Vaccinated,
            partial_vacc_per_pop = partial_vacc/population)

or_covid_clean <- join_or %>%
  summarise(date = date,
            county = county,
            population = population,
            cases = cases,
            cases_per_pop = cases/population,
            deaths = deaths,
            deaths_per_pop = deaths/population)

# location of cleaned data
location_of_us_clean <- here::here("clean_data",
                                      "us_covid_clean.rds")

location_of_or_clean <- here::here("clean_data",
                                   "or_covid_clean.rds")

# saved data
saveRDS(us_covid_clean, location_of_us_clean)
saveRDS(or_covid_clean, location_of_or_clean)
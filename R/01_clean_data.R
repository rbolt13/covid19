#' Clean Data
#' 
#' @description 
#'

here::i_am("R/01_clean_data")

library(dplyr)

# location of raw data
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
# data
states_covid <- readRDS(location_of_states_covid)
counties_covid <- readRDS(location_of_counties_covid)
vacc <- readRDS(location_of_vacc)
state_pop <- readRDS(location_of_state_pop)
or_pop <- readRDS(location_of_or_pop)

# rename columns (for future join)
state_pop <- dplyr::rename("state" = NAME,
                           "population" = value)
or_pop <- dplyr::rename("county" = NAME,
                        "population" = value)

# remove " County, Oregon" from the county name (for future join)
or_pop <- gsub(" County, Oregon", "", or_pop)

# join state covid data with vacc data
state_join <- states_covid %>%
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
# join state_join with state pop
  full_join(state_pop %>%
              select(state, 
                     population
                     ), 
            by = c("state" = "state")
            ) 

# join counties covid data with or pop data
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

# clean state data
us_covid_clean <- state_join %>%
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

# clean or data
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
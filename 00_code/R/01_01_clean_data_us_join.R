#' Join NYT State Covid data with vacc and us census data 
#' 
#' @description this file joins the raw NYT states covid data with 
#' the NYT raw vaccination data, and tidycensus clean census data.
#' 
#'  @return a .rds file with one df of Covid data by state. 

# location of this file within the project
here::i_am("00_code/R/01_01_clean_data_us_join.R")

# packages used
library(dplyr)
library(magrittr)

# location of data
location_of_clean_census <- here::here("01_data/clean_data",
                                       "clean_data_census.rds")
location_of_NYT_data <- here::here("01_data/raw_data",
                                   "raw_data_NYT.rds")

# data
us_pop <- base::readRDS(location_of_clean_census)[[1]]
us_covid <- base::readRDS(location_of_NYT_data)[[1]]
vacc <- base::readRDS(location_of_NYT_data)[[3]]

# join nyt covid data with vacc data
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
  # join  with state pop
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

# clean the join 
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

# location of us clean data
location_of_clean_us_data <- here::here("01_data/clean_data",
                                        "clean_data_us_covid.rds")

# save data
base::saveRDS(us_clean, location_of_clean_us_data)
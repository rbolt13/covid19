#' Join NYT Counties covid data with or census data
#' 
#' @description this file join the raw NYT counties data with 
#' the or population census data. 
#' 
#' @return a .reds file with one df of covid data by or county. 

# location of this file within the project
here::i_am("00_code/R/01_02_clean_data_or_join.R")

# packages used
library(dplyr)
library(magrittr)

# location of data
location_of_clean_census <- here::here("01_data/clean_data",
                                       "clean_data_census.rds")
location_of_NYT_data <- here::here("01_data/raw_data",
                                   "raw_data_NYT.rds")

# data
or_pop <- base::readRDS(location_of_clean_census)[[2]]
or_covid <- base::readRDS(location_of_NYT_data)[[2]]

# join nyt covid data with census data
join_or <- or_covid %>%
  dplyr::filter(state == "Oregon") %>%
  dplyr::select(date,
                county,
                cases,
                deaths
  ) %>%
  dplyr::full_join(or_pop %>%
                     dplyr::select(county,
                                   population
                     ),
                   by = c("county" = "county")
  )

# clean join_or
or_clean <- join_or %>%
  # dplyr::summarise
  dplyr::summarise(Date = date,
                   County = county,
                   Population = population,
                   Cases = cases,
                   cases_per_pop = cases/population,
                   Deaths = deaths,
                   deaths_per_pop = deaths/population
  )

# location of us clean data
location_of_clean_or_data <- here::here("01_data/clean_data",
                                        "clean_data_or_covid.rds")

# save data
base::saveRDS(or_clean, location_of_clean_or_data)
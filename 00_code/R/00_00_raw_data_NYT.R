#' Save NYT Raw Data
#' 
#' @description this file uses the readr package to save the 
#' following three data sets from the NYT's github repository: 
#' 1. Covid data by state 
#' 2. Covid data by county 
#' 3. Vaccination Data
#' Then it uses the dyplr package to extract the most current 
#' date for the data of the states and counties data.
#' 
#' @return a .RDS file with a list of three data sets. 

# location of this file within project
here::i_am("00_code/R/00_00_raw_data_NYT.R")

# packages 
library(readr)
library(dplyr)

# read datasets
states_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
counties_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
vacc_data <- readr::read_csv("https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/us_data/time_series/people_vaccinated_us_timeline.csv")

# extract most recent date of data
us_data_date_find <- dplyr::arrange(states_covid_data, desc(date))[1,1]
counties_data_date_find <- dplyr::arrange(counties_covid_data, desc(date))[1,1]

# data dates 
us_data_date <- us_data_date_find$date
counties_data_date <- counties_data_date_find$date

# save data into list
NYT_data <- list(states_covid_data,
                 counties_covid_data,
                 vacc_data,
                 us_data_date,
                 counties_data_date)

# location of saved data 
location_of_NYT_data <- here::here("01_data/raw_data",
                                    "raw_data_NYT.rds")

# save data 
base::saveRDS(NYT_data, location_of_NYT_data)
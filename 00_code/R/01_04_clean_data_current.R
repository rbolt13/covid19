#' Current Data
#' 
#' @description this file uses the clean covid data, clean dates 
#' datat and R packages dplyr and magrittr to sort the covid data 
#' by date. This will be helpful for future analysis and 
#' visualization. 
#' 
#' @return a .rds file with a list of two datasets

# location of this file within the covid19 project
here::i_am("00_code/R/01_04_clean_data_current.R")

# packages used
library(magrittr)
library(dplyr)

# location of data
location_of_us_covid <- here::here("01_data/clean_data",
                                   "clean_data_us_covid.rds")
location_of_or_covid <- here::here("01_data/clean_data",
                                   "clean_data_or_covid.rds")
location_of_dates_data <- here::here("01_data/clean_data",
                                     "clean_data_dates.rds")

# save data 
us_clean <- base::readRDS(location_of_us_covid)
or_clean <- base::readRDS(location_of_or_covid)
us_data_date <- base::readRDS(location_of_dates_data)[[4]]
or_data_date <- base::readRDS(location_of_dates_data)[[5]]

# filter by date of data 
us_current <- us_clean %>% filter(Date == us_data_date)
or_current <- or_clean %>%filter(Date == or_data_date)

# current list
current_data <- list(us_current,
                     or_current)

# location of current data
location_of_current_data <- here::here("01_data/clean_data",
                                       "clean_data_current.rds")

# save data
base::saveRDS(current_data, location_of_current_data)
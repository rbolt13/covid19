#' New Data
#' 
#' @description this file uses the clean covid data, and R
#' packages magrittr and dplyr to calculate how many "new"
#' cases, deaths, and vacc there are a day. 
#' 
#' @return a .rds file with a list of two df: 
#' us_new, and or_new

# location of this file
here::i_am("00_code/R/01_05_clean_data_new.R")

# packages used
library(magrittr)
library(dplyr)

# location of data
location_of_us_covid <- here::here("01_data/clean_data",
                                   "clean_data_us_covid.rds")
location_of_or_covid <- here::here("01_data/clean_data",
                                   "clean_data_or_covid.rds")

# save data 
us_clean <- base::readRDS(location_of_us_covid)
or_clean <- base::readRDS(location_of_or_covid)

# us_new Data 
us_new <- "This is a placeholder, but or_new works just fine :D"

# or_new Data
or_new <- us_clean %>% 
  # select 
  dplyr::select(Date, State, Cases, Deaths, full_vacc, partial_vacc) %>% 
  # filter by State == Oregon
  dplyr::filter(State == "Oregon") %>%
  # arrange by date
  dplyr::arrange(Date) %>%
  # calculate new columns 
  dplyr::mutate(new_cases = Cases - lag(Cases, default = first(Cases)),
                new_deaths = Deaths - lag(Deaths, default = first(Deaths)),
                new_full_vacc = full_vacc - lag(full_vacc, default = first(full_vacc)),
                new_part_vacc = partial_vacc - lag(partial_vacc, default = first(partial_vacc)))

# new data list
new_data <- list(us_new,
                 or_new)

# loaction of new data
location_of_new_data <- here::here("01_data/clean_data",
                                   "clean_data_new.rds")

# save data
base::saveRDS(new_data, location_of_new_data)
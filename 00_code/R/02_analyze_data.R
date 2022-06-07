#' Analyze Data
#' 
#' @description 
#' 
#' @return 2 lists of data:
#' 

here::i_am("R/02_analyze_data.R")

# libraries
library(dplyr)
library(magrittr)

# load data 
# current data 
us_current <- base::readRDS(here::here("clean_data", "clean_data_list.rds"))[[3]]
or_current <- base::readRDS(here::here("clean_data", "clean_data_list.rds"))[[4]]

# function that subsets current data 
subset_data <- function(data, var1, var2){
  df <- data %>%
    select(var1, var2) 
  return(df)
}

# subset data 
us_cases <- subset_data(us_current, "State", "Cases")
us_cases_per <- subset_data(us_current, "State", "cases_per_pop")
us_deaths <- subset_data(us_current, "State", "Deaths")
us_deaths_per <- subset_data(us_current, "State", "deaths_per_pop")
us_full_vacc <- subset_data(us_current, "State", "full_vacc")
us_full_vacc_per <- subset_data(us_current, "State", "full_vacc_per_pop")
us_part_vacc <- subset_data(us_current, "State", "partial_vacc")
us_part_vacc_per <- subset_data(us_current, "State", "partial_vacc_per_pop")

or_cases <- subset_data(or_current, "County", "Cases")
or_cases_per <- subset_data(or_current, "County", "cases_per_pop")
or_deaths <- subset_data(or_current, "County", "Deaths")
or_deaths_per <- subset_data(or_current, "County", "deaths_per_pop")

# arrange data 
us_cases <- us_cases %>% arrange(desc(Cases))
us_cases_per <- us_cases_per %>% arrange(desc(cases_per_pop))
us_deaths <- us_deaths %>% arrange(desc(Deaths))
us_deaths_per <- us_deaths_per %>% arrange(desc(deaths_per_pop))
us_full_vacc <- us_full_vacc %>% arrange(desc(full_vacc))
us_full_vacc_per <- us_full_vacc_per %>% arrange(desc(full_vacc_per_pop))
us_part_vacc <- us_part_vacc %>% arrange(desc(partial_vacc))
us_part_vacc_per <- us_part_vacc_per %>% arrange(desc(partial_vacc_per_pop))

or_cases <- or_cases %>% arrange(desc(Cases))
or_cases_per <- or_cases_per %>% arrange(desc(cases_per_pop))
or_deaths <- or_deaths %>% arrange(desc(Deaths))
or_deaths_per <- or_deaths_per %>% arrange(desc(deaths_per_pop))

# format data with commas
us_cases$Cases <-  base::prettyNum(us_cases$Cases, big.mark = ",")
us_deaths$Deaths <- base::prettyNum(us_deaths$Deaths, big.mark = ",")
us_full_vacc$full_vacc <- base::prettyNum(us_full_vacc$full_vacc, big.mark = ",")
us_part_vacc$partial_vacc <- base::prettyNum(us_part_vacc$partial_vacc, big.mark = ",")

or_cases$Cases <-  base::prettyNum(or_cases$Cases, big.mark = ",")
or_deaths$Deaths <- base::prettyNum(or_deaths$Deaths, big.mark = ",")

# format data with % sign 
us_cases_per$cases_per_pop <- base::sprintf("%0.2f%%", us_cases_per$cases_per_pop*100)
us_deaths_per$deaths_per_pop <- base::sprintf("%0.2f%%", us_deaths_per$deaths_per_pop*100)
us_full_vacc_per$full_vacc_per_pop <- base::sprintf("%0.2f%%", us_full_vacc_per$full_vacc_per_pop*100)
us_part_vacc_per$partial_vacc_per_pop <- base::sprintf("%0.2f%%", us_part_vacc_per$partial_vacc_per_pop*100)

or_cases_per$cases_per_pop <- base::sprintf("%0.2f%%", or_cases_per$cases_per_pop*100)
or_deaths_per$deaths_per_pop <- base::sprintf("%0.2f%%", or_deaths_per$deaths_per_pop*100)

# put in one list 
us_list <- list(us_cases,
                us_cases_per,
                us_deaths,
                us_deaths_per,
                us_full_vacc,
                us_full_vacc_per,
                us_part_vacc,
                us_part_vacc_per)

or_list <- list(or_cases,
                or_cases_per,
                or_deaths,
                or_deaths_per)

# location of list
location_of_us_list <- here::here("clean_data",
                                  "us_list.rds")
location_of_or_list <- here::here("clean_data",
                                  "or_list.rds")
# save things
saveRDS(us_list, location_of_us_list)
saveRDS(or_list, location_of_or_list)

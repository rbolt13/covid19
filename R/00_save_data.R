here::i_am("R/00_save_data.R")

# 1. US States 
us_states_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

saveRDS(us_states_covid_data, "raw_data/us_states_covid_data.rds")

# 2. US Counties
us_counties <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

saveRDS(us_counties, "raw_data/us_counties.rds")

# 3. Colleges



# 4. Mask Use



# 5. Vacc
vacc <- readr::read_csv("https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/us_data/time_series/people_vaccinated_us_timeline.csv")

saceRDS(vacc, "raw_data/vacc.rds")

# 6. Policy Tracker OR




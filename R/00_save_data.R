here::i_am("R/00_save_data.R")

# Read Data
us_states_covid_data <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")
us_counties <- readr::read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
vacc <- readr::read_csv("https://raw.githubusercontent.com/govex/COVID-19/master/data_tables/vaccine_data/us_data/time_series/people_vaccinated_us_timeline.csv")


# save data list
data_list <- list(us_states_covid_data, us_counties, vacc)
saceRDS(data_list, "raw_data/data.rds")
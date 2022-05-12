# load data 
raw_data/load_data:: R/00_save_data.R
	Rscript R/00_save_data.R

# clean data
raw_data/clean_data:: R/01_clean_data.R raw_data/counties_covid_data.rds raw_data/or_pop_data.rds raw_data/state_pop_data.rds raw_data/states_covid_data.rds raw_data/vacc_data.rds
	Rscript R/01_clean_data.R
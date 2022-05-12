# load data 
raw_data/load_data:: R/00_save_data.R
	Rscript R/00_save_data.R

# clean data
raw_data/clean_data:: R/01_clean_data.R raw_data/counties_covid_data.rds raw_data/or_pop_data.rds raw_data/state_pop_data.rds raw_data/states_covid_data.rds raw_data/vacc_data.rds
	Rscript R/01_clean_data.R
	
# analyze data 
output/analyze_data:: R/00_save_data.R R/01_clean_data.R R/02_analyze_data.R clean_data/or_covid_clean.rds clean_data/us_covid_clean.rds
	Rscript R/02_analyze_data.R
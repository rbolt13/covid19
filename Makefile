# load data 
raw_data/load_data:: R/00_save_data.R
	Rscript R/00_save_data.R

# clean data
raw_data/clean_data:: R/01_clean_data.R raw_data/raw_data_list.rds raw_data/dates_list.rds
	Rscript R/01_clean_data.R
	
# analyze data 
output/analyze_data:: R/00_save_data.R R/01_clean_data.R R/02_analyze_data.R raw_data/dates_list.rds clean_data/clean_data_list.rds
	Rscript R/02_analyze_data.R
	
# make figures 
figs/make_figs:: R/00_save_data.R R/01_clean_data.R R/03_figs.R clean_data 
	Rscript R/03_figs.R
	
# print report 
report:: R/00_save_data.R R/01_clean_data.R R/02_analyze_data.R Rmd/report.Rmd raw_data/dates_list.rds clean_data/clean_data_list.rds clean_data/or_list.rds clean_data/us_list.rds 
	Rscript -e "rmarkdown::render('Rmd/report.Rmd')"
all/raw: raw/nyt_data raw/dates_data

all/clean: clean/census_data clean/us_join clean/or_join clean/dates clean/current clean/new

# raw data -------------------------------------
raw/nyt_data: 00_code/R/00_00_raw_data_NYT.R
	Rscript 00_code/R/00_00_raw_data_NYT.R

raw/dates_data: 00_code/R/00_02_raw_data_dates.R
	Rscript 00_code/R/00_02_raw_data_dates.R
	
# update in 2024 or 2929
raw/census_data: 00_code/R/00_01_raw_data_census.R
	Rscript 00_code/R/00_01_raw_data_census.R

# clean data ---------------------------------------
clean/census_data: 00_code/R/01_00_clean_data_census.R 01_data/raw_data/raw_data_census.rds
	Rscript 00_code/R/01_00_clean_data_census.R

clean/us_join: 00_code/R/01_01_clean_data_us_join.R 
	Rscript 00_code/R/01_01_clean_data_us_join.R

clean/or_join: 00_code/R/01_02_clean_data_or_join.R 
	Rscript 00_code/R/01_02_clean_data_or_join.R
	
clean/dates: 00_code/R/01_03_clean_data_dates.R 
	Rscript 00_code/R/01_03_clean_data_dates.R
	
clean/current: 00_code/R/01_04_clean_data_current.R 
	Rscript 00_code/R/01_04_clean_data_current.R
	
clean/new: 00_code/R/01_05_clean_data_new.R 
	Rscript 00_code/R/01_05_clean_data_new.R

# make report
report: Rmd/report.Rmd figs/table.png 
	cd Rmd; Rscript -e "rmarkdown::render('report.Rmd', output_file = '../output/report.html')"
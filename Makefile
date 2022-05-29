# make report
report: Rmd/report.Rmd figs/table.png 
	cd Rmd; Rscript -e "rmarkdown::render('report.Rmd', output_file = '../output/report.html')"
	
# make figures
figs/table.png: R/03_figs.R 
	Rscript R/03_figs.R

# clean data
raw_data/clean_data: R/01_clean_data.R raw_data/raw_data_list.rds
	Rscript R/01_clean_data.R
	
# load data 
raw_data/load_data: R/00_save_data.R
	Rscript R/00_save_data.R
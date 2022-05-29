#' Figures
#' 
#' @description This file 
#'
#' @return returns 

# This is where you are in the project. 
here::i_am("R/03_figs.R")

# Get enviroment variable to determine which report to make
which_report <- base::Sys.getenv("which_report")

# These are the libraries you will need
library(dplyr)
library(gtable)

# This is where the clean_data is located 
location_of_clean_data_list <- here::here("clean_data",
                                        "clean_data_list.rds")

# This saves the raw_data list to a variable "raw_data_list".
raw_data_list <- base::readRDS(location_of_clean_data_list)

# if/ elese statement that ssts variables for table 
if(which_report == "us_report"){
  
}

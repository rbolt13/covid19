#' Figures
#' 
#' @description This file creates all the figures in this project.
#' 
#' 03_00: location of this file within the project
#' 03_01: load libraries
#' 03_02: function to locate and save data
#' 03_03: locate and save data: date_data, us_current
#' 03_04: function that creates reactable table of current data
#' 03_05: save table of us_current
#' 03_06: location of figures
#' 03_07: save data
#'
#' @return returns two .rds data sets in the clean_data folder.

# 03_00: location of this file within the project
here::i_am("R/03_figs.R")

# 03_01: load libraries 
library(dplyr)
library(reactable)

# 03_02: function to locate and save data
locate_and_save_data <- function(file_name){
  locate_data <- here::here("clean_data", file_name)
  save_data <- base::readRDS(locate_data)
  return(save_data)
}

# 03_03: locate and save data: date_data, us_current
date_data <- locate_and_save_data("date_data.rds")
us_current <- locate_and_save_data(paste0("us_",date_data,".rds"))

# 03_04: function that creates reactable table of current data
make_reactable <- function(data_set){
  table <- reactable(data_set %>% dplyr::select(!Date
  ),
  columns = list(
    Population = colDef(format = colFormat(separators = TRUE)),
    Cases = colDef(format = colFormat(separators = TRUE)),
    cases_per_pop = colDef(name = "Percent of Cases",
                           format = colFormat(percent = TRUE,
                                              digits = 2)),
    Deaths = colDef(format = colFormat(separators = TRUE)),
    deaths_per_pop = colDef(name = "Percent of Deaths",
                            format = colFormat(percent = TRUE,
                                               digits = 2)),
    full_vacc = colDef(name = "Fully Vaccinated",
                       format = colFormat(separators = TRUE)),
    full_vacc_per_pop = colDef(name = "Percent Fully Vaccinated",
                               format = colFormat(percent = TRUE,
                                                  digits = 2)),
    partial_vacc = colDef(name = "Partially Vaccinated",
                          format = colFormat(separators = TRUE)),
    partial_vacc_per_pop = colDef(name = "Percent Partially Vaccinated",
                                  format = colFormat(percent = TRUE,
                                                     digits = 2))
  ),
  defaultSorted = list(Cases = "desc"),
  bordered = TRUE,
  highlight = TRUE,
  showPageSizeOptions = TRUE,
  pageSizeOptions = c(5, 10, 20, 50),
  defaultPageSize = 5)
  return(table)
}

# 03_05: save table of us_current 
us_current_table <- make_reactable(us_current)

# 03_06: location of figures
location_of_us_current_table <- here::here("figs",
                                           paste0("us_",date_data, "_reactable.rds"))

# 03_07: save data 
saveRDS(us_current_table, location_of_us_current_table)
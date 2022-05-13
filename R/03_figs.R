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
here::i_am("R/02_figs.R")

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
make_reactable <- base::function(data_set){
  # create table 
  r_table <- reactable::reactable(data_set %>% 
                                    # remove Date column
                                    dplyr::select(!Date),
                                  columns = base::list(
                                    Population = reactable::colDef(format = reactable::colFormat(separators = TRUE)),
                                    Cases = reactable::colDef(format = reactable::colFormat(separators = TRUE)),
                                    cases_per_pop = reactable::colDef(name = "Percent of Cases",
                                                           format = reactable::colFormat(percent = TRUE,
                                                                              digits = 2)),
                                    Deaths = reactable::colDef(format = reactable::colFormat(separators = TRUE)),
                                    deaths_per_pop = reactable::colDef(name = "Percent of Deaths",
                                                            format = reactable::colFormat(percent = TRUE,
                                                                               digits = 2)),
                                    full_vacc = reactable::colDef(name = "Fully Vaccinated",
                                                       format = reactable::colFormat(separators = TRUE)),
                                    full_vacc_per_pop = reactable::colDef(name = "Percent Fully Vaccinated",
                                                               format = reactable::colFormat(percent = TRUE,
                                                                                  digits = 2)),
                                    partial_vacc = reactable::colDef(name = "Partially Vaccinated",
                                                          format = reactable::colFormat(separators = TRUE)),
                                    partial_vacc_per_pop = reactable::colDef(name = "Percent Partially Vaccinated",
                                                                  format = reactable::colFormat(percent = TRUE,
                                                                                     digits = 2))
  ),
  reactable::defaultSorted = list(Cases = "desc"),
  reactable::bordered = TRUE,
  reactable::highlight = TRUE,
  reactable::showPageSizeOptions = TRUE,
  reactable::pageSizeOptions = c(5, 10, 20, 50),
  reactable::defaultPageSize = 5)
  return(r_table)
}

# 03_05: save table of us_current 
us_current_table <- make_reactable(us_current)

# 03_06: location of figures
location_of_us_current_table <- here::here("figs",
                                           paste0("us_",date_data, "_reactable.rds"))

# 03_07: save data 
saveRDS(us_current_table, location_of_us_current_table)
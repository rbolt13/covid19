here::i_am("R/01_clean_data")


# rename files
state_pop <- rename("state" = NAME,
                    "population" = value)
state_den_data <- rename ("state" = NAME, 
                          "density" = value)
or_pop_data <- rename ("county" = NAME, 
                       "population" = value)
or_den_data <- rename ("county" = NAME, 
                       "density" = value)
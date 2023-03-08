# COVID-19 Analysis with R

This repository contains an analysis of COVID-19 data using R and presented with Quarto Docs and Netlify. The goal of this analysis is to explore the COVID-19 data to understand the trend of the pandemic and the impact of the virus on different countries an regions. 

## Data

The data used in this analysis is obtained from the New York Times github repository, [Coronavirus (Covid-19) Data in the United States](https://github.com/nytimes/covid-19-data/blob/master/README.md). This data set includes information on COVID-19 cases, and deaths. The [tidycensus](https://walker-data.com/tidycensus/) packages is also used to gather data on state and county populations. 

## Analysis

The analysis is done using R programming language and R packages such as tidyverse, tidycensus, and plotly. The set up code for this analysis can be found in the setup.qmd file, while the analysis itself can be found in the analysis.qmd file in this repository. 

The analysis covers the following topics:

* Overview of COVID-19 cases, case percent, deaths, and deaths percent. 

* Comparison of the COVID-19 impact on different states and counties in Oregon. 

* Interactive time series analysis.

* Interactive map. 

## Presentation 

This analysis is presented using Quarto, a powerful tool for generating reproducible documents in R. The .qmd files in the repository contain the code for generating the HTML documents.  

## Deployment

The HTML documents are deployed using Netlify, a cloud-based platform for web development. The document is automatically deployed whenever changes are pushed to the repository's main branch. 

The dployed HTML documents can be accessed through the following link [here](). 

## Conclusion 

This analysis provide insights into the COVID-19 pandemic and its impact on differenct states and counties in Oregon. The use of R, Quarto, and Nelify ensures that the analysis is reporducible, transparent, and easily accessible. 
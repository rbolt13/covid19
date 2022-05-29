# first draft, not tested
FROM rocker/tidyverse
# install packages
RUN Rscript -e install.packages("reactable")
# make a project directory
RUN mkdir /project/
# copy contents of local folder to container 
COPY ./ /project/
# make Rscript executable
RUN chmod +x /project/R/*.R
# set enviroment variable
ENV which_fig="us"
# make project the working directory 
WORKDIR /project
# make container entry point absh
CMD make report
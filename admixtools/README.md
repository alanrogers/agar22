# Admixtools

For Robert.

## Installing AdmixTools under the R command line

    install.packages("devtools")
    install.packages("usethis")
    library(devtools)
    library(usethis)
    devtools::install_github("uqrmaie1/admixtools")
	library(admixtools)

Then:

    install.packages("shiny")
    install.packages("htmlwidgets")
    install.packages("shinythemes")
    install.packages("plotly")
    install.packages("tidyverse")
    install.packages("shinyjs")
    install.packages("shinyBS")
    install.packages("shinyFiles")
    install.packages("shinyalert")
    install.packages("shinyWidgets")
    install.packages("shinydashboard")

After these packages have been installed, then this works:

    admixtools::run_shiny_admixtools()

[Tutorial](https://uqrmaie1.github.io/admixtools/articles/admixtools.html)

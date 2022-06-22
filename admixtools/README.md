# Admixtools

* [Tutorial](https://uqrmaie1.github.io/admixtools/articles/admixtools.html)

## Installing AdmixTools under the R command line

    install.packages("devtools")
    install.packages("usethis")
    library(devtools)
    library(usethis)
    devtools::install_github("uqrmaie1/admixtools")

These commands only need to be run once. They install packages onto
your computer's hard disk. Once they're installed, the following
command will work:

	library(admixtools)

This will allow you to use admixtools from R's command line interface,
or in an R program. If you want to use the browser interface, you'll
need to install additional packages:

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

After these have been installed, then this launches the browser
interface: 

    admixtools::run_shiny_admixtools()


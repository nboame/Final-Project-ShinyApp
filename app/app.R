library(shiny)
library(dplyr)

beers <- readRDS("beer_data_loc_all.rds")

ui <- navbarPage("TravelBeeR",
                 tabPanel("Legal Drinking Age"),
                 tabPanel("Beer Map"))

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
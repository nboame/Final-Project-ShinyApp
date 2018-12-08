library(shiny)
library(dplyr)
library(markdown)

#beers <- readRDS("beer_data_loc_all.rds")

ui <- navbarPage("TravelBeeR",
           tabPanel("Legal Drinking Age",
                    sidebarLayout(
                      sidebarPanel(
                        dateInput("birthdate", "Enter your date of birth (yyyy-mm-dd): ")
                      ),
                      mainPanel(
                        plotOutput("plot")
                      )
                    )
           ),
           tabPanel("Beer Map",
                    sidebarLayout(
                      sidebarPanel(
                        selectInput("beerstyle", "Select your preferred beer style: ", 
                                    c("Ale", "Lager", "Stout")
                        )),
                        mainPanel(
                        plotOutput("plot")
                      )
                    )
           )
)


server <- function(input, output) {}

shinyApp(ui = ui, server = server)
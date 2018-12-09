library(shiny)
library(dplyr)
library(markdown)

#data <- readRDS("beer_data_loc_all.rds")

ui <- navbarPage(strong("TravelBeeR"),
           tabPanel("Legal Drinking Age",
                    sidebarLayout(
                      sidebarPanel(
                        dateInput("birthdate", "Enter your date of birth (yyyy-mm-dd): ")
                      ),
                      mainPanel(
                        plotOutput("plot"),
                        tableOutput("table")
                      )
                    )
           ),
           tabPanel("Beer Map",
                    sidebarLayout(
                      sidebarPanel(
                        uiOutput("styleOutput")
                        ),
                        mainPanel(
                          leafletOutput("beer_map")
                      )
                    )
           )
)


server <- function(input, output) {
  filtered <- reactive({
    if (is.null(input$styleInput)) {
      return(NULL)
    } 
    
    data %>%
      filter(UT_sub_style == input$styleInput)
  })
  
  output$beer_map <- renderLeaflet(
    filtered() %>%
      leaflet(options = leafletOptions(minZoom = 1, dragging = TRUE)) %>%
      addProviderTiles("CartoDB") %>%
      addCircleMarkers(lng = ~lon, 
                       lat = ~lat,
                       popup = ~paste0("<b>", UT_beer_name, "</b>", 
                                       "<br/>", UT_sub_style,
                                       "<br/>", UT_brewery),
                       radius = 3,
                       color = "green"))
    
    output$styleOutput <- renderUI({
      selectInput("styleInput", "Beer Style",
                  sort(unique(data$UT_sub_style),
                  selected = "IPA - Red"))
    })
}

shinyApp(ui = ui, server = server)
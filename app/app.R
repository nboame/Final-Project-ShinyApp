library(shiny)
library(dplyr)
library(markdown)

#complete_data <- readRDS("beer_data_loc_all.rds")

complete_data$UT_sub_style <- as.character(complete_data$UT_sub_style)

pal <- colorNumeric(
  palette = "YlOrRd",
  domain = c(0:5))


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
                        uiOutput("styleOutput"),
                        radioButtons("pointDisplay", "Show results as: ", 
                                     c("Points", "Clusters"), selected = "Clusters")
                        ),
                        mainPanel(
                          leafletOutput("beer_map")
                      )
                    )
           )
)


server <- function(input, output) {
  filtered <- reactive({
    if (input$styleInput == "-- ALL STYLES --") {
      return(complete_data)
    } 
    
    complete_data %>%
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
                                       "<br/>", UT_brewery,
                                       "<br/>", country),
                       radius = 2,
                       color = ~pal(UT_rating)) %>%
      addLegend(pal = pal, 
                opacity = 0.5,
                values = c(0:5),
                title = "Untappd Rating",
                position = "bottomright",
                bins = 5))
    
    output$styleOutput <- renderUI({
      selectInput("styleInput", "Beer Style",
                  c("-- ALL STYLES --", sort(unique(complete_data$UT_sub_style))),
                  selected = "-- ALL STYLES --")
    })
}

shinyApp(ui = ui, server = server)
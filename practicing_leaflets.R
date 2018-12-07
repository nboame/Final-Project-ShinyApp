library(leaflet)

leaflet(options = leafletOptions(minZoom = 1, dragging = TRUE)) %>%
  addProviderTiles("CartoDB") %>%
  # If we don't use setView and use addMarkers it will automatically zoom to include all marked points
  setView(lng = -52.7126, lat = 47.5615, zoom = 1) 

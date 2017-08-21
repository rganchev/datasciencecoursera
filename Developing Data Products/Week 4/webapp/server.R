library(shiny)
library(leaflet)
library(rgdal)

shinyServer(function(input, output) {
    population <- read.csv("data/population.csv")
    population$STUSPS = state.abb[match(population$State, state.name)]
    population$STUSPS[population$State == "District of Columbia"] = "DC"
    population$STUSPS[population$State == "Puerto Rico"] = "PR"
    states <- readOGR("data/shape", "cb_2016_us_state_20m")
    states <- merge(states, population, by = "STUSPS")
    allPopulations <- c(population$X2010, population$X2011, population$X2012, population$X2013, population$X2014, population$X2015, population$X2016)
    pal <- colorNumeric("YlOrRd", allPopulations)
    
    pop <- reactive({
        states[[paste0("X", input$year)]]
    })
    output$popMap <- renderLeaflet({
        states %>%
            leaflet() %>%
            addTiles() %>%
            addPolygons(color = "#444444",
                        weight = 1,
                        smoothFactor = 0.5,
                        opacity = 1.0,
                        fillOpacity = 0.5,
                        fillColor = pal(pop()),
                        label = ~paste0(State, " - ", format(pop(), big.mark = ",")),
                        highlightOptions = highlightOptions(color = "white",
                                                            weight = 2,
                                                            bringToFront = TRUE)) %>%
            addLegend("bottomright", pal = pal, values = allPopulations, title = "Population") %>%
            setView(lat = 39, lng = -89, zoom = 3)
    })
    
    output$popTable <- renderTable({
        df <- data.frame(State=states$State, Population=pop())
        df[order(df$Population, decreasing = TRUE),]
    })
    
    observeEvent(input$popMap_shape_click, {
        pt <- SpatialPoints(cbind(input$popMap_shape_click$lng,
                                  input$popMap_shape_click$lat),
                            proj4string = CRS("+proj=longlat +datum=NAD83 +no_defs +ellps=GRS80 +towgs84=0,0,0"))
        state <- over(pt, states)
        if (!is.na(state$STUSPS)) {
            years <- 2010:2016
            yearlyPop <- c(state$X2010, state$X2011, state$X2012, state$X2013, state$X2014, state$X2015, state$X2016)
            output$popPlot <- renderPlot({
                plot(years, yearlyPop, type="l", col="red", lwd=2, yaxt="n",
                     main = paste("Population Trend for", state$State),
                     xlab = "Year",
                     ylab = "Population")
                legend("bottomright",
                       legend = c("Population", "Regression Line"),
                       lty = c(1, 1),
                       lwd = c(2, 2),
                       col = c("red", "blue"))
                axis(2, at=axTicks(2), labels=sprintf("%.2fM", axTicks(2) / 1000000))
                abline(lm(yearlyPop ~ years), col="blue", lwd=2)
            })
        }
    })
})

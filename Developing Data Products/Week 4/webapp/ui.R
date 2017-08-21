#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("US State Population"),
  tags$head(
      tags$style(
          HTML("#popTable { height: 50vh; overflow-y: auto; }" ))),
  
  p(HTML(paste("This page contains an interactive map of the population trends in all US states for the last 7 years (2010-2016).",
          "The data is taken from <a href='https://www.census.gov/data/tables/2016/demo/popest/nation-total.html'>www.census.gov</a>."))),
  p(HTML(paste("The left panel allows the user to select the year for which data is to be displayed.",
               "When the year is selected, the population table below the slider is updated automatically to reflect the estimated population in all states for that year.",
               "The map is also updated to display the corresponding population when hovering over a state."))),
  p(HTML(paste("Users can also click on states on the map. Selecting a state displays the population trend for that state underneath the map.",
               "The plot contains a visualization of the population amount for each of the years 2010-2016 and also includes a regression line,",
               "representing the population trend."))),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("year",
                   "Year:",
                   min = 2010,
                   max = 2016,
                   value = 2016,
                   ticks = FALSE),
       tableOutput("popTable")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       leafletOutput("popMap"),
       plotOutput("popPlot")
    )
  )
))
